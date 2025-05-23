extends Control

@onready var char1 = $Alice
#@onready var char2 = $Character2

func _ready():
	fade_in_character(char1)
	Dialogic.start("timeline1")  # replace with your actual timeline name
	Global.money_counter += 1;
	Global.reputation_counter += 10;
	Dialogic.timeline_ended.connect(_on_timeline1_end)

func fade_in_character(character):
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 1.0, 1.5)

func _on_timeline1_end():
	get_tree().change_scene_to_file("res://Cutscene2.tscn")
	#fade_in_character(char2)
	pass
	#Dialogic.start("Timeline2")  # replace with your actual second timeline
