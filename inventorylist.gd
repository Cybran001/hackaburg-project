extends ItemList

func _init():
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	# Add coin texture and resize to 32x32
	var coin_texture := Global.resize_texture_32x32(load("res://icons/coin.png"))
	
	# Add items in inventory
	for item in Global.current_inventory:
		add_item(item.item_name, item.item_texture)
		add_item(str(item.item_value), coin_texture, false)
