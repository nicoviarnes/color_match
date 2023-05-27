extends Camera2D

@onready var shake_timer = $ShakeTimer
@onready var shake_intensity = 15
var default_offset = offset


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var shake_vector = Vector2(randf_range(-1, 1) * shake_intensity, randf_range(-1, 1) * shake_intensity)
	var tween = create_tween()
	tween.tween_property(self, "offset", shake_vector, 0.1)


func screen_shake(intensity):
	shake_intensity = intensity
	set_process(true)
	shake_timer.start()


func _on_shake_timer_timeout():
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self, "offset", default_offset, 0.1)
