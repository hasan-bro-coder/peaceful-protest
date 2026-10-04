extends Node2D

@onready var protest: Node2D = $Protest
@export var player: Player
@export var progress_bar: TextureProgressBar
@onready var crowd: CharacterBody2D = $Protest/CharacterBody2D

var crowd_health := 100.0
var total_time := 120.0
var progress := 0.0
@export var time_label: Label
@export var health_label: Label

@onready var hit: AudioStreamPlayer = $hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("wave")
	pass # Replace with function body.

func damage(amout : int):
	crowd_health -= amout
	var tween := create_tween()
	tween.tween_property(crowd, "modulate", Color.RED, 0.05)
	tween.tween_property(crowd, "modulate", Color.WHITE, 0.1)
	hit.play()
	if crowd_health <= 0:
		death()

func _physics_process(delta: float) -> void:
	total_time -= delta
	time_label.text = str(int(total_time/60)) + ":" + str(int(total_time)%60)
	health_label. text = str(crowd_health)
	if(not player.shield):
		protest.global_position.x += 14 * delta
		progress += 14 * delta
		progress_bar.value = (progress/140) * 100


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
	$CanvasLayer3.hide()
	pass # Replace with function body.
