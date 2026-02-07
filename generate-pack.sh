#!/usr/bin/env bash
set -euo pipefail

SKIP_EXISTING=0
if [[ "${1:-}" == "--skip-existing" ]]; then
  SKIP_EXISTING=1
fi

SKIP_EXISTING="$SKIP_EXISTING" node <<'NODE'
const fs = require('fs');
const path = require('path');

const root = process.cwd();
const ignore = new Set(['.git', 'node_modules', '__assets']);
const skipExisting = process.env.SKIP_EXISTING === '1';

function listDir(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  const dic = [];
  const blog = [];

  for (const entry of entries) {
    if (ignore.has(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      dic.push(entry.name);
    } else if (entry.isFile() && entry.name.toLowerCase().endsWith('.md')) {
      blog.push(entry.name);
    }
  }

  const packPath = path.join(dir, 'pack.json');
  if (!(skipExisting && fs.existsSync(packPath))) {
    const pack = { dic, blog };
    fs.writeFileSync(packPath, JSON.stringify(pack, null, 2) + '\n');
  }

  for (const sub of dic) {
    listDir(path.join(dir, sub));
  }
}

listDir(root);
NODE
