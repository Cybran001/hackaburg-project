extends Label

var dialogue = ["This is a sample dialogue text.", 
	"This only serves to demonstrate the capabilities of Godot.",
	"Blablabla"]

var full_text := ""
var current_text := ""
var char_index := 0
var i := 0
var typing := false

# Typewriter speed in seconds per character
var char_delay := 0.05

func _ready():
	set_process(true)

func _process(delta):
	if typing and char_index < full_text.length():
		char_delay -= delta
		if char_delay <= 0:
			current_text += full_text[char_index]
			text = current_text
			char_index += 1
			char_delay = 0.05


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if typing:
			# Finish typing instantly
			current_text = full_text
			text = full_text
			typing = false
		else:
			# Start typing new dialogue
			full_text = dialogue[i % dialogue.size()]
			current_text = ""
			text = ""
			char_index = 0
			typing = true
			i += 1
