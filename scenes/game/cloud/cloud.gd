extends Sprite2D

var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(1, 4)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x -= speed
