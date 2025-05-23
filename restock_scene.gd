extends Control


func _on_available_items_list_item_selected(index: int) -> void:
	var selected_item_name = $AvailableItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($AvailableItemsList, index)
	Global.add_item_to_itemlist($SelectedItemsList, selected_item)


func _on_selected_items_list_item_selected(index: int) -> void:
	var selected_item_name = $SelectedItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($SelectedItemsList, index)
	Global.add_item_to_itemlist($AvailableItemsList, selected_item)
