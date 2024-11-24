extends HBoxContainer
@onready var stat_label = $MarginContainer/puzzle_stat
@onready var theme_label = $MarginContainer2/puzzle_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_update_puzzle_info(count, total):
	if !stat_label:
		stat_label = $MarginContainer/puzzle_stat
	stat_label.text = str(count)+"/"+str(total)
	if count == total:
		stat_label.set("theme_override_colors/font_color",Color("95ff8d"))
		theme_label.text = "PUZZLE COMPLETE!"
		theme_label.set("theme_override_colors/font_color",Color("95ff8d"))
	


func _on_grid_update_puzzle_name(name):
	if !theme_label:
		theme_label = $MarginContainer2/puzzle_name
	theme_label.text = name
