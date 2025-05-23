extends Control

@onready var toBeContinued = $ToBeContinued

func _ready():
	fade_in(toBeContinued)
	

func fade_in(character):
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 1.0, 1.5)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Mouse clicked!")
		get_tree().quit()
