extends TextureRect

var cupcake_type : String

@onready var glow = $Glow
@onready var smile_timer = $SmileTimer
@onready var blink_timer = $BlinkTimer
@onready var card_back = $Cardback
@onready var match_timer = $MatchTimer

@export var pop : PackedScene
@export var click_sound : AudioStreamWAV
@export var particles : PackedScene
@export var mouseover_sound : AudioStreamWAV

@export var solid_blue_dollop : AnimatedTexture
@export var solid_green_dollop : AnimatedTexture
@export var solid_lime_dollop : AnimatedTexture
@export var solid_orange_dollop : AnimatedTexture
@export var solid_pink_dollop : AnimatedTexture
@export var solid_salmon_dollop : AnimatedTexture

var flipped : bool = false
var matched : bool = false

signal selected(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	match cupcake_type:
		"solid_blue_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_blue_dollop
			texture = tex
		"solid_green_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_green_dollop
			texture = tex
		"solid_lime_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_lime_dollop
			texture = tex
		"solid_orange_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_orange_dollop
			texture = tex
		"solid_pink_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_pink_dollop
			texture = tex
		"solid_salmon_dollop":
			var tex = AnimatedTexture.new()
			tex = solid_salmon_dollop
			texture = tex

	texture.pause = true


func resolve_match():
	smile_timer.stop()
	blink_timer.stop()
	matched = true
	texture.current_frame = 3
	set_mouse_filter(MOUSE_FILTER_IGNORE)
	glow.visible = false
	card_back.visible = false
	flipped = false  # Ensure flipped is set to false
	var particle = particles.instantiate()
	particle.position = size / 2
	add_child(particle)
	match_timer.start()


func flip_card(clear):
	card_back.visible = flipped  # if flipped == true then card_back.visible = true, else card_back.visible = false
	flipped = !flipped  # flip the state
	if clear:
		set_mouse_filter(MOUSE_FILTER_IGNORE)
		card_back.visible = false
		glow.visible = false


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
			texture.current_frame = 5
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


func _on_match_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), .5).set_trans(Tween.TRANS_SINE)
