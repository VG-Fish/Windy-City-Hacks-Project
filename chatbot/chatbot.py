import google.generativeai as genai, os

genai.configure(api_key=os.environ["GEMINI_API_KEY"])

model = genai.GenerativeModel('gemini-1.5-flash')

prompt_addon = """
Give tips if the user only if the user asks for them.
Otherwise, act as a normal street vendor who sells fruits. Make sure you reprimand the user if they talk inappropriately.
Put an english translation at the end of the prompt. Before writing the english translation, put a semicolon to signify the change.
"""
response = model.generate_content("You are a spanish street vendor in a game about building confidence in speaking other languages." + prompt_addon)
print(response.text)