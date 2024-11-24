extends TextureRect

var star_textures = [
	preload("res://assets/stars_0.png"),
	preload("res://assets/stars_1.png"),
	preload("res://assets/stars_2.png"),
	preload("res://assets/stars_3.png")
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_stars(num):
	texture = star_textures[num]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
