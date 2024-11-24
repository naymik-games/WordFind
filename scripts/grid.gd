extends Node2D

enum {wait, move}
var state

	
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var x_offset: int
@export var Double_Bonus_Count: int
@export var Triple_Bonus_Count: int
@export var empty_spaces: PackedVector2Array

signal update_word
signal update_word_status
signal update_word_score
signal update_word_score_final
signal clear_word_score
signal update_puzzle_info
signal update_puzzle_name
signal setup_clues
signal remove_clue
signal update_counter

@onready var game_over_scene = preload("res://scene/game_over_screen.tscn")

@export var current_counter_value: int =0
@export var is_moves: bool = false

var letters = {
	0: "a",
	1: "b",
	2: "c",
	3: "d",
	4: "e",
	5: "f",
	6: "g",
	7: "h",
	8: "i",
	9: "j",
	10: "k",
	11: "l",
	12: "m",
	13: "n",
	14: "o",
	15: "p",
	16: "q",
	17: "r",
	18: "s",
	19: "t",
	20: "u",
	21: "v",
	22: "w",
	23: "x",
	24: "y",
	25: "z"
}

var letters_to_index = {
	 "a": 0,
	 "b": 1,
	 "c": 2,
	 "d": 3,
	 "e": 4,
	 "f": 5,
	 "g": 6,
	 "h": 7,
	 "i": 8,
	 "j": 9,
	 "k": 10,
	 "l": 11,
	 "m": 12,
	 "n": 13,
	 "o": 14,
	 "p": 15,
	 "q": 16,
	 "r": 17,
	 "s": 18,
	 "t": 19,
	 "u": 20,
	 "v": 21,
	 "w": 22,
	 "x": 23,
	 "y": 24,
	 "z": 25
}

var values = {
	0: 1,
	1: 3,
	2: 3,
	3: 2,
	4: 1,
	5: 4,
	6: 2,
	7: 4,
	8: 1,
	9: 8,
	10: 5,
	11: 1,
	12: 3,
	13: 1,
	14: 1,
	15: 3,
	16: 10,
	17: 1,
	18: 1,
	19: 1,
	20: 1,
	21: 4,
	22: 4,
	23: 8,
	24: 4,
	25: 10
}
#touch pieces
var first_touch = Vector2(0,0)
var final_touch = Vector2(0,0)
var last_touch = Vector2(0,0)
var controlling = false

var all_pieces = []
var current_matches = []
var possible_tiles = [
	preload("res://scene/letter.tscn"),

]
var puzzle_line = preload("res://scene/puzzle_line.tscn")
var cross_grid = [] #datagrid for puzzle
var word_bank = [] #words in puzzle
var word_list = [] #dictionary
var found_words =[] #found words
var clues =[] #array of word bank first letters
var theme #first word in wordback

var puzzle_word_count = 0
var puzzle_found_count = 0
var puzzle_solved: bool = false
var game_over: bool = false

var word_value = 0
var word = ""
var text_file_path = "res://assets/ScrabbleWordListasText.txt"

var total_score: int = 0

signal add_line_point
signal remove_line_last
signal clear_line


func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func is_in_array(array, item):
	for i in array.size():
		if array[i] == item:
			return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_text_file_content(text_file_path)
	all_pieces = make_2d_array()
	
	#puzzle stuff
	word_bank = Levels.levels[str(SaveData.current_page)+str(SaveData.current_level)]
	puzzle_word_count = word_bank.size()
	var crossword = Crossword.new()
	crossword.createGrid(width, height, word_bank)
	cross_grid = crossword.get_grid()
	make_clues()

	emit_signal("update_puzzle_info", puzzle_found_count, puzzle_word_count)
	emit_signal("update_puzzle_name", word_bank[0])
	
	#finder
	var input_string = "always"
	var combinations = []
	get_combinations(input_string, "", combinations)
	#filter_combinations()
	
	print(combinations)
	

	spawn_pieces()
	emit_signal("update_counter",current_counter_value)
	if !is_moves:
		$game_timer.start()
	
	state = move
#	var end_full = float(OS.get_unix_time())
#	print ("time: ", end_full - start_full)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == move:
		touch_input()


