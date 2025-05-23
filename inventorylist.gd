extends ItemList

func _init():
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	# Add coin texture and resize to 32x32
	var _coin_texture = load("res://icons/coin.png").get_image()
	_coin_texture.resize(32,32)
	var coin_texture := ImageTexture.create_from_image(_coin_texture)
	
	# Add items in inventory
	for item in Global.current_inventory:
		add_item(item.item_name, item.item_texture)
		add_item(str(item.item_value), coin_texture, false)
