extends Node2D


const MAIN = preload("uid://beepwvmu7u7b3")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)
	pass # Replace with function body.
