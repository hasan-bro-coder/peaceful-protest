extends Node

var progress := 0.0

func damage(amout : int):
	$"../main".damage(amout)
func push_back():
	$"../main".push_back()

	
	pass

var shake_strength := 0.0
var shake_time := 0.0

var shake_duration := 0.0
var shake_frequency := 25.0
var shake_rotation := 0.0

var camera: Camera2D
var shake_offset := Vector2.ZERO


func camera_shake(
	strength: float = 8.0,
	duration: float = 0.12,
	frequency: float = 25.0,
	rotation_strength: float = 1.0
):
	shake_strength = max(shake_strength, strength)
	shake_duration = max(shake_duration, duration)
	shake_time = max(shake_time, duration)
	shake_frequency = frequency
	shake_rotation = rotation_strength


func update_camera_shake(delta: float):
	if camera == null:
		return

	if shake_time <= 0.0:
		shake_offset = Vector2.ZERO
		camera.offset = Vector2.ZERO
		camera.rotation = 0.0
		return

	shake_time -= delta

	# Smooth falloff
	var progress :float = clamp(shake_time / shake_duration, 0.0, 1.0)
	var falloff := progress * progress

	# Random movement
	var offset := Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	)

	shake_offset = offset * shake_strength * falloff

	camera.offset = shake_offset

	# Very small rotation for juice
	camera.rotation = randf_range(-shake_rotation, shake_rotation) \
		* 0.01 * falloff
