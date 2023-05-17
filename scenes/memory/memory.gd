extends ColorRect

@onready var glow = $Glow

signal selected(node)

func resolve_match():
	set_mouse_filter(2)
	color = Color(1, 1, 1, 0)
	glow.visible = false

func _on_mouse_entered():
	glow.visible = true


func _on_mouse_exited():
	glow.visible = false


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
