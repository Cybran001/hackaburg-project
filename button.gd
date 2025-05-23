extends Button

func _ready() -> void:
	pass
	
func _process(delta) -> void:
	pass
	
func _on_pressed():
	print("Button pressed.")
	Dialogic.start("timeline1")
	pass
