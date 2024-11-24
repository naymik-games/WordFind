extends CanvasLayer

@onready var line = $Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func draw_point(point):
	$Line2D.add_point(point)
