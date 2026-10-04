extends Node2D

@onready var texture_rect: TextureRect = $CanvasLayer/Control2/TextureRect
@onready var label: Label = $CanvasLayer/Label

var screen := 0
const MAIN = preload("uid://beepwvmu7u7b3")

var images = [
	preload("uid://dw80b6rs7jive"),
	preload("uid://rbgb0eluvvou"),
	preload("uid://btlluh4kecob8"),
]

var texts = [
	"Your Leading a peaceful protest. \nfinish before the time ends",
	"Block incoming bullets. using Rightclick \nblockes push you back a little",
	"Rightclick right before the bullet is shot to parry it"
]


func _ready() -> void:
	update_screen()


func _on_next_pressed() -> void:
	screen += 1

	if screen >= images.size():
		get_tree().change_scene_to_packed(MAIN)
		return

	update_screen()


func update_screen() -> void:
	texture_rect.texture = images[screen]
	label.text = texts[screen]
