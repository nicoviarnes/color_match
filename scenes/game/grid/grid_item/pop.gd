extends TextureRect

@onready var pop_timer = $PopTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.pause = true
	texture.current_frame = 0


func pop():
	visible = true
	texture.pause = false
	

func _process(_delta):
	if texture.current_frame == 3:
		pop_timer.start()


func _on_pop_timer_timeout():
	queue_free()
