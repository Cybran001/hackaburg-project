extends Control

@onready var char1 = $Bob

func _ready():
	# Start by fading in Character 1
	fade_in_character(char1)

	# Start the first Dialogic timeline
	Dialogic.start("timeline2")  # Replace with your first timeline name

	Global.money_counter += 1;
	# Wait for it to finish
	Dialogic.timeline_ended.connect(_on_timeline2_end)

func fade_in_character(character: TextureRect):
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 1.0, 1.5)

func _on_timeline2_end():
	print(Global.money_counter)
	pass
	# Disconnect to avoid duplicate triggers
	# Dialogic.timeline_ended.disconnect(_on_timeline1_end)

	# Fade in the second character
	# fade_in_character(char2)

	# Start the second timeline
	# Dialogic.start("Timeline2")  # Replace with your second timeline name
