extends Control


func _on_available_items_list_item_selected(index: int) -> void:
	var selected_item_name = $AvailableItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]


	if selected_item.item_value <= Global.money_counter:
		Global.remove_item_from_itemlist($AvailableItemsList, index)
		Global.add_item_to_itemlist($SelectedItemsList, selected_item)

		Global.money_counter -= selected_item.item_value
	else:
		print("todo no money")

func _on_selected_items_list_item_selected(index: int) -> void:
	var selected_item_name = $SelectedItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($SelectedItemsList, index)
	Global.add_item_to_itemlist($AvailableItemsList, selected_item)
	Global.money_counter += selected_item.item_value
