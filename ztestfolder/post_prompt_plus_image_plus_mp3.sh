read -p "Enter your input: " input
python3 -m pytgpt generate "$input" > zprompt.txt
sed -i -e 's/### //g' -e 's/– \*\*//g' -e 's/\*\*//g' zprompt.txt
cat zprompt.txt | sed 's/- //g' > zprompt2.txt
cat zprompt2.txt > zprompt.txt
rm -f zprompt2.txt
python3 test2.py "$input"
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
    python3 test4_post_plus_image.py "$input" "$newfilename" "zz.mp3" "zprompt.txt"
    rm -f $newfilename 
done <<< "$file_list"

