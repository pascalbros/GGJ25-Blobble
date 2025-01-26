extends Node2D

func _ready() -> void:
	GameManager.current_bubbles = 0
	$StartGameButton.grab_focus()
	$ColorRect.color = GameManager.theme_color
	await get_tree().create_timer(0.5).timeout
	$Player._get_ready()
	$Player.visible = true

func _on_start_game_button_pressed() -> void:
	$AnimationPlayer.play("StartGame")
	await $AnimationPlayer.animation_finished
	$TileMapLayer.enabled = false
	await get_tree().create_timer(1.0).timeout
	var level_path = GameManager.path_for(1)
	if ResourceLoader.exists(level_path):
		get_tree().change_scene_to_file(level_path)


func _on_theme_button_pressed() -> void:
	var next_color = GameManager.next_color()
	GameManager.theme_color = next_color
	$ColorRect.create_tween().tween_property($ColorRect, "color", next_color, 0.2)
