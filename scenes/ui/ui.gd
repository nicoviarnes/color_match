extends Control

@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
@onready var anim3 = $SolidPinkDollop07
@onready var anim4 = $AnimatedSprite2D2
@onready var anim5 = $SolidBlueDollop04
@onready var anim6 = $SolidGreenDollop06


# Called when the node enters the scene tree for the first time.
func _ready():
	var anims = [anim1, anim2, anim3, anim4, anim5, anim6]
	for anim in anims:
		anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_settings_pressed():
	pass # Replace with function body.
