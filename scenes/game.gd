extends Node3D

var gemini_response: String
var responses: PackedStringArray

func _ready():
	gemini_response = get_response("You are a spanish street vendor in a game about building confidence in speaking other languages")
	responses = gemini_response.split(";")
	
	print(responses)

func get_response(prompt: String) -> String:
	var output: Array = []
	var exit_code: int
	
	exit_code = OS.execute("/Users/vishy/.pyenv/versions/3.10.0/bin/python", ["chatbot/chatbot.py", prompt], output)
	
	if exit_code == OK:
		return str(output[0])
	return "Error in getting response."
