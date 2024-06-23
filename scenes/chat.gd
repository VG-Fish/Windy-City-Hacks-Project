extends Control

var essential_info: String = "Press esc to hide chat. "
var chat_history: Array[PackedStringArray]

# For tts
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id = voices[0]

func _ready() -> void:
	get_parent().connect("chat_getting_response", change_to_getting_response_text)
	get_parent().connect("chat_gotten_response", change_to_got_response_text)

func change_to_getting_response_text() -> void:
	$Info.text = essential_info + "NPC is generating response..."

func change_to_got_response_text() -> void:
	chat_history = get_parent().get("chat_history")
	$VBoxContainer/NPC.text = get_parent().name + ": " + chat_history[chat_history.size() - 1][1]
	DisplayServer.tts_speak(chat_history[chat_history.size() - 1][1], voice_id)
	$Info.text = essential_info + "Read %s's response. Then, press v respond back in spanish." % get_parent().name

func _process(_delta) -> void:
	if Input.is_action_just_pressed("hide"):
		visible = false

	if Input.is_action_pressed("voice"):
		DisplayServer.tts_stop()
