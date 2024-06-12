import openai

# Replace 'your-api-key' with your actual OpenAI API key
openai.api_key = 'your-api-key'
openai.api_key = ''

# Function to get response from ChatGPT
def chat_with_gpt(prompt):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",  # Use gpt-3.5-turbo model
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ]
    )
    return response['choices'][0]['message']['content']

# Test the function
prompt = "Hello, ChatGPT! How are you today?"
response = chat_with_gpt(prompt)
print("ChatGPT response:", response)

