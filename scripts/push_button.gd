class_name PushButton extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite

signal pressed
signal released

@export var trigger_once: bool = false

var can_be_triggered := true

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	var player = body as Player
	sprite.play("on")
	if not player.is_last_obj_touched(self):
		pressed.emit()
	player.on_button_collision(self)

func _on_body_exited(_body: Node2D) -> void:
	sprite.play("off")
	released.emit()
