extends StaticBody3D

var player_in: bool = false
var getting_response: bool = false
var chat_history: Array[PackedStringArray] = []
var response: String
# INFO: Script to call google gemini
var gemini_script: GDScript = preload("res://globals/globals.gd")
var gemini_script_instance: Variant

func _ready() -> void:
	gemini_script_instance = gemini_script.new()
	add_child(gemini_script_instance)
	$Chat.visible = false

func _process(_delta) -> void:
	if player_in and Input.is_action_just_pressed("interact"):
		gemini_script_instance.send_response(
			"You are a spanish street vendor in a game about building confidence in speaking other languages." \
			+ "This is the chat history so far: "
			+ " ".join(chat_history)
			)
		getting_response = true
		$Chat.visible = true
	if getting_response:
		response = gemini_script_instance.get_response()
		if response != "Getting response...":
			getting_response = false
			var r: PackedStringArray = response.strip_edges().replace("\n", "").split(";")
			chat_history.append(PackedStringArray([name + ": ", r[0], r[1]]))
			$Chat.visible = true

func _on_area_3d_body_entered(body) -> void:
	if body.name == "Player":
		player_in = true

func _on_area_3d_body_exited(body) -> void:
	if body.name == "Player":
		player_in = false

