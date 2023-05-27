extends Control

@export var bgm : AudioStreamWAV
# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play(bgm, -35)
