extends Control

func _on_startbutton_pressed():
	print("changing scene!")
	get_tree().change_scene_to_file("res://Cutscene1.tscn")
