extends Node2D


const TUTORIAL = preload("uid://b0hx46cfdae1b")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(TUTORIAL)
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	$CanvasLayer/Control/Button.scale = Vector2(0.9,0.9)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	$CanvasLayer/Control/Button.scale = Vector2(1,1)
	pass # Replace with function body.
