#!/bin/bash

# Example array of inputs
inputs=("topic1" "topic2" "topic3")

for input in "${inputs[@]}"; do
    # Run the command and ignore errors
    # python3 -m pytgpt generate "in english tell me about $input" > zprompt.txt 2>/dev/null || true
    
    # Add any other commands you want to run within the loop
    echo "Processed input: $input"
done
