extends CanvasLayer
@onready var line =$Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_add_line_point(point):
	line.add_point(point)


func _on_grid_clear_line():
	line.clear_points()


func _on_grid_remove_line_last():
	line.remove_point(line.get_point_count()-1)
