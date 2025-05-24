extends Control

@onready var dayX = $DayX

func _ready() -> void:
	Global.day += 1
	dayX.text = "Day " + str(Global.day)
	Global.fade_in(dayX)
	await get_tree().create_timer(3.0).timeout
	await Global.fade_out(dayX).finished
	get_tree().change_scene_to_file("res://RestockScene.tscn")
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		await Global.fade_out(dayX).finished
		get_tree().change_scene_to_file("res://RestockScene.tscn")
