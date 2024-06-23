extends StaticBody3D

var player_in: bool = false
var chat_history: Array[PackedStringArray] = []
var getting_response: bool = false
var response: String
# INFO: Script to call google gemini
var gemini_script: GDScript = preload("res://globals/globals.gd")
var gemini_script_instance: Variant

signal chat_getting_response
signal chat_gotten_response

func _ready() -> void:
	gemini_script_instance = gemini_script.new()
	gemini_script_instance.connect("got_response", change_to_got_response_text)
	add_child(gemini_script_instance)
	$Chat.visible = false
	$Chat.connect("user_response_generated", send_user_response)

func send_user_response(text: String) -> void:
	chat_history.append(PackedStringArray(["Player", text]))
	gemini_script_instance.send_response(
		"The player has responded to your question. \
		This is their response: %s." % text
	)
	getting_response = true

func change_to_got_response_text() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	response = gemini_script_instance.get_response()
	var r: PackedStringArray = response.strip_edges().replace("\n", "").split(";")
	response = ""
	chat_history.append(PackedStringArray([name + ": ", r[0], r[1]]))
	
	$Chat.visible = true
	chat_gotten_response.emit()
	getting_response = false

func _process(_delta) -> void:
	if player_in and Input.is_action_just_pressed("interact"):
		gemini_script_instance.send_response(
			"You are a spanish street vendor in a game about building confidence in speaking other languages." \
			+ "This is the chat history so far: "
			+ " ".join(chat_history)
			)
		$Chat.visible = true
		chat_getting_response.emit()
		getting_response = true
	if getting_response:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		gemini_script_instance.check_response_status()
	

func _on_area_3d_body_entered(body) -> void:
	if body.name == "Player":
		player_in = true

func _on_area_3d_body_exited(body) -> void:
	if body.name == "Player":
		player_in = false
