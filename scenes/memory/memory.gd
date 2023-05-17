extends ColorRect

@onready var glow = $Glow
@onready var card_back = $Cardback
@onready var flip_timer = $FlipTimer

var flipped : bool = false

signal selected(node)

func resolve_match():
	set_mouse_filter(2)
	color = Color(1, 1, 1, 0)
	glow.visible = false


func flip_card():
	if not flipped:
		card_back.visible = false
		flipped = true
		return
	card_back.visible = true
	flipped = false


func _on_mouse_entered():
	if not flipped:
		glow.visible = true


func _on_mouse_exited():
	if not flipped:
		glow.visible = false


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		glow.visible = false
		emit_signal("selected", self)


func _on_flip_timer_timeout():
	flip_card()
