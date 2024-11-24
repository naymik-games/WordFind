extends CanvasLayer

@onready var title = $CenterContainer/NinePatchRect/MarginContainer/CenterContainer/VBoxContainer/title
@onready var score_label = $CenterContainer/NinePatchRect/MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/score_label
@onready var stars = $CenterContainer/NinePatchRect/MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/HBoxContainer/stars





func set_stats(win, new_score, starnumber):
	if win:
		title.text = "PUZZLE SOLVED!"
		SaveData.level_data[str(SaveData.current_page)+str(SaveData.current_level)] = {
			"unlocked": 0,
			"score": new_score,
			"stars": starnumber
		}
		get_tree().call_group("star_group","set_stars",starnumber)
		print(SaveData.level_data)
		SaveData.save_data()
		
	else:
		get_tree().call_group("star_group","set_stars",0)
		title.text = "INCOMPLETE"
	score_label.text = str(new_score)
	

func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scene/level_select.tscn")
