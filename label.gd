extends Label

var dialogue = []

var current_entry = {}
var full_text := ""
var current_text := ""
var char_index := 0
var dialogue_index := 0
var typing := false
var char_delay := 0.05
var timer := 0.0

@export var name_label: Label
@export var character_sprite: TextureRect
@export var background_sprite: TextureRect
@export var dialogue_file: String = "res://dialogue/test_dialogue.json"

func _ready():
	set_process(true)
	_load_dialogue_from_json(dialogue_file)
	_show_next()

func _process(delta):
	if typing and char_index < full_text.length():
		timer -= delta
		if timer <= 0:
			current_text += full_text[char_index]
			text = current_text
			char_index += 1
			timer = char_delay

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if typing:
			# Instantly finish current line
			current_text = full_text
			text = full_text
			typing = false
		else:
			_show_next()

func _show_next():
	if dialogue_index >= dialogue.size():
		print("End of dialogue.")
		Dialogic.start("timeline1")
		return
	current_entry = dialogue[dialogue_index]
	dialogue_index += 1

	# Update UI
	full_text = current_entry.get("text", "")
	current_text = ""
	text = ""
	char_index = 0
	typing = true
	timer = 0.0

	if name_label:
		name_label.text = current_entry.get("name", "")

	if character_sprite and current_entry.has("character"):
		character_sprite.texture = load(current_entry["character"])

	if background_sprite and current_entry.has("background"):
		background_sprite.texture = load(current_entry["background"])

func _load_dialogue_from_json(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var result = JSON.parse_string(text)
		if result:
			dialogue = result
		else:
			push_error("Failed to parse JSON dialogue file: " + path)
	else:
		push_error("Failed to open dialogue file: " + path)
