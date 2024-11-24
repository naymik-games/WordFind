extends TextureButton
@onready var letter_label = $Label
var id
var letter
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_letter(letter_t, id):
	if !letter_label:
		letter_label = $Label
	letter_label.text = letter_t
	letter = letter_t
	id = id
	