func get_text_file_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var index = 1
	while not file.eof_reached():
		var line = file.get_line()
		word_list.append(line)
		index += 1
	file.close()

	
func spawn_pieces():
	for i in width:
		for j in height:
			if !restricted_fill(Vector2(i,j)):
				var rand = floor(randi_range(0, 25))
				var tile = possible_tiles[0].instantiate()
				add_child(tile)
				tile.set_position(grid_to_pixel(i, j));
				#tile.change_texture(rand, values[rand])
			
				if cross_grid[j][i] == " ":
					tile.change_texture(rand, values[rand])
				else:
					#print(cross_grid[j][i])
					var gridletterindex = letters_to_index[cross_grid[j][i]]
					tile.change_texture(gridletterindex, values[gridletterindex])
				
				all_pieces[i][j] = tile
	make_double_word()
	make_triple_word()

func make_double_word():
	while Double_Bonus_Count > 0:
		var randC = randi_range(0, width-1)
		var randR = randi_range(0, height-1)
		if all_pieces[randC][randR].bonus == 0:
			all_pieces[randC][randR].bonus = 2
			all_pieces[randC][randR].modulate = "499263"
			Double_Bonus_Count -=1

func make_triple_word():
	while Triple_Bonus_Count > 0:
		var randC = randi_range(0, width-1)
		var randR = randi_range(0, height-1)
		if all_pieces[randC][randR].bonus == 0:
			all_pieces[randC][randR].bonus = 3
			all_pieces[randC][randR].modulate = "d44d76"
			Triple_Bonus_Count -=1

func make_clues():
	var temp = []
	for i in word_bank.size():
		temp.append(word_bank[i].left(1))
	emit_signal("setup_clues", temp)
	
func get_combinations(input_string: String, current: String, combinations: Array) -> void:
	if current.length() > 2:
		if word_list.has(current):
			combinations.append(current)
	
	for i in range(input_string.length()):
		var next_char = input_string[i]
		var remaining_string = input_string.substr(0, i) + input_string.substr(i + 1)
		get_combinations(remaining_string, current + next_char, combinations)

func filter_combinations():
	pass

func restricted_fill(place):
	#check empty
	if is_in_array(empty_spaces, place):
		return true
	#if is_in_array(concrete_spaces, place):
		#return true
	#if is_in_array(slime_spaces, place):
		#return true
	return false

func grid_to_pixel(column, row):
	var new_x = x_start + x_offset * column
	var new_y = y_start + -x_offset * row
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / x_offset)
	var new_y = round((pixel_y - y_start) / -x_offset)
	return Vector2(new_x, new_y)

func is_null(grid_position):
	if all_pieces[grid_position.x][grid_position.y] == null:
		return true
	return false

func is_in_grid(grid_position):
	if grid_position.x >= 0 && grid_position.x < width:
		if grid_position.y >= 0 && grid_position.y < height:
			return true
	return false

#take two vector of screen coordinates
func distance_between(point1,point2):
	return point1.distance_to(point2)

#screen, not grid
func near_tile_center(point1,point2):
	if distance_between(point1,point2) <= 20:
		return true
	return false

