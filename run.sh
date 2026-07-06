#!/bin/bash
rm -f index.html 2>"${1:-/dev/null}"

bunx html-validate resources/index.html
docker run --rm -v "$PWD:/data" ghcr.io/validator/validator:latest vnu /data/resources/index.html

bunx html-minifier-terser \
  --collapse-whitespace \
  --remove-comments \
  --minify-css true \
  --minify-js true \
  -o index.html \
  resources/index.html

bunx serve . &
SERVE_PID=$!

trap 'kill $SERVE_PID 2>/dev/null; exit' INT TERM EXIT

open "http://localhost:3000"
wait $SERVE_PID
