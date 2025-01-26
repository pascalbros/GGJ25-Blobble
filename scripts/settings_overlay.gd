extends Control

func _on_crt_button_pressed() -> void:
	$CrtButton.release_focus()
	Crt.is_visible = not Crt.is_visible

func _on_colors_pressed() -> void:
	$Colors.release_focus()
	var available_colors = [
		Color("181818"),
		Color("c28229"),
		Color("c21140"),
		Color("718f4d"),
		Color("3986d4")
	]
	var next_color = 0
	for i in len(available_colors):
		if GameManager.theme_color == available_colors[i]:
			next_color = (i+1) % len(available_colors)
	var background: ColorRect = GameManager.current.find_child("ColorRect", false)
	if background != null:
		background.create_tween().tween_property(background, "color", available_colors[next_color], 0.2)
	GameManager.theme_color = available_colors[next_color]
