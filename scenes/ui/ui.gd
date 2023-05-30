extends Control

@onready var bg = $TextureRect3
@onready var cloud_timer = $CloudTimer

var Cloud = preload("res://scenes/game/cloud/cloud.tscn")


func _on_play_pressed():
	ScoreManager.score = 0
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_settings_pressed():
	ScoreManager.score = 0
	get_tree().change_scene_to_file("res://scenes/ui/settings/settings.tscn")


func _on_cloud_timer_timeout():
	var cloud = Cloud.instantiate()
	cloud.position.y = randi_range(770, 1400)
	cloud.position.x = 2134
	var rand_scale = randf_range(0.4, 1.0)
	cloud.scale.x = rand_scale
	cloud.scale.y = rand_scale
	bg.add_child(cloud)
	cloud_timer.start()
