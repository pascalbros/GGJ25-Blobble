extends Node2D

@export var player: Node2D
@export var smoothing_multiplier: float = 1.0

var initial_position: Vector2
var last_player_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player == null: return
	initial_position = global_position
	last_player_position = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null: return
	var delta_pos = (player.global_position - last_player_position) * smoothing_multiplier
	last_player_position = player.global_position
	if delta_pos != Vector2.ZERO:
		global_position = initial_position - delta_pos
	else:
		global_position = initial_position
