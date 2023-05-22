extends Control


@onready var remaining = $Remaining
@onready var timer = $Timer
@onready var timer_bar = $TimerBar

var base_time = 10.00

signal out_of_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	timer_bar.value = int(timer.get_time_left())
	remaining.text = str(int(timer.get_time_left()))


func _on_timer_timeout():
	emit_signal("out_of_time")


func reset_timer(grid_size):
	timer.wait_time = timer.get_time_left() + (base_time * grid_size)
	timer_bar.max_value = timer.wait_time
	timer.start()
