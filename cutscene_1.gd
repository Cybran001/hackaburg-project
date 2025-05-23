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
	var target_properties = Global.property_stack.pop_front()
	print(target_properties)
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

			$label_available_items.visible = true
			$label_customer_items.visible = true
			$label_sell_items.visible = true
			$SelectedItemsList.visible = true
			$AvailableItemsList.visible = true
			$Button.visible = true

			print("Selling gear...")
			# todo sell stuff here
			print("Sold gear!!!")


func _on_available_items_list_item_selected(index: int) -> void:
	var selected_item_name = $AvailableItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($AvailableItemsList, index)
	Global.add_item_to_itemlist($SelectedItemsList, selected_item)

	Global.money_counter += selected_item.item_value



func _on_selected_items_list_item_selected(index: int) -> void:
	var selected_item_name = $SelectedItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($SelectedItemsList, index)
	Global.add_item_to_itemlist($AvailableItemsList, selected_item)
	Global.money_counter -= selected_item.item_value


func _on_button_pressed() -> void:
	Dialogic.paused = false
