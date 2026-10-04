extends Node2D

const ENEMY = preload("uid://fkjfolamwkxk")

var enemies: Array[Enemy] = []

var progress_limit = 350
@onready var timer: Timer = $Timer

func _ready() -> void:
	spawn()

func attack():
	var e: Enemy = enemies.pick_random()
	
	if e:
		while e and !e.timer.is_stopped():
			e = enemies.pick_random()
		e.timer.start()
	
func _on_timer_timeout() -> void:
	attack()
	pass # Replace with function body.

func spawn():
	for i in range(5):
		var enemy :Enemy = ENEMY.instantiate()
		add_child(enemy)
		enemies.append(enemy)
		enemy.global_position.y += i * 40

func _retreat():
	for enemy in enemies:
		enemy.retreat()
	pass

func _physics_process(delta: float) -> void:
	if Global.progress > progress_limit:
		next_phase()
		progress_limit += 350

func next_phase():
	_retreat()
	await get_tree().create_timer(1).timeout
	enemies = []
	if 620 + Global.progress > 350*8:
		return
	global_position.x = 620 + Global.progress
	spawn()
