extends ItemList

func _init():
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	# Add items in inventory
	for item in Global.current_inventory:
		add_item(item.item_name, item.item_texture)
		add_item(str(item.item_value), null, false)
