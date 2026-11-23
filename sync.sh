#!/bin/zsh
# kanji-oni の最新版を このフォルダにコピーして GitHub に公開する
set -e
SRC=/Users/maidsky/NanoBanana/kanji-oni
DST=/Users/maidsky/NanoBanana/kanji-oni-site
cd $DST
rsync -a --delete --exclude raw $SRC/assets/ assets/
rsync -a --delete $SRC/sf/ sf/
cp $SRC/strokes.json .
{ echo '<!doctype html><html lang="ja"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><meta name="apple-mobile-web-app-capable" content="yes"><meta name="apple-mobile-web-app-title" content="漢字鬼斬り帖"><link rel="apple-touch-icon" href="assets/hero_t5.png"><style>body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style></head><body>'
  grep -v '^<meta charset="utf-8">$' $SRC/index.html
  echo '</body></html>'; } > index.html
touch .nojekyll
git add -A
git commit -q -m "${1:-Update game}

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" || echo "no changes"
git push -q origin main
echo "published"
