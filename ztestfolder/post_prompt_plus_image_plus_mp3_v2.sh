#!/bin/bash
inputs=()
while IFS= read -r line; do
    inputs+=("$line")
done < zztopics.txt

generate_and_post() {
    input=$1
    input2=$2
    input3=$3
    zcat=$input3
    echo "********************"
    echo "Processed input: $input | $zcat"
    echo "Generating..."
    # 1
    echo "Info in English..."
    echo "" > zprompt.txt
    python3 -m pytgpt generate "$input2" > zprompt.txt
    # python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt
    # python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt 2>/dev/null || true
    sed -i -e 's/### //g' -e 's/– \*\*//g' -e 's/\*\*//g' -e 's/#//g' zprompt.txt
    cat zprompt.txt | sed 's/- //g' | sed 's/---//g' | sed 's/--//g' > zprompt2.txt
    # cat zprompt.txt | sed 's/- //g' > zprompt2.txt
    cat zprompt2.txt > zprompt.txt
    rm -f zprompt2.txt
    mv -f zprompt.txt zprompt_info_en
    # 2
    echo "Translation to French..."
    echo "" > zprompt.txt
    python3 -m pytgpt generate "translate to french" > zprompt.txt
    sed -i -e 's/### //g' -e 's/– \*\*//g' -e 's/\*\*//g' -e 's/#//g' zprompt.txt
    cat zprompt.txt | sed 's/- //g' | sed 's/---//g' | sed 's/--//g' > zprompt2.txt
    # cat zprompt.txt | sed 's/- //g' > zprompt2.txt
    cat zprompt2.txt > zprompt.txt
    rm -f zprompt2.txt
    mv -f zprompt.txt zprompt_info_fr
    # 3
    echo "Check Title..."
    ztitle_fr=$(python3 -m pytgpt generate "Give me a title for this in french")
    ztitle_en=$(python3 -m pytgpt generate "Translate this title to english")
    ztitle="$ztitle_fr | $ztitle_en"
    echo $ztitle
    # 4
    echo "Wordpress Tags..."
    python3 -m pytgpt generate "Give me list of wordpress keyword tags for this in bullet point in french and english" > zwptagstempfile
    # cat zwordpresstest.file | grep -v -E 'Wordpress|WordPress|keywords'
    # cat zwptagstempfile | grep - | sed 's/- //g' | sed 's/\*\*//g' > zwptags
    cat zwptagstempfile | grep -v -E 'Wordpress|WordPress|keywords' | grep - | sed 's/- //g' | sed 's/\*\*//g' > zwptags
    # 5
    echo "Google Images..."
    echo "" > googleimghtmlfile
    googleimgurl=$(bash googleimgv2.sh "$input")
    googleimghtml='<!DOCTYPE html><html><body><p>Click the link to search <a href="'$googleimgurl'">Google Images</a></p><br></body></html>'
    echo $googleimghtml > googleimghtmlfile
    # echo "Books..."
    # python3 -m pytgpt generate "Give me list of books for this article in bullet point in french and english" > zbookstempfile
    # cat zbookstempfile | sed 's/\*\*//g' | sed 's/### //g' > zbooks
    # sleep 1000
    zup1=$(cat zupinfo1 | head -n 1)
    zup2=$(cat zupinfo2 | head -n 1)
    zup3=$(cat zupinfo3 | head -n 1)
    # 6
    echo "Downloading Image..."
    python3 imagedl.py "$input"
    echo "Checking JPG Files..."
    file_list=$(ls -anp | grep "$input" | grep jpeg | head -n1)
    filename=$(echo "$file_list" | awk '{for (i=9; i<=NF; i++) printf $i " "; print ""}' | sed 's/ *$//')
    newfilename=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    extension=".jpg"
    newfilename="${newfilename}${extension}"
    echo "New filename: $newfilename"
    echo "$filename"
    convert "$filename" -gravity North -chop 0x60 -gravity South -chop 0x60 $newfilename
    rm -f "$filename"
    # 7
    echo "MP3 in French..."
    mp3file=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    mp3file="${mp3file}.mp3"
    python3 ztr2.py "zprompt_info_fr" "$mp3file" "fr"
    # 8
    echo "MP3 in English..."
    mp3file2=$(date +%Y%m%d%H%M%S%N | md5sum | cut -d ' ' -f 1)
    mp3file2="${mp3file2}.mp3"
    python3 ztr2.py "zprompt_info_en" "$mp3file2" "en"
    # 9
    echo "Wordpress Post..."
    python3 test4_post_plus_image.py "$ztitle" "$newfilename" "$mp3file" "zprompt_info_fr" "$mp3file2" "zprompt_info_en" "zwptags" "$zup1" "$zup2" "$zup3" "googleimghtmlfile" "$zcat"
    rm -f $newfilename
    rm -f $mp3file
    rm -f $mp3file2
    # rm -f zprompt_info_en
    # rm -f zprompt_info_fr
    rm -f zwptagstempfile
    rm -f zwptags
    rm -f zbookstempfile
    rm -f zbooks
    rm -f googleimghtmlfile
    echo "Done!"
    echo "Next..."
}

for ztopic in "${inputs[@]}"; do
    generate_and_post "$ztopic" "in english tell me about $ztopic" "Histoire de l'art | History of Art"
    generate_and_post "$ztopic" "in english give me a basic elementary conversation about $ztopic" "Conversations de base en français | Basic French Conversations"
    generate_and_post "$ztopic" "in english give me Museums Collections and Art Galleries about $ztopic" "Collections de musées et galeries d'art | Museum Collections and Art Galleries"
    generate_and_post "$ztopic" "in english give me Books and eBooks and Articles about $ztopic" "Livres et Publications | Books and Publications"
    generate_and_post "$ztopic" "in english give me list of Musics Songs Movies Short Films Long Films about or related to $ztopic" "Médias et Divertissement (Musique & Films) | Media and Entertainment (Music & Movies)"
    generate_and_post "$ztopic" "in english give a short story about or related to $ztopic" "Français à travers les histoires courtes et l'art | French Through Short Stories and Art"

done

