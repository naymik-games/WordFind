extends NinePatchRect
@onready var number = $MarginContainer/hbox/number
@onready var name1 = $MarginContainer/hbox/VBoxContainer/name
@onready var score = $MarginContainer/hbox/VBoxContainer/score

var over = false
var selected_level: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("ui_touch"):
		#if over:
			#print("clicked")
			#SaveData.current_level = selected_level
			#get_tree().change_scene_to_file("res://scene/game_window.tscn")
	if Input.is_action_just_released("ui_touch"):
		if over:
			print("clicked")
			SaveData.current_level = selected_level
			get_tree().change_scene_to_file("res://scene/game_window.tscn")

func set_level(level_num: int, level_name: String):
	if !number:
		number =  $MarginContainer/hbox/number
	if !name1:
		name1 =  $MarginContainer/hbox/VBoxContainer/name
	if !score:
		score = $MarginContainer/hbox/VBoxContainer/score
	number.text = str(level_num)
	name1.text = level_name.to_upper()
	selected_level = level_num
	if SaveData.level_data.has(str(SaveData.current_page)+str(selected_level)):
		score.text = str(SaveData.level_data[str(SaveData.current_page)+str(selected_level)].score)
		#get_tree().call_group("star_group","set_stars",2)
	else:
		score.text = str(0)
		#get_tree().call_group("star_group","set_stars",0)

#str(SaveData.current_page)+str(selected_level)


func _on_mouse_entered():
	print("over start")
	over = true
	pass # Replace with function body.


func _on_mouse_exited():
	over = false
	pass # Replace with function body.
