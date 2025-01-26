extends Node2D

@export var next_level = "res://scenes/main_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$Overlay.visible = true
	await $Overlay.create_tween().tween_property($Overlay, "self_modulate:a", 0, 0.5).finished
	await get_tree().create_timer(3).timeout
	await $Overlay.create_tween().tween_property($Overlay, "self_modulate:a", 1, 0.5).finished
	$Label.text = "Yet another\nGlobal Game Jam\ngame (2025)"
	await $Overlay.create_tween().tween_property($Overlay, "self_modulate:a", 0, 0.5).finished
	await get_tree().create_timer(3).timeout
	await $Overlay.create_tween().tween_property($Overlay, "self_modulate:a", 1, 0.5).finished
	MusicManager.play_song_1()
	get_tree().change_scene_to_file(next_level)
