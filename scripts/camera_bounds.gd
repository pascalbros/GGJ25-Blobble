extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_camera_bounds()

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	GameManager.current.on_player_out_of_bounds(body)

func _create_camera_bounds():
	var bottom = _create_camera_bound(Vector2(0, -1))
	var left = _create_camera_bound(Vector2(1, 0))
	var right = _create_camera_bound(Vector2(-1, 0))
	var camera = get_viewport().get_camera_2d()
	var half_size = get_viewport_rect().size / camera.zoom * 0.6
	bottom.global_position = camera.global_position + Vector2(0, half_size.y)
	left.global_position = camera.global_position - Vector2(half_size.x, 0)
	right.global_position = camera.global_position + Vector2(half_size.x, 0)

func _create_camera_bound(normal: Vector2) -> CollisionShape2D:
	var shape = CollisionShape2D.new()
	var boundary = WorldBoundaryShape2D.new()
	boundary.normal = normal
	shape.shape = boundary
	add_child(shape)
	return shape
