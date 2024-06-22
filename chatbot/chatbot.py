import google.generativeai as genai
import os

genai.configure(api_key=os.environ["GEMINI_API_KEY"])

model = genai.GenerativeModel('gemini-1.5-flash')

response = model.generate_content("Write a story about a AI and magic")
print(response.text)

