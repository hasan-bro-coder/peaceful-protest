extends Node2D

@onready var protest: Node2D = $Protest
@export var player: Player
@export var progress_bar: TextureProgressBar
@onready var crowd: CharacterBody2D = $Protest/CharacterBody2D

var crowd_health := 100
var total_time := 160.0
@export var time_label: Label
@export var health_label: Label

@onready var hit: AudioStreamPlayer = $hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("wave")
	Global.camera = $Protest/Camera2D
	pass # Replace with function body.

func push_back():
	protest.global_position.x -= 20 * 0.5
	Global.progress -= 20 * 0.5
	progress_bar.value = (Global.progress/(350*8)) * 100

func damage(amout : int):
	crowd_health -= amout
	var tween := create_tween()
	tween.tween_property(crowd, "modulate", Color.RED, 0.05)
	tween.tween_property(crowd, "modulate", Color.WHITE, 0.1)
	hit.play()
	Global.camera_shake()
	
	if crowd_health <= 0:
		death()
	

func _physics_process(delta: float) -> void:
	Global.update_camera_shake(delta)
	total_time -= delta
	if total_time <= 0:
		death()
	time_label.text = str(int(total_time/60)) + ":" + str(int(total_time)%60)
	health_label. text = str(crowd_health)
	if(not player.shield):
		protest.global_position.x += 20 * delta
		Global.progress += 20 * delta
		progress_bar.value = (Global.progress/(350*8)) * 100
	if Global.progress >= 350*8:
		$Win.play()
		$CanvasLayer4.show()
		get_tree().paused = true

func _on_check_button_pressed() -> void:
	$AudioStreamPlayer.playing = not $AudioStreamPlayer.playing
	#$CanvasLayer2/CheckButton.toggle_mode
	#print($CanvasLayer2/CheckButton.toggle_mode)
	pass # Replace with function body.

func death():
	$CanvasLayer3.show()
	get_tree().paused = true
	
	


func _on_pause_pressed() -> void:
	$CanvasLayer2.show()
	get_tree().paused = true
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	get_tree().paused = false
	$CanvasLayer2.hide()
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_check_button_2_pressed() -> void:
	$CanvasLayer5/ColorRect.visible = !$CanvasLayer5/ColorRect.visible
	
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.
