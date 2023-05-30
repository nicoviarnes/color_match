extends Control

@onready var bgm_slider = $"Window2-blue/BGM"
@onready var sfx_slider = $"Window2-blue/SFX"

@onready var bg = $TextureRect3
@onready var cloud_timer = $CloudTimer

var Cloud = preload("res://scenes/game/cloud/cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/ui.tscn")


func _on_bgm_drag_ended(_value_changed):
	MusicManager.bus_volume(linear_to_db(bgm_slider.value))


func _on_sfx_drag_ended(_value_changed):
	AudioManager.bus_volume(linear_to_db(sfx_slider.value))


func _on_cloud_timer_timeout():
	var cloud = Cloud.instantiate()
	cloud.position.y = randi_range(770, 1400)
	cloud.position.x = 2134
	var rand_scale = randf_range(0.4, 1.0)
	cloud.scale.x = rand_scale
	cloud.scale.y = rand_scale
	bg.add_child(cloud)
	cloud_timer.start()
