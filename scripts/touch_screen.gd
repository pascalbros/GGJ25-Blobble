extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func _on_left_pressed() -> void:
	Input.action_press("left")

func _on_left_released() -> void:
	Input.action_press("left")

func _on_right_pressed() -> void:
	Input.action_press("right")

func _on_right_released() -> void:
	Input.action_press("right")

func _on_jump_pressed() -> void:
	Input.action_press("jump")

func _on_jump_released() -> void:
	Input.action_release("jump")
