extends ColorRect

@onready var sprite = $Sprite2D
@onready var glow = $Glow
@onready var animation = $AnimationPlayer
@onready var smile_timer = $SmileTimer
@onready var card_back = $Cardback


var flipped : bool = false
var matched : bool = false

signal selected(node)

func resolve_match():
	matched = true
	animation.play("matched")
	set_mouse_filter(2)
	color = Color(1, 1, 1, 0)
	glow.visible = false
	card_back.visible = false
	flipped = false  # Ensure flipped is set to false



func flip_card():
	card_back.visible = flipped  # if flipped == true then card_back.visible = true, else card_back.visible = false
	flipped = !flipped  # flip the state


func _on_mouse_entered():
	if not matched:
		glow.visible = true



func _on_mouse_exited():
	glow.visible = false


func _on_gui_input(event):
	if not matched:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			glow.visible = false
			animation.play("clicked")
			smile_timer.start()
			emit_signal("selected", self)


func set_mouse_input(enabled: bool):
	set_mouse_filter(MOUSE_FILTER_IGNORE) if !enabled else set_mouse_filter(MOUSE_FILTER_PASS)


func _on_smile_timer_timeout():
	animation.play("idle")