extends Control

@onready var current_score = $CurrentScore
@onready var max_score = $MaxScore

var score : int = 0

signal all_matched

func _on_update_score(i, maxScore):
	score += i
	current_score.text = str(score)
	max_score.text = str(maxScore)
	if score >= maxScore:
		emit_signal("all_matched")


func reset_score():
	score = 0
