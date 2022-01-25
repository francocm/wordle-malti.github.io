#!/bin/bash

export LANG=C.UTF-8
export LESSCHARSET=utf-8

URL="https://mlrs.research.um.edu.mt/resources/gabra-api/data/gabra_data_2022-01-01.tar.gz"

apt update && \
    apt install -y wget

mkdir -p /tmp/gabra

wget -O /tmp/gabra/latest.tar.gz "$URL"

mkdir -p /tmp/gabra/extracted
tar zxvf /tmp/gabra/latest.tar.gz -C /tmp/gabra/extracted

cd /tmp/gabra/extracted
find . -type f -iname 'wordforms.bson' -print0 | xargs -0 -I {} mv {} .

bsondump --outFile=wordforms.json wordforms.bson

cat wordforms.json | jq -r '.surface_form' | sort | uniq | awk '{print tolower($0)}' | sort | uniq > surface_forms.txt

sed -i '/ /d' surface_forms.txt # clean up multi-worded entries (lines containing spaces)

sed -i 's/ie/\?/g' surface_forms.txt # convert 'ie' into a temporary character as it needs to be counted as 1 char not 2

sed -i 's/għ/\//g' surface_forms.txt # convert 'għ' into a temporary character as it needs to be counted as 1 char not 2

sed -i '/.\{6\}/d' surface_forms.txt # clean up words longer than 5 characters

sed -i '/^.\{0,4\}$/d' surface_forms.txt # clean up words shorter than 5 characters

sed -i 's/\?/ie/g' surface_forms.txt # convert '?' back to 'ie' now that length filtering is done

sed -i 's/\//għ/g' surface_forms.txt # convert '/' back to 'għ' now that length filtering is done

jq -R -s -c 'split("\n")' < surface_forms.txt | jq 'map(select(length > 0))' > dictionary.json
cp dictionary.json /tmp/werdil/site/dictionary.json

echo "Dictionary populated and stored under site/dictionary.json."