func touch_input():
	
	var mouse_screen = get_global_mouse_position()
	var mouse = pixel_to_grid(mouse_screen.x, mouse_screen.y)
	var center = Vector2()
	#first tile
	if Input.is_action_just_pressed("ui_touch"):
		if is_in_grid(mouse) and !is_null(mouse) and !controlling:
			first_touch = mouse
			if !is_in_array(current_matches,mouse):
				word += letters[all_pieces[mouse.x][mouse.y].index]
				word_value += all_pieces[mouse.x][mouse.y].value
				print(word)
				emit_signal("update_word_status",0)
				emit_signal("add_line_point",grid_to_pixel(mouse.x,mouse.y))
				current_matches.append(mouse)
				all_pieces[mouse.x][mouse.y].dim()
				controlling = true
	#next tiles
	if controlling:
		if is_in_grid(mouse) and !is_null(mouse):
			#new tile
			if valid_drag(get_last_match(), mouse) and near_tile_center(mouse_screen, grid_to_pixel(mouse.x,mouse.y)):
				last_touch = mouse
				current_matches.append(mouse)
				all_pieces[mouse.x][mouse.y].dim()
				word += letters[all_pieces[mouse.x][mouse.y].index]
				word_value += all_pieces[mouse.x][mouse.y].value
				print(word)
				emit_signal("update_word_score",word_value,0)
				emit_signal("update_word",word)
				emit_signal("add_line_point",grid_to_pixel(mouse.x,mouse.y))
			#backtrack
			elif is_second_to_last(mouse) and current_matches.size() >1:
				print("backtrack")
				remove_last_match()
				emit_signal("remove_line_last")
				word = word.left(word.length() - 1)
				word_value -= all_pieces[last_touch.x][last_touch.y].value
	#release
	if Input.is_action_just_released("ui_touch"):
		if controlling:
			controlling = false
			emit_signal("clear_line")
			if current_matches.size() > 2:
				#temp
				if found_words.has(word):
					print("word found")
					emit_signal("update_word_status",3)
				elif word_bank.has(word):
					print("puzzle word found")
					var word_bonus = get_bonus_total()
					if word.length() >= 6:
						word_bonus += 6
					set_score(word_value, word_bonus)
					
					puzzle_found_count += 1
					emit_signal("update_puzzle_info", puzzle_found_count, puzzle_word_count)
					if puzzle_found_count == puzzle_word_count:
						puzzle_solved = true
					found_words.append(word)
					draw_puzzle_line()
					emit_signal("update_word_status",1)
					emit_signal("remove_clue",word.left(1))
					if is_moves:
						counter_update()
					
				elif word_list.has(word):
					print("word found")
					print(str(word_value))
					var word_bonus = get_bonus_total()
					if word.length() >= 6:
						word_bonus += 6
					set_score(word_value, word_bonus)				
					found_words.append(word)
					emit_signal("update_word_status",1)
					if is_moves:
						counter_update()
					
				else:
					print("not found")
					emit_signal("update_word_status",2)
				current_matches.clear()
				for i in width:
					for j in height:
						if all_pieces[i][j] != null:
							all_pieces[i][j].undim()
				word = ""
				word_value = 0
			else:
				word = ""
				word_value = 0
				current_matches.clear()
				for i in width:
					for j in height:
						if all_pieces[i][j] != null:
							all_pieces[i][j].undim()

func set_score(score, bonus):
	if bonus == 0:
		bonus = 1
	
	total_score += score * bonus
	emit_signal("update_word_score_final",score, bonus,total_score)
	pass

func get_bonus_total():
	var bonus_total =0
	for i in current_matches.size():
		var temp = current_matches[i]
		bonus_total += all_pieces[temp.x][temp.y].bonus
	return bonus_total

func get_last_match():
	return current_matches[-1]
func remove_last_match():
	current_matches.pop_back()
	all_pieces[last_touch.x][last_touch.y].undim()
func valid_drag(last,current):
	if is_adjecent(last,current) and !is_in_array(current_matches,current):
		return true
	return false
#func is_match(current):
	#if all_pieces[current.x][current.y].color == current_color:
		#return true
	#return false
func is_adjecent(p1, p2):
	# allow cardinal
	#return (abs(p1.x - p2.x) == 1 && p1.y - p2.y == 0) || (abs(p1.y - p2.y) == 1 && p1.x - p2.x == 0);
	# allow diagonal
	return (abs(p1.x - p2.x) <= 1) && (abs(p1.y - p2.y) <= 1)
	#var difference = grid_2-grid_1
	#if abs(difference.x) > abs(difference.y):
		#if difference.x > 0:
			#return true
		#elif difference.x < 0:
			#return true
	#elif abs(difference.y) > abs(difference.x):
		#if difference.y > 0:
			#return true
		#elif difference.y < 0:
			#return true
	#return false

func draw_puzzle_line():
	var new_line = puzzle_line.instantiate()
	add_child(new_line)
	for i in current_matches.size():
		var temp = current_matches[i]
		new_line.draw_point(grid_to_pixel(temp.x, temp.y))
	pass

func counter_update():
	
	current_counter_value -=1
	emit_signal("update_counter",current_counter_value)
	if current_counter_value == 0:
		declare_game_over()
	
