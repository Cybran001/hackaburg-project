extends ItemList

func _init():
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	# Add items that are currently in inventory
	for item in Global.current_inventory:
		Global.add_item_to_itemlist(self, item)
