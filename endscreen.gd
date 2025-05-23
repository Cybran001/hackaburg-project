extends Control

@onready var toBeContinued = $ToBeContinued

func _ready():
	Global.fade_in(toBeContinued)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Mouse clicked!")
		get_tree().quit()
