class_name SlimeWall extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	body.on_slime_wall_entered(self)


func _on_body_exited(body: Node2D) -> void:
	if body is not Player: return
	body.on_slime_wall_exited(self)
