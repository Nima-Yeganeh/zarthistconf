
read -p "Enter your input: " input

echo "Info in English..."

echo "" > zprompt.txt
python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt

sed -i -e 's/### //g' -e 's/– \*\*//g' -e 's/\*\*//g' -e 's/#//g' zprompt.txt
cat zprompt.txt | sed 's/- //g' > zprompt2.txt
cat zprompt2.txt > zprompt.txt
rm -f zprompt2.txt
mv -f zprompt.txt zprompt_info_en

echo "Translation to French..."

echo "" > zprompt.txt
python3 -m pytgpt generate "translate to french" > zprompt.txt

sed -i -e 's/### //g' -e 's/– \*\*//g' -e 's/\*\*//g' -e 's/#//g' zprompt.txt
cat zprompt.txt | sed 's/- //g' > zprompt2.txt
cat zprompt2.txt > zprompt.txt
rm -f zprompt2.txt
mv -f zprompt.txt zprompt_info_fr

echo "Check Title..."

ztitle_fr=$(python3 -m pytgpt generate "Give me a title for this article in french")
ztitle_en=$(python3 -m pytgpt generate "Translate this title to english")
ztitle="$ztitle_fr | $ztitle_en"
# echo $ztitle_en
# echo $ztitle_fr
echo $ztitle

echo "Wordpress Tags..."

python3 -m pytgpt generate "Give me list of wordpress keyword tags for this article in bullet point in french and english" > zwptagstempfile
cat zwptagstempfile | grep - | sed 's/- //g' | sed 's/\*\*//g' > zwptags
# rm -f zwptagstempfile

echo "Google Images..."

googleimgurl=$(bash googleimgv2.sh "$input")
echo $googleimgurl
googieimghtml='<!DOCTYPE html><html><body><p>Click the link to search <a href="'$googleimgurl'">Google Images</a></p><br></body></html>'
echo $googieimghtml

# echo "Books..."

# python3 -m pytgpt generate "Give me list of books for this article in bullet point in french and english" > zbookstempfile
# cat zbookstempfile | sed 's/\*\*//g' | sed 's/### //g' > zbooks

sleep 1000

zup1=$(cat zupinfo1 | head -n 1)
zup2=$(cat zupinfo2 | head -n 1)
zup3=$(cat zupinfo3 | head -n 1)

echo "Downloading Image..."

python3 imagedl.py "$input"

echo "Checking JPG Files..."

file_list=$(ls -anp | grep "$input" | grep jpeg)
while IFS= read -r line; do
    filename=$(echo "$line" | awk '{for (i=9; i<=NF; i++) printf $i " "; print ""}' | sed 's/ *$//')
    newfilename=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    extension=".jpg"
    newfilename="${newfilename}${extension}"
    echo "New filename: $newfilename"
    echo "$filename"
    convert "$filename" -gravity North -chop 0x60 -gravity South -chop 0x60 $newfilename
    rm -f "$filename"

    echo "MP3 in French..."

    mp3file=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    mp3file="${mp3file}.mp3"
    python3 ztr2.py "zprompt_info_fr" "$mp3file" "fr"

    echo "MP3 in English..."

    mp3file2=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    mp3file2="${mp3file2}.mp3"
    python3 ztr2.py "zprompt_info_en" "$mp3file2" "en"

    echo "Wordpress Post..."

    python3 test4_post_plus_image.py "$ztitle" "$newfilename" "$mp3file" "zprompt_info_fr" "$mp3file2" "zprompt_info_en" "zwptags" "$zup1" "$zup2" "$zup3"
    rm -f $newfilename
    rm -f $mp3file
    rm -f $mp3file2
done <<< "$file_list"

rm -f zprompt_info_en
rm -f zprompt_info_fr
rm -f zwptagstempfile
rm -f zwptags
rm -f zbookstempfile
rm -f zbooks
echo "Done!"

