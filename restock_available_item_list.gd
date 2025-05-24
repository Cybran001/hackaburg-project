extends ItemList

func _init():
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	# Add all existing items
	for item in Global.parse_item_list("res://items/items_list.json"):
		Global.add_item_to_itemlist(self, item)
