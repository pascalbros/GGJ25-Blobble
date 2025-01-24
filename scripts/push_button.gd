class_name PushButton extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite

signal pressed
signal released

@export var trigger_once: bool = false

var can_be_triggered := true

func _on_body_entered(body: Node2D) -> void:
	sprite.play("on")
	pressed.emit()
	if body is Player:
		body.on_button_collision(self)



func _on_body_exited(_body: Node2D) -> void:
	sprite.play("off")
	released.emit()
