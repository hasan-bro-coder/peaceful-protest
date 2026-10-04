extends CharacterBody2D
class_name Player


var shield := false
@export var sprite: Sprite2D
const PLAYER_SHEILD = preload("uid://dngjwvouqeux")
const PLAYER = preload("uid://b6kos3utkiu78")
var is_parry_window := 0.0

@onready var parry: AudioStreamPlayer = $parry
@onready var shieldhit: AudioStreamPlayer = $shieldhit


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if (e.pressed):
			shield = true
			sprite.texture = PLAYER_SHEILD
			is_parry_window = 0.5
		else:
			shield = false
			sprite.texture = PLAYER

func _physics_process(delta: float) -> void:
	if(is_parry_window > 0):
		is_parry_window -= delta
	var mouse = get_global_mouse_position().y
	if(abs(global_position.y - mouse) > 5):
		velocity.y = 600 * ( -1 if global_position.y > mouse else 1)
	else:
		velocity.y = 0
	move_and_slide()
	
func countered():
	shieldhit.play()
func parried():
	parry.play()
