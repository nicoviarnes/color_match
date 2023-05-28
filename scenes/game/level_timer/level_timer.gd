extends Control


@onready var remaining = $TimerBar/Remaining
@onready var timer = $Timer
@onready var timer_bar = $TimerBar
@onready var mute_button = $TimerBar/Mute
@onready var unmute_button = $TimerBar/Unmute

var base_time = 10.00

var current_db

var SCORE = -1

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


func _on_mute_pressed():
	var BUS = AudioServer.get_bus_index("Master")
	current_db = AudioServer.get_bus_volume_db(BUS)
	AudioServer.set_bus_volume_db(BUS, -100)
	mute_button.visible = false
	unmute_button.visible = true


func _on_unmute_pressed():
	var BUS = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(BUS, current_db)
	mute_button.visible = true
	unmute_button.visible = false
