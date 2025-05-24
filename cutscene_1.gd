extends Control

@onready var adventurer = $Adventurer
@onready var rogue = $Rogue
@onready var barbarian = $Barbarian
@onready var necromancer = $Necromancer
@onready var orc = $Orc
@onready var king = $King
@onready var cleric = $Cleric

var chars = []


func _ready():
	chars = [adventurer, adventurer, rogue, rogue, barbarian, barbarian, adventurer, adventurer, necromancer, necromancer, orc, orc, adventurer, adventurer, king, king, cleric, cleric]
	$AudioStreamPlayer.play()
	play_next_timeline()
	#Dialogic.start("timeline1")  # replace with your actual timeline name
	#Dialogic.timeline_ended.connect(_on_timeline1_end)
	
func play_next_timeline():
	if Global.timeline_counter % 2 == 0: # normal timeline
		Global.fade_in(chars[Global.timeline_counter])
	
	Dialogic.start(Global.timeline_stack.pop_front())  # replace with your actual timeline name
	Dialogic.timeline_ended.connect(_on_timeline_end)


func _on_timeline_end():
	if Global.timeline_counter % 2 == 0: # normal timeline
		$label_available_items.visible = true
		$label_customer_items.visible = true
		$label_sell_items.visible = true
		$SelectedItemsList.visible = true
		$AvailableItemsList.visible = true
		$Button.visible = true
	
	else: # ending-timeline
		await Global.fade_out(chars[Global.timeline_counter]).finished
		
	# todo start next timeline here
	Global.timeline_counter += 1
	var target_properties = Global.property_stack.pop_front()
	print(target_properties)
	# if day has ended:
	#if Global.day == Global.lastDay:
	if Global.day == Global.lastDay && (Global.timeline_counter%6) == 0:
		get_tree().change_scene_to_file("res://Endscreen.tscn")
	elif (Global.timeline_counter%6) == 0:
		get_tree().change_scene_to_file("res://DayX.tscn")
	elif Global.timeline_counter % 2 == 0:
		play_next_timeline()


func _on_available_items_list_item_selected(index: int) -> void:
	var selected_item_name = $AvailableItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($AvailableItemsList, index)
	Global.add_item_to_itemlist($SelectedItemsList, selected_item)

	Global.money_counter += selected_item.item_value



func _on_selected_items_list_item_selected(index: int) -> void:
	var selected_item_name = $SelectedItemsList.get_item_text(index)
	var selected_item = Global.available_items[selected_item_name]

	Global.remove_item_from_itemlist($SelectedItemsList, index)
	Global.add_item_to_itemlist($AvailableItemsList, selected_item)
	Global.money_counter -= selected_item.item_value


func _on_button_pressed() -> void:
	$label_available_items.visible = false
	$label_customer_items.visible = false
	$label_sell_items.visible = false
	$SelectedItemsList.visible = false
	$AvailableItemsList.visible = false
	$Button.visible = false
	play_next_timeline()
