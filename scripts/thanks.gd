extends Node2D

var in_animation = preload("res://scenes/scene_transition_in.tscn")

@export var next_level = "res://scenes/main_menu.tscn"

func _ready() -> void:
	$ColorRect.color = GameManager.theme_color
	var animation = in_animation.instantiate()
	add_child(animation)
	animation.visible = true
	await animation.finished
	animation.queue_free()
	$Overlay.self_modulate.a = 0
	$Overlay.visible = true
	await get_tree().create_timer(3).timeout
	await $Overlay.create_tween().tween_property($Overlay, "self_modulate:a", 1, 0.5).finished
	get_tree().change_scene_to_file(next_level)
