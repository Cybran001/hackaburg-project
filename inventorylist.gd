extends ItemList

const items_file: String = "res://items/items_list.json"

func _init() -> void:
	# Add headers
	add_item("Name", null, false)
	add_item("Value", null, false)
	
	var items = _load_items_from_json(items_file)
	
	# as an example, we simply add all items
	for item in items: 
		var texture = load("res://items/" + item["Texture"])
		add_item(item["Name"], texture)
		add_item(str(item["Value"]))


func _load_items_from_json(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var result = JSON.parse_string(text)
		if result:
			return result
		else:
			push_error("Failed to parse JSON dialogue file: " + path)
	else:
		push_error("Failed to open dialogue file: " + path)
