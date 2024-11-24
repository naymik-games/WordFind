extends Node

const FILE_NAME = "user://current_game-data.save"
var level_data = {}
var current_level = 1
var current_page = 1
var default_data = {
	"11": {
	"unlocked": 0,
	"score": 0,
	"stars": 0
	}
}

func _ready():
	#level_data = default_data
	#save_data()
	pass

func save_data():
	var save_file = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	save_file.store_var(level_data)
	save_file.store_var(current_level)
	save_file.store_var(current_page)
	save_file.close()

func load_data():
	if FileAccess.file_exists(FILE_NAME):
		var save_file = FileAccess.open(FILE_NAME, FileAccess.READ)
		level_data = save_file.get_var()
		current_level = save_file.get_var()
		current_page = save_file.get_var()
		save_file.close()
		print(level_data)
	else:
		print("no saved file...")
		level_data = default_data
		current_level = 1
		current_page = 1
		
