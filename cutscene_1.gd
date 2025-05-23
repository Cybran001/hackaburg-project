extends Control

@onready var char1 = $Alice


func _ready():
	$AudioStreamPlayer.play()
	Dialogic.signal_event.connect(_on_dialogic_signal_event)
	play_next_timeline()
	#Dialogic.start("timeline1")  # replace with your actual timeline name
	#Dialogic.timeline_ended.connect(_on_timeline1_end)
	
func play_next_timeline():
	Global.fade_in(char1)
	Dialogic.start(Global.timeline_stack.pop_front())  # replace with your actual timeline name
	Dialogic.timeline_ended.connect(_on_timeline_end)


func _on_timeline_end():
	await Global.fade_out(char1).finished
	# todo start next timeline here
	Global.timeline_counter += 1
	# if day has ended:
	#if Global.day == Global.lastDay:
	if Global.day == Global.lastDay && (Global.timeline_counter%3) == 0:
		get_tree().change_scene_to_file("res://Endscreen.tscn")
	elif (Global.timeline_counter%3) == 0:
		get_tree().change_scene_to_file("res://DayX.tscn")
	else:
		play_next_timeline()

func _on_dialogic_signal_event(signal_name: String):
	match signal_name:
		"sell_gear":
			Dialogic.paused = true
			print("Selling gear...")
			await get_tree().create_timer(3.0).timeout
			# todo sell stuff here
			print("Sold gear!!!")
			Dialogic.paused = false
