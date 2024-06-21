read -p "Enter your input: " input
python3 -m pytgpt generate "$input" > zprompt.txt
echo "**********"
cat zprompt.txt
echo ""

