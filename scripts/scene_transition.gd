class_name SceneAnimation extends Control

signal finished

@onready var bubbles_wall: Sprite2D = $BubblesWall

@export var in_animation: bool = false

func _ready() -> void:
	if in_animation:
		prepare_for_in()
	else:
		prepare_for_out()

func prepare_for_in():
	var tween = bubbles_wall.create_tween()
	tween.tween_property(bubbles_wall, "global_position:y", -680, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	finished.emit()

func prepare_for_out():
	var tween = bubbles_wall.create_tween()
	tween.tween_property(bubbles_wall, "global_position:y", -680, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await tween.finished
	finished.emit()
