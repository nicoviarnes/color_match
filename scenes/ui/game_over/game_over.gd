extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/ui.tscn")
