extends Control


@onready var remaining = $Remaining
@onready var timer = $Timer
@onready var timer_bar = $TimerBar

signal out_of_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	timer_bar.value = int(timer.get_time_left())
	remaining.text = str(int(timer.get_time_left()))


func _on_timer_timeout():
	emit_signal("out_of_time")


func reset_timer():
	timer.start()
