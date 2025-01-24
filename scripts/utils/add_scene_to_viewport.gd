extends Node

@export var scene: Node2D

func _ready() -> void:
	scene.call_deferred("reparent", self)
