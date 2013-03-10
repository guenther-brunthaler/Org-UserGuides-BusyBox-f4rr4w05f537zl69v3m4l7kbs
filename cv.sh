#! /bin/sh
a2x.py -f text vi.txt
sed -e 's,ü,ue,g' vi.text \
| iconv -t ISO-8859-1 \
| tr $'\xa0' ' ' \
| iconv -f ISO-8859-1 -t US-ASCII > vi.asc
rm vi.text
