extends Control

@onready var score_component = $Score
@onready var level_timer_component = $LevelTimer
@onready var grid = $Grid


func _ready():
	print(grid.size)

func game_over():
	grid.grid_size = 2
	get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")
	

func _on_all_matched():
	grid.grid_size += 2
	score_component.reset_score()
	level_timer_component.reset_timer(grid.grid_size)
	grid.make_grid()
