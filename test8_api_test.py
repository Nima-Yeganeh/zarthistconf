import openai

# xcode = input("What is the code? ")
# question = input("What is your question? ")
question = "Tell me about Art History"
# print("Code: " + xcode + "")
# openai.api_key = "sk-"+xcode+"joeRLSZjsL9bOXI2PT3BlbkFJEc4ys7pAJe7SL82uqxtE"
openai.api_key = "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"

def generate_content(topic):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
                {"role": "system", "content": "You are a chatbot"},
                {"role": "user", "content": topic},
            ]
    )
    result = ''
    for choice in response.choices:
        result += choice.message.content
    return(result)

print(generate_content(question))

