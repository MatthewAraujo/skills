#!/usr/bin/env python3
"""Inline report.css into template.html around a body fragment.

usage: build.py "<title>" body.html out.html
"""
import sys
from pathlib import Path

here = Path(__file__).parent
title, body_path, out_path = sys.argv[1:4]
html = (here / "template.html").read_text(encoding="utf-8")
html = (html.replace("/*CSS*/", (here / "report.css").read_text(encoding="utf-8"))
            .replace("<!--TITLE-->", title)
            .replace("<!--BODY-->", Path(body_path).read_text(encoding="utf-8")))
Path(out_path).parent.mkdir(parents=True, exist_ok=True)
Path(out_path).write_text(html, encoding="utf-8")
