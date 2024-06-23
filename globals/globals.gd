extends Node

var thread: Thread
var response: String

signal got_response

func send_response(prompt: String) -> void:
	thread = Thread.new()
	thread.start(_get_response.bind(prompt))

func _get_response(prompt: String) -> String:
	var output: Array = []
	var exit_code: int
	
	exit_code = OS.execute("/Users/vishy/.pyenv/versions/3.10.0/bin/python", ["chatbot/chatbot.py", prompt], output)
	
	if exit_code == OK:
		return str(output[0])
	return "Error in getting response."
	
func check_response_status():
	if !thread.is_alive():
		response = thread.wait_to_finish()
		got_response.emit()

func get_response() -> String:
	var tmp: String = response
	response = ""
	return tmp
