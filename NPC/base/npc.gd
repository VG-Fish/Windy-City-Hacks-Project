extends StaticBody3D

var player_in: bool = false
var getting_response: bool = false
var response: String

func _process(_delta) -> void:
	if player_in and Input.is_action_just_pressed("interact"):
		Globals.send_response("You are a spanish street vendor in a game about building confidence in speaking other languages")
		getting_response = true
	if getting_response:
		response = Globals.get_response()
		if response != "Getting response...":
			getting_response = false
		print(response)

func _on_area_3d_body_entered(body) -> void:
	if body.name == "Player":
		player_in = true

func _on_area_3d_body_exited(body) -> void:
	if body.name == "Player":
		player_in = false

