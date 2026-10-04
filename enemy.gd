extends Node2D
class_name Enemy
@export var ray: RayCast2D
@export var bar: TextureProgressBar
@export var timer: Timer
const BULLET = preload("uid://50e7evae65rp")
@export var muzzle: Marker2D
@onready var line: Line2D = $Line2D
@onready var shoot_audio: AudioStreamPlayer = $ShootAudio

var dead := false

func retreat():
	#top_level = true
	dead = true
	var tween = create_tween()
	tween.tween_property(self, "position:y", 640, 2)
	tween.tween_callback(queue_free)
	await tween.finished
	queue_free()



func _ready() -> void:
	#timer.wait_time = randi_range(4,15)
	#timer.start()
	pass
	
func _shoot() -> void:
	if dead:
		return
	var bullet: Node2D = BULLET.instantiate()
	bullet.global_position = muzzle.global_position
	add_child(bullet)
	shoot_audio.play()
	#var collision: Node2D = ray.get_collider()
	#if(collision is Player):
		#if collision.is_parry_window:
			##parry()
			#pass
		#elif not collision.shield:
			#Global.damage(10)
	#elif collision and collision.is_in_group("crowd"):
			#Global.damage(20)
	
func _physics_process(delta: float) -> void:
	if dead:
		bar.hide()
		line.hide()
		return
	if !timer.is_stopped():
		bar.value = (1 - timer.time_left) * 100
		line.show()
		line.remove_point(0)
		line.remove_point(0)
		line.add_point(muzzle.global_position)
		line.add_point(Vector2(ray.get_collision_point().x,muzzle.global_position.y))
	else:
		bar.value = 0
		line.hide()
	#(timer.time_left/timer.wait_time) * 100
	
	
func _on_timer_timeout() -> void:
	_shoot()
	pass

#func shoot() -> void:
	#telegraphing = false
	#telegraph.visible = false
#
	#if not target:
		#start_waiting()
		#return
#
	#var bullet = bullet_scene.instantiate()
	#get_tree().current_scene.add_child(bullet)
#
	#bullet.global_position = shoot_point.global_position
	#bullet.direction = (
		#target.global_position - shoot_point.global_position
	#).normalized()
#
	#start_waiting()
