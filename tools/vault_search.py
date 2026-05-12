#!/usr/bin/env python3
"""
vault_search.py — semantic search over the operator's vault.

Searches all .md and .txt files in the current directory (recursive) by meaning.
Uses sentence-transformers locally for embeddings (no API call needed, fully offline).
Falls back to ripgrep keyword search if sentence-transformers isn't installed.

Usage:
    python tools/vault_search.py "your query"
    python tools/vault_search.py --rebuild
    python tools/vault_search.py "your query" --top 10

The first run builds an index (~10s for a small vault). Subsequent searches use the
cached index at .vault-index/. The index is gitignored.

Arguments:
    query           Free-text query (semantic or keyword)
    --top N         Number of results to return (default 5)
    --rebuild       Force rebuild of the index
    --vault PATH    Vault root (default: current directory)
"""

import argparse
import json
import os
import sys
from pathlib import Path

INDEX_DIR = ".vault-index"
INDEX_FILE = "embeddings.npy"
META_FILE = "meta.json"
DEFAULT_TOP_K = 5
EXTENSIONS = (".md", ".txt", ".yaml", ".yml")
EXCLUDE_DIRS = {".git", ".venv", "venv", "node_modules", ".tmp", "__pycache__", ".vault-index"}


def collect_files(vault_root: Path):
    """Walk vault, return list of (path, content) tuples."""
    files = []
    for path in vault_root.rglob("*"):
        if not path.is_file():
            continue
        if any(excl in path.parts for excl in EXCLUDE_DIRS):
            continue
        if path.suffix not in EXTENSIONS:
            continue
        try:
            content = path.read_text(encoding="utf-8", errors="ignore")
            if content.strip():
                files.append((str(path.relative_to(vault_root)), content))
        except Exception:
            continue
    return files


def search_keyword(vault_root: Path, query: str, top_k: int):
    """Fallback search via ripgrep."""
    import subprocess

    try:
        result = subprocess.run(
            ["rg", "--no-heading", "--with-filename", "-i", "-C", "2", query, str(vault_root)],
            capture_output=True, text=True, timeout=10,
        )
    except (FileNotFoundError, subprocess.TimeoutExpired):
        # Final fallback: pure Python grep
        return python_grep(vault_root, query, top_k)

    if result.returncode == 0:
        return parse_rg_output(result.stdout, top_k)
    return []


def python_grep(vault_root: Path, query: str, top_k: int):
    """Last-resort plain-Python keyword search."""
    files = collect_files(vault_root)
    matches = []
    q_lower = query.lower()
    for path, content in files:
        if q_lower in content.lower():
            score = content.lower().count(q_lower)
            matches.append((path, score, snippet(content, query)))
    matches.sort(key=lambda x: -x[1])
    return matches[:top_k]


def snippet(content: str, query: str, ctx: int = 80) -> str:
    """Return a short snippet around the first occurrence of query."""
    idx = content.lower().find(query.lower())
    if idx < 0:
        return content[:160].replace("\n", " ").strip()
    start = max(0, idx - ctx)
    end = min(len(content), idx + len(query) + ctx)
    return ("..." if start > 0 else "") + content[start:end].replace("\n", " ").strip() + ("..." if end < len(content) else "")


def parse_rg_output(output: str, top_k: int):
    """Parse ripgrep output into (path, score, snippet) tuples."""
    files = {}
    for line in output.splitlines():
        if ":" in line:
            parts = line.split(":", 2)
            if len(parts) >= 3:
                path, _, text = parts
                files.setdefault(path, []).append(text.strip())
    results = [(path, len(snippets), " | ".join(snippets[:3])) for path, snippets in files.items()]
    results.sort(key=lambda x: -x[1])
    return results[:top_k]


def search_semantic(vault_root: Path, query: str, top_k: int, rebuild: bool):
    """Embedding-based search via sentence-transformers."""
    try:
        from sentence_transformers import SentenceTransformer
        import numpy as np
    except ImportError:
        print("# sentence-transformers not installed — falling back to keyword search.", file=sys.stderr)
        print("# To enable semantic search: pip install -r requirements.txt", file=sys.stderr)
        return search_keyword(vault_root, query, top_k)

    index_path = vault_root / INDEX_DIR
    index_path.mkdir(exist_ok=True)
    embeddings_path = index_path / INDEX_FILE
    meta_path = index_path / META_FILE

    model = SentenceTransformer("all-MiniLM-L6-v2")

    # Rebuild or load index
    if rebuild or not embeddings_path.exists() or not meta_path.exists():
        print("# Building vault index (one-time)...", file=sys.stderr)
        files = collect_files(vault_root)
        if not files:
            return []
        contents = [c for _, c in files]
        embeddings = model.encode(contents, show_progress_bar=False, convert_to_numpy=True)
        np.save(embeddings_path, embeddings)
        meta = [{"path": p, "snippet": c[:300].replace("\n", " ")} for p, c in files]
        meta_path.write_text(json.dumps(meta))
        print(f"# Indexed {len(files)} files.", file=sys.stderr)
    else:
        embeddings = np.load(embeddings_path)
        meta = json.loads(meta_path.read_text())

    # Embed query and rank
    q_emb = model.encode([query], convert_to_numpy=True)[0]
    sims = embeddings @ q_emb / (
        (embeddings ** 2).sum(axis=1) ** 0.5 * (q_emb ** 2).sum() ** 0.5 + 1e-9
    )
    top_idx = sims.argsort()[::-1][:top_k]
    return [(meta[i]["path"], float(sims[i]), meta[i]["snippet"]) for i in top_idx]


def main():
    parser = argparse.ArgumentParser(description="Semantic vault search.")
    parser.add_argument("query", nargs="?", help="Search query")
    parser.add_argument("--top", type=int, default=DEFAULT_TOP_K, help="Number of results")
    parser.add_argument("--rebuild", action="store_true", help="Rebuild index")
    parser.add_argument("--vault", default=".", help="Vault root path")
    args = parser.parse_args()

    if not args.query and not args.rebuild:
        parser.print_help()
        sys.exit(1)

    vault_root = Path(args.vault).resolve()

    if args.rebuild and not args.query:
        # Build index, no search
        try:
            from sentence_transformers import SentenceTransformer
            search_semantic(vault_root, "warmup", args.top, rebuild=True)
            print("Index rebuilt.")
        except ImportError:
            print("sentence-transformers not installed. Run: pip install -r requirements.txt")
            sys.exit(1)
        return

    results = search_semantic(vault_root, args.query, args.top, args.rebuild)

    if not results:
        print(f'No matches for "{args.query}" in {vault_root}')
        sys.exit(0)

    print(f'\nTop {len(results)} matches for "{args.query}":\n')
    for i, (path, score, snip) in enumerate(results, 1):
        print(f"{i}. {path}  [score: {score:.3f}]")
        print(f"   {snip}\n")


if __name__ == "__main__":
    main()
