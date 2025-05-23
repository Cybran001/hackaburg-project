extends Control

func _ready() -> void:
	$AudioStreamPlayer.play()
	# Add items that are currently in inventory

func _on_available_items_list_item_selected(index: int) -> void:
	if index % 2 == 1:
		index -= 1
	
	var selected_item_name = $AvailableItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	if selected_item.item_value <= Global.money_counter:
		Global.remove_item_from_itemlist($AvailableItemsList, index)
		Global.add_item_to_itemlist($SelectedItemsList, selected_item)

		Global.money_counter -= selected_item.item_value
	else:
		print("todo no money")

func _on_selected_items_list_item_selected(index: int) -> void:
	if index % 2 == 1:
		index -= 1
	
	var selected_item_name = $SelectedItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($SelectedItemsList, index)
	Global.add_item_to_itemlist($AvailableItemsList, selected_item)
	Global.money_counter += selected_item.item_value


func _on_button_pressed() -> void:
	# Global.current_inventory.clear()
	# $SelectedItemsList.add_item("Name", null, false)
	# $SelectedItemsList.add_item("Value", null, false)
	for i in range(2, $SelectedItemsList.item_count, 2):
		var item_text = $SelectedItemsList.get_item_text(i)
		Global.current_inventory.append(Global.available_items[item_text])

	$SelectedItemsList.clear()
	get_tree().change_scene_to_file("res://Cutscene1.tscn")
