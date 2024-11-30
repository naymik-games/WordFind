extends HBoxContainer
var word_score = 0
var total_score = 0
@onready var word_score_label = $"MarginContainer/word score"
@onready var word_bonus_label = $MarginContainer2/wordbonus
@onready var word_total_label = $MarginContainer3/wordtotal
@onready var game_total_label = $MarginContainer4/gametotal
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grid_update_word_score(amount, bonus):
	word_score_label.text = str(amount)
	word_bonus_label.text = "x" + str(bonus)
	if bonus > 0:
		word_total_label.text = str(amount * bonus)
	else:
		word_total_label.text = str(amount)
	


func _on_grid_update_word_score_final(amount, bonus, total):
	word_score_label.text = str(amount)
	word_bonus_label.text = "x" + str(bonus)
	word_total_label.text = str(amount * bonus)
	
	game_total_label.text = str(total)
	
