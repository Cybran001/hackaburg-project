extends Control

@onready var char1 = $Alice

func _ready():
	Global.fade_in(char1)
	Dialogic.signal_event.connect(_on_dialogic_signal_event)
	Dialogic.start("timeline1")  # replace with your actual timeline name
	Dialogic.timeline_ended.connect(_on_timeline1_end)


func _on_timeline1_end():
	get_tree().change_scene_to_file("res://Endscreen.tscn")


func _on_dialogic_signal_event(signal_name: String):
	match signal_name:
		"sell_gear":
			Dialogic.paused = true
			print("Selling gear...")
			await get_tree().create_timer(3.0).timeout
			# todo sell stuff here
			print("Sold gear!!!")
			Dialogic.paused = false
