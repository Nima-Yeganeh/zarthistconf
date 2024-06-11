import openai

question = input("What is your question? ")
# openai.api_key = ""

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
