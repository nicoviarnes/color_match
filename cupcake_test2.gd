extends TextureRect

var cupcake_type : String

@onready var glow = $Glow
@onready var smile_timer = $SmileTimer
@onready var blink_timer = $BlinkTimer
@onready var card_back = $Cardback

@export var click_sound : AudioStreamWAV
@export var particles : PackedScene

var flipped : bool = false
var matched : bool = false

signal selected(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	var texture_directory = "res://assets/cupcakes/" + cupcake_type + "/"
	for i in 5:
		var cupcake = texture_directory + cupcake_type + "_0" + str(i + 1) + ".png"
		texture.set_frame_texture(i, load(cupcake))
	texture.pause = true


func resolve_match():
	smile_timer.stop()
	blink_timer.stop()
	matched = true
	texture.current_frame = 3
	set_mouse_filter(2)
	glow.visible = false
	card_back.visible = false
	flipped = false  # Ensure flipped is set to false
	var particle = particles.instantiate()
	particle.position = size / 2
	add_child(particle)


func flip_card():
	card_back.visible = flipped  # if flipped == true then card_back.visible = true, else card_back.visible = false
	flipped = !flipped  # flip the state


func _on_mouse_entered():
	if not flipped:
		glow.visible = true



func _on_mouse_exited():
	glow.visible = false


func _on_gui_input(event):
	if not matched:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			AudioManager.play(click_sound, -25.0)
			glow.visible = false
			texture.current_frame = 2
			smile_timer.start()
			emit_signal("selected", self)


func set_mouse_input(enabled: bool):
	set_mouse_filter(MOUSE_FILTER_IGNORE) if !enabled else set_mouse_filter(MOUSE_FILTER_PASS)


func _on_smile_timer_timeout():
	texture.current_frame = 0
	blink_timer.start()
	

func _on_blink_timer_timeout():
	texture.current_frame = 1
	smile_timer.start()
