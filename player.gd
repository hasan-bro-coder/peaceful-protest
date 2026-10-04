extends CharacterBody2D
class_name Player


var shield := false
@export var sprite: Sprite2D
const PLAYER_SHEILD = preload("uid://dngjwvouqeux")
const PLAYER = preload("uid://b6kos3utkiu78")
var is_parry_window := 0.0

@onready var parry: AudioStreamPlayer = $parry
@onready var shieldhit: AudioStreamPlayer = $shieldhit
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("idle")
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if (e.pressed):
			shield = true
			sprite.texture = PLAYER_SHEILD
			is_parry_window = 0.5
			animated_sprite_2d.play("sheildup")
			
		else:
			shield = false
			sprite.texture = PLAYER
			animated_sprite_2d.play("sheilddown")

func _physics_process(delta: float) -> void:
	if(is_parry_window > 0):
		is_parry_window -= delta
	var mouse = get_global_mouse_position().y
	if(abs(global_position.y - mouse) > 5):
		velocity.y = 600 * ( -1 if global_position.y > mouse else 1)
		animated_sprite_2d.play("walk")
	else:
		velocity.y = 0
		#animated_sprite_2d.play("idle")
	move_and_slide()
	
func countered():
	shieldhit.play()
	#Global.camera_shake()

func parried():
	parry.play()
	sprite.material.set_shader_parameter("flash_amount", 1.0)

	var tween := create_tween()
	tween.tween_method(
		func(value): sprite.material.set_shader_parameter("flash_amount", value),
		1.0,
		0.0,
		0.2
	)
	#get_tree().paused = true
	#await get_tree().create_timer(0.4).timeout
	#get_tree().paused = false
	Global.camera_shake()
