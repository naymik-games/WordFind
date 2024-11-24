extends Node2D
@export var letter: String
@export var value: int
@export var index: int
var bonus = 0
var center_point
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = index
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_texture(frame, letter_value):
	$Sprite2D.frame = frame
	index = frame
	value = letter_value

func move(target):
	var tween: Tween = create_tween()
	tween.tween_property(self,"position",target, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func dim():
	$Sprite2D.modulate.a = .8	

func undim():
	$Sprite2D.modulate.a = 1	
