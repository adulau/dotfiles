#!/bin/bash
#
# my stupid script to archive my last del.icio.us
# posts using the very handy "jsonpipe".
#

cd ~/mirror/delicious-archive/
curl -s "http://feeds.delicious.com/v2/json/adulau"  | jsonpipe -s "#"  | grep  "\#u" | cut -f2 | sed -e"s/\"//g" | xargs -d"\n" wget -r -l 1 –p --convert-links --no-check-certificate
