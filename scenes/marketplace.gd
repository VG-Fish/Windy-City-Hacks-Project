extends Node3D

func _ready():
	$Label3D.text = get_response("You are a spanish street vendor in a game about building confidence in speaking other languages")

func _process(delta):
	pass
	
func get_response(prompt: String) -> String:
	var output: Array = []
	var exit_code: int
	
	exit_code = OS.execute("/Users/vishy/.pyenv/versions/3.10.0/bin/python", ["chatbot/chatbot.py", prompt], output)
	
	if exit_code == OK:
		return str(output[0])
	return "Error in getting response."
