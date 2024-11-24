extends Control
@onready var block = preload("res://scene/level_block.tscn")
@onready var level_grid = $VBoxContainer
var next_page_key: String
var prev_page_key: String
@onready var previous_page = $HBoxContainer/previous_page
@onready var next_page = $HBoxContainer/next_page

# Called when the node enters the scene tree for the first time.
func _ready():
	SaveData.load_data()
	var num_levels = Levels.levels.size()
	print(str(SaveData.current_page))
	print(num_levels/8)
	create_levels()
	update_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_levels():
	#str(SaveData.current_page)+str(SaveData.current_level)
	
	for i in range(1,9):
		var new_block = block.instantiate()
		var lev_name = Levels.levels[str(SaveData.current_page)+str(i)][0]
		new_block.set_level(i, lev_name)
		level_grid.add_child(new_block)

func update_buttons():
	prev_page_key = str(SaveData.current_page - 1) + "1"
	print(prev_page_key)
	next_page_key = str(SaveData.current_page + 1) + "1"
	print(next_page_key)
	previous_page.disabled = true
	next_page.disabled = true
	if Levels.levels.has(prev_page_key):
		print("priv page")
		previous_page.disabled = false
	if Levels.levels.has(next_page_key):
		print("next page")
		next_page.disabled = false

func clear_levels():
	for n in level_grid.get_children():
		level_grid.remove_child(n)
		n.queue_free()

func _on_previous_page_pressed():
	clear_levels()
	SaveData.current_page -= 1
	SaveData.current_level = 1
	create_levels()
	update_buttons()


func _on_next_page_pressed():
	clear_levels()
	SaveData.current_page += 1
	SaveData.current_level = 1
	create_levels()
	update_buttons()
