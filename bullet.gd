extends Node2D





func _physics_process(delta: float) -> void:
	global_position.x -= 20
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Player):
		if body.is_parry_window > 0:
			print("PARRY")
			body.parried()
			pass
		elif not body.shield:
			Global.damage(5)
			pass
		else:
			Global.push_back()
			body.countered()
	elif body and body.is_in_group("crowd"):
			Global.damage(5)
	queue_free()
	pass # Replace with function body.
