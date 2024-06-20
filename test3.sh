read -p "Enter your input: " input
python3 -m pytgpt generate "$input"
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
done <<< "$file_list"


