extends Control

@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
@onready var anim3 = $SolidPinkDollop07
@onready var anim4 = $AnimatedSprite2D2
@onready var anim5 = $SolidBlueDollop04
@onready var anim6 = $SolidGreenDollop06

@onready var bg = $TextureRect3
@onready var cloud_timer = $CloudTimer

var Cloud = preload("res://scenes/game/cloud/cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var anims = [anim1, anim2, anim3, anim4, anim5, anim6]
	for anim in anims:
		anim.play("default")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_settings_pressed():
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
