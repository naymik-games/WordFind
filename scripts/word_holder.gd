extends Control
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 

func _on_grid_update_word(word):
	label.text = word
	#label.set("theme_override_colors/font_color", Color(255, 0, 0))


func _on_grid_update_word_status(type):
		if type == 0:
			#build color
			label.set("theme_override_colors/font_color", Color.html("#e0f8cf"))
		elif type == 1:
			#found word
			label.set("theme_override_colors/font_color", Color.html("#7cefbe"))
		elif type == 2:
			#not a word
			label.set("theme_override_colors/font_color",Color.html("#ff0000"))
		elif type == 3:
			#already found
			label.set("theme_override_colors/font_color", Color.html("#bf834d"))
