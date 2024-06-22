import google.generativeai as genai, sys

genai.configure(api_key="AIzaSyC9Dv4b-73KLTc7E2jqqrIRhgSPO4F4Fjo")

model = genai.GenerativeModel('gemini-1.5-flash')

arg1 = sys.argv[1]
prompt_addon = """
Give tips if the user only if the user asks for them.
Otherwise, act as a normal street vendor who sells fruits. Make sure you reprimand the user if they talk inappropriately.
Put an english translation at the end of the prompt. Before writing the english translation, put a semicolon to signify the change.
"""
response = model.generate_content(arg1 + prompt_addon)
print(response.text)