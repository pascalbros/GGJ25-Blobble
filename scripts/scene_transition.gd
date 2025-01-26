class_name SceneAnimation extends Control

signal finished

@onready var bubbles_wall: Sprite2D = $BubblesWall
@onready var label: Label = $BubblesWall/Label

@export var in_animation: bool = false
@export var level_name: String = ""

func _ready() -> void:
	if in_animation:
		prepare_for_in()
	else:
		prepare_for_out()

func prepare_for_in():
	label.add_theme_color_override("font_color", GameManager.theme_color)
	label.text = level_name
	var tween = bubbles_wall.create_tween()
	var property = tween.tween_property(bubbles_wall, "global_position:y", -680, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	if level_name != "":
		property.set_delay(2)
	await tween.finished
	finished.emit()

func prepare_for_out():
	label.add_theme_color_override("font_color", GameManager.theme_color)
	label.text = level_name
	var tween = bubbles_wall.create_tween()
	tween.tween_property(bubbles_wall, "global_position:y", -680, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	finished.emit()
