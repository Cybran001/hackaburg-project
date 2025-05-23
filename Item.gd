class_name Item
extends Resource

var item_name: String
var item_texture: Texture2D
var item_value: int
var item_properties: Array

func _init(name: String, texture: Texture2D, value: int, properties: Array):
	item_name = name
	item_texture = texture
	item_value = value
	item_properties = properties
