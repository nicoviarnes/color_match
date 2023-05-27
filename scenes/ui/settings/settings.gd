extends Control

@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
@onready var anim3 = $SolidPinkDollop07
@onready var anim4 = $AnimatedSprite2D2
@onready var anim5 = $SolidBlueDollop04
@onready var anim6 = $SolidGreenDollop06

@onready var bgm_slider = $"Window2-blue/BGM"
@onready var sfx_slider = $"Window2-blue/SFX"


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	
	var anims = [anim1, anim2, anim3, anim4, anim5, anim6]
	for anim in anims:
		anim.play("default")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/ui.tscn")


func _on_bgm_drag_ended(value_changed):
	MusicManager.bus_volume(linear_to_db(bgm_slider.value))


func _on_sfx_drag_ended(value_changed):
	AudioManager.bus_volume(linear_to_db(sfx_slider.value))
