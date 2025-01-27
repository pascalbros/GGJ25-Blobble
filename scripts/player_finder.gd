extends Node2D

@onready var dot: Sprite2D = $Dot

var player: Node2D = null

func _ready() -> void:
	dot.self_modulate.a = 0

func _process(_delta: float) -> void:
	if player == null: return
	dot.global_position.x = player.global_position.x


func disable(animated: bool = true):
	if not animated:
		dot.self_modulate.a = 0
		return
	dot.create_tween().tween_property(dot, "self_modulate:a", 0, 0.1)

func enable(animated: bool = true):
	if not animated:
		dot.self_modulate.a = 1
		return
	dot.create_tween().tween_property(dot, "self_modulate:a", 1, 0.1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player: return
	player = body
	enable()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not Player: return
	player = null
	disable()
