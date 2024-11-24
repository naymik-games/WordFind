extends MarginContainer
var clue_holder = []
var clue = preload("res://scene/clue.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_setup_clues(clues):
	for i in clues.size():
		var temp_clue = clue.instantiate()
		$HBoxContainer.add_child(temp_clue)
		temp_clue.set_letter(clues[i], i)	
		clue_holder.append(temp_clue)


func _on_grid_remove_clue(clue_letter):
	for i in clue_holder.size():
		if clue_holder[i].letter == clue_letter:
			print("remove clue")
			clue_holder[i].queue_free()
			clue_holder.remove_at(i)
			break
