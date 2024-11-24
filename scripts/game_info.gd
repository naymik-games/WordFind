extends HBoxContainer
@onready var counter_label = $MarginContainer/counter_label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_update_counter(value: int):
	counter_label.text = str(value)
	pass # Replace with function body.
