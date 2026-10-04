extends Node2D

const ENEMY = preload("uid://fkjfolamwkxk")

var enemies: Array[Enemy] = []

func _ready() -> void:
	for i in range(6):
		var enemy :Enemy = ENEMY.instantiate()
		add_child(enemy)
		enemies.append(enemy)
		enemy.global_position.y += i * 30

func _retreat():
	for enemy in enemies:
		enemy.retreat()
	pass
