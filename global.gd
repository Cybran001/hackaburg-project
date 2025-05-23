extends Node

var money_counter: int = 100
var reputation_counter: int = 0
# as an example, we initialize the current_inventory with all items
var current_inventory: Array[Item] = parse_item_list("res://items/items_list.json")
var available_items: Dictionary[String, Item] = _convert_item_list_to_dict(parse_item_list("res://items/items_list.json"))

func _convert_item_list_to_dict(items: Array[Item]) -> Dictionary[String, Item]:
	var dict: Dictionary[String, Item] = {}
	for item in items:
		dict[item.item_name] = item
	return dict
	

func parse_item_list(items_file: String) -> Array[Item]:
	var res: Array[Item] = []
	var items = _load_items_from_json(items_file)
	for item in items:
		res.append(Item.new(item["Name"],load("res://items/" + item["Texture"]), item["Value"], item["Properties"]))
	return res

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
