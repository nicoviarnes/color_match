extends Control

@onready var score_component = $Score
@onready var level_timer_component = $LevelTimer
@onready var grid = $Grid
@onready var left_slide = $LeftSlide
@onready var right_slide = $RightSlide
@onready var build_timer = $Timer

@onready var bg = $TextureRect2
@onready var cloud_timer = $CloudTimer

var Cloud = preload("res://scenes/game/cloud/cloud.tscn")


func game_over():
	grid.grid_size = 2
	get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")
	

func _on_all_matched():
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	build_timer.start()
	tween1.tween_property(left_slide, "position", Vector2(304, 14), .3).set_trans(Tween.TRANS_SINE)
	tween2.tween_property(right_slide, "position", Vector2(560, 14), .3).set_trans(Tween.TRANS_SINE)
	tween1.tween_property(left_slide, "position", Vector2(-621, 14), .3).set_trans(Tween.TRANS_SINE)
	tween2.tween_property(right_slide, "position", Vector2(1632, 14), .3).set_trans(Tween.TRANS_SINE)	


func rebuild_grid():
	grid.grid_size += 2
	score_component.reset_score()
	level_timer_component.reset_timer(grid.grid_size)
	grid.make_grid()


func _on_timer_timeout():
	rebuild_grid()


func _on_cloud_timer_timeout():
	var cloud = Cloud.instantiate()
	cloud.position.y = randi_range(770, 1400)
	cloud.position.x = 2134
	var rand_scale = randf_range(0.4, 1.0)
	cloud.scale.x = rand_scale
	cloud.scale.y = rand_scale
	bg.add_child(cloud)
	cloud_timer.start()
