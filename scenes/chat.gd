extends Control

var essential_info: String = "Press esc to hide chat. "
var chat_history: Array[PackedStringArray]

# For tts
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id1 = voices[0]
var voice_id2 = voices[1]

signal user_response_generated(text: String)

func _ready() -> void:
	get_parent().connect("chat_getting_response", change_to_getting_response_text)
	get_parent().connect("chat_gotten_response", change_to_got_response_text)

func change_to_getting_response_text() -> void:
	$Info.text = essential_info + "NPC is generating response..."

func change_to_got_response_text() -> void:
	chat_history = get_parent().get("chat_history")
	$VBoxContainer/NPC.text = get_parent().name + ": " + chat_history[chat_history.size() - 1][1]
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(chat_history[chat_history.size() - 1][1], voice_id1)
	$Info.text = essential_info + "Read the %s's response. Then, respond back by typing in spanish." % get_parent().name

func _process(_delta) -> void:
	if Input.is_action_just_pressed("hide"):
		visible = false
		DisplayServer.tts_stop()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_line_edit_text_submitted(new_text):
	user_response_generated.emit(new_text)
	$VBoxContainer/Player/LineEdit.text = ""
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(new_text, voice_id2)
