extends Control

@export var bgm : AudioStreamWAV
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(bgm, -30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
