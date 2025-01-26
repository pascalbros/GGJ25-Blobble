extends Control

func _on_crt_button_pressed() -> void:
	$CrtButton.release_focus()
	Crt.is_visible = not Crt.is_visible

func _on_colors_pressed() -> void:
	$Colors.release_focus()
	var next_color = GameManager.next_color()
	var background: ColorRect = GameManager.current.find_child("ColorRect", false)
	if background != null:
		background.create_tween().tween_property(background, "color", next_color, 0.2)
	GameManager.theme_color = next_color
