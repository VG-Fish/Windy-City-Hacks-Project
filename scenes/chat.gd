extends Control

var essential_info: String = "Press esc to hide chat. "
var chat_history: Array[PackedStringArray]

# For tts
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id = voices[0]

func _process(_delta) -> void:
	if get_parent().get("getting_response"):
		$Info.text = essential_info + "NPC is generating response..."
	else:
		chat_history = get_parent().get("chat_history")
		if chat_history:
			$VBoxContainer/NPC.text = get_parent().name + ": " + chat_history[chat_history.size() - 1][1]
			DisplayServer.tts_speak(chat_history[chat_history.size() - 1][1], voice_id)
		$Info.text = essential_info + "Read %s's response. Then, press v respond back in spanish." % get_parent().name
	
	if Input.is_action_just_pressed("hide"):
		visible = false
