extends Control

@onready var char1 = $Alice
#@onready var char2 = $Character2

func _ready():
	fade_in_character(char1)
	Dialogic.signal_event.connect(_on_dialogic_signal_event)
	Dialogic.start("timeline1")  # replace with your actual timeline name
	Dialogic.timeline_ended.connect(_on_timeline1_end)

func fade_in_character(character):
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 1.0, 1.5)

func _on_timeline1_end():
	get_tree().change_scene_to_file("res://Endscreen.tscn")
	#fade_in_character(char2)
	pass
	#Dialogic.start("Timeline2")  # replace with your actual second timeline


func _on_dialogic_signal_event(signal_name: String):
	match signal_name:
		"sell_gear":
			Dialogic.paused = true
			print("Selling gear...")
			await get_tree().create_timer(5.0).timeout
			print("Sold gear!!!")
			Dialogic.paused = false