func declare_game_over():
	game_over = true
	state = wait
	print("Game Over")
	var over_screen = game_over_scene.instantiate()
	add_child(over_screen)
	over_screen.set_stats(puzzle_solved, total_score, 2)
	if puzzle_solved:
		print("puzzle solved")
	else:
		print("puzzle not complete")

func complete_square(current):
	if is_in_array(current_matches,current):
		var temp_matches = current_matches.duplicate()
		temp_matches.append(current)
		var index = temp_matches.find(current)
		var circle = temp_matches.slice(index,temp_matches.size())
		if circle.size() >= 5:
			return true
	return false




func is_second_to_last(piece):
	var secondToLastDot = getSecondToLastElement(current_matches);
	if secondToLastDot == piece:
		return true
	return false

func getLastElement(array):
	return getLaterElements(array, 1);

func getSecondToLastElement(array):
	return getLaterElements(array, 2);

func getLaterElements(array, index):
	return array[array.size() - index];

#func touch_difference(grid_1, grid_2):
	#var difference = grid_2-grid_1
	#if abs(difference.x) > abs(difference.y):
		#if difference.x > 0:
			#swap_pieces(grid_1.x, grid_1.y, Vector2(1,0))
		#elif difference.x < 0:
			#swap_pieces(grid_1.x, grid_1.y, Vector2(-1,0))
	#elif abs(difference.y) > abs(difference.x):
		#if difference.y > 0:
			#swap_pieces(grid_1.x, grid_1.y, Vector2(0,1))
		#elif difference.y < 0:
			#swap_pieces(grid_1.x, grid_1.y, Vector2(0,-1))
#var distance = new Phaser.Point(e.position.x - this.tileGroup.x, e.position.y - this.tileGroup.y).distance(this.tilesArray[row][col]);

class Crossword:
	var gridRows = 10
	var gridCols = 10
	var placed_words = []
	var words = []
	#const grid = Array.from({ length: gridRows }, () => Array(gridCols).fill(''))
	var grid = []
	
	#console.log(grid)
	const directions = [
		{ "row": 0, "col": 1 }, # Horizontal
		{ "row": 1, "col": 0 },  # Vertical
		{ "row": 1, "col": 1 },  # Diagonal (down-right)
		{ "row": 1, "col": -1 }, # Diagonal (down-left)
	]
	
	func make_grid():
		var array = []
		for i in gridRows:
			array.append([])
			for j in gridCols:
				array[i].append(" ")
		return array
	
	func get_grid():
		return grid
	
	func createGrid(columns, rows, words):
		gridRows = rows
		gridCols = columns
		words = words
		print(words)
		grid = make_grid()
		for i in words.size():
			placeWord(words[i])
		print(grid)	
		grid.reverse()
		print(grid)
		
		
	func placeWord(word):
		var wordLength = word.length()
		var placed = false;
		var count = 0
		while !placed and count < 200:
			#var rand = floor(randi_range(0, 25))
			var startRow = floor(randi_range(0, gridRows-1))
			var startCol = floor(randi_range(0, gridCols-1))
			var direction = directions[floor(randi_range(0, 3))]

			var endRow = startRow + direction["row"] * (wordLength - 1)
			var endCol = startCol + direction["col"] * (wordLength - 1)

			if isValidPlacement(startRow, startCol, endRow, endCol, direction, wordLength,word):
				for i in wordLength:
					var currentRow = startRow + direction.row * i
					var currentCol = startCol + direction.col * i
					grid[currentRow][currentCol] = word[i]
				
				placed = true
			count += 1

	func isValidPlacement(startRow, startCol, endRow, endCol, direction, wordLength,word):
		if endRow < 0 or endRow >= gridRows or endCol < 0 or endCol >= gridCols:
			return false;
		for i in wordLength:
			var currentRow = startRow + direction["row"] * i;
			var currentCol = startCol + direction["col"] * i;

			if grid[currentRow][currentCol] != " " and grid[currentRow][currentCol] != word[i]:
				return false;
		
		placed_words.append(word)
		return true;
	
	


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_replay_button_pressed():
	get_tree().reload_current_scene()


func _on_game_timer_timeout():
	if !game_over:
		counter_update()
	
