extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pause()
	frame = 0


func pop():
	visible = true
	play("default")


func _on_animation_finished():
	queue_free()
