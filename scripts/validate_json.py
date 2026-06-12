#!/usr/bin/env python3
"""Validate that repository JSON files are parseable."""

from __future__ import annotations

import json
import sys
from pathlib import Path


def iter_json_files(paths: list[str]) -> list[Path]:
    files: list[Path] = []
    for raw_path in paths:
        path = Path(raw_path)
        if path.is_file() and path.suffix == ".json":
            files.append(path)
        elif path.is_dir():
            files.extend(sorted(path.rglob("*.json")))
    return files


def main() -> int:
    targets = sys.argv[1:] or ["schemas", "templates", "examples", "memory"]
    files = iter_json_files(targets)
    failed = False

    for file_path in files:
        try:
            with file_path.open("r", encoding="utf-8") as handle:
                json.load(handle)
            print(f"OK {file_path}")
        except Exception as exc:  # pragma: no cover - command-line reporting
            failed = True
            print(f"FAIL {file_path}: {exc}", file=sys.stderr)

    if not files:
        print("No JSON files found.", file=sys.stderr)
        return 1

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
