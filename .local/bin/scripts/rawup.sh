#! /bin/sh
#
# rawup.sh
# 2018-09-03
# CC0 Public Domain

cd $HOME/raw

echo "---\ntitle: Scanned notes\nauthor: Colton Grainger\ndate: $(date -I)\n---\n\n Scans of some handwritten notes."\
      > index.md
echo "" > catalog

# TODO add error message if rsync fails or file is corrupt
for i in *pdf; do
      rsync -v $i colton@quamash.net:/home/colton/wiki/static
      file=${i##*/}
      file_size=$(du -h "$file" | cut -f1)
      file_title="[$file](https://docs.google.com/gview?embedded=true&url=http://quamash.net/$file)"
      echo "- $file_title ($file_size)" >> catalog
done

sort -r catalog >> index.md
rm catalog
mv index.md $HOME/wiki/quamash/raw.md

git -C /home/colton/wiki/quamash/ add /home/colton/wiki/quamash/raw.md
git -C /home/colton/wiki/quamash/ commit -m "Refresh raw index"
git -C /home/colton/wiki/quamash/ pushall
