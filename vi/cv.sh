#! /bin/sh
out=vi.text
nbsp=`echo +AKA-x | iconv -f UTF-7`; nbsp=${nbsp%x}
ue=`echo +APw- | iconv -f UTF-7`
a2x -f text vi.asciidoc
sed "s,$ue,ue,g; y/$nbsp/ /" "$out" \
| iconv -t US-ASCII > vi.asc
rm "$out"
