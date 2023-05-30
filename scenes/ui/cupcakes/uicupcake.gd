extends TextureRect

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.pause = true


func _on_timer_timeout():
	
	if get_tree().current_scene.name == "Main":
		var random_frame = randi_range(0, 3)
		texture.current_frame = random_frame
		timer.start()
		return


	if get_tree().current_scene.name == "Game":
		var random_frame = randi_range(0, 3)
		texture.current_frame = random_frame
		timer.start()
		return


	if get_tree().current_scene.name == "Settings":
		var random_frame = randi_range(0, 3)
		texture.current_frame = random_frame
		timer.start()
		return

	if get_tree().current_scene.name == "GameOver":
		var random_frame = randi_range(4, 6)
		texture.current_frame = random_frame
		timer.start()
		return
