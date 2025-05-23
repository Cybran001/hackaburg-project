extends Node

var money_counter: int = 100
var reputation_counter: int = 0
var day = 0
var lastDay = 3
var timeline_stack = ["timeline1", "rogue_timeline", "barbarian_timeline", "timeline1", "rogue_timeline", "barbarian_timeline", "timeline1", "rogue_timeline", "barbarian_timeline"]
var timeline_counter = 0
# as an example, we initialize the current_inventory with all items
var current_inventory: Array[Item] = parse_item_list("res://items/items_list.json")
var available_items: Dictionary[String, Item] = _convert_item_list_to_dict(parse_item_list("res://items/items_list.json"))

func resize_texture_32x32(texture: Texture2D) -> Texture2D:
	var _texture = texture.get_image()
	_texture.resize(32,32)
	return ImageTexture.create_from_image(_texture)

func add_item_to_itemlist(list: ItemList, item: Item):
	# Add coin texture and resize to 32x32
	var coin_texture := Global.resize_texture_32x32(load("res://icons/coin.png"))
	
	list.add_item(item.item_name, item.item_texture)
	list.add_item(str(item.item_value), coin_texture, false)
	
func remove_item_from_itemlist(list: ItemList, index):
	# do it twice to remove value field as well
	list.remove_item(index)
	list.remove_item(index)

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

func fade_in(object):
	var tween = create_tween()
	tween.tween_property(object, "modulate:a", 1.0, 1.5)
	return tween

func fade_out(object):
	var tween = create_tween()
	tween.tween_property(object, "modulate:a", 0.0, 1.5)
	return tween
