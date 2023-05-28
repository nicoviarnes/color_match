extends Control

@onready var current_score = $Score

var overall_score = 0
var score : int = 0

signal all_matched

func _on_update_score(i, maxScore):
	score += i
	overall_score += i
	ScoreManager.score = overall_score
	current_score.text = "Score: " + str(overall_score)
	if score >= maxScore:
		emit_signal("all_matched")


func reset_score():
	score = 0
