class_name GameManager extends Node2D

var out_animation = preload("res://scenes/scene_transition_out.tscn")
var in_animation = preload("res://scenes/scene_transition_in.tscn")

var player_proto = preload("res://prefabs/player.tscn")
var camera_bounds_proto = preload("res://prefabs/camera_bounds.tscn")

static var current: GameManager

static var player_initial_position: Vector2
static var resettable_objects = []
static var current_bubbles = 0

var current_level = 1

var _current_player: Player:
	get: return $Player

func _ready() -> void:
	current = self
	add_child(camera_bounds_proto.instantiate())
	current_level = extract_level(get_tree().current_scene.scene_file_path)
	animate_in()

func animate_in():
	if $SceneTransition == null:
		var animation = in_animation.instantiate()
		add_child(animation)
	var animation: SceneAnimation = $SceneTransition
	animation.visible = true
	await animation.finished
	animation.queue_free()

func animate_out():
	_current_player.queue_free()
	var animation: SceneAnimation = out_animation.instantiate()
	add_child(animation)
	await animation.finished
	go_to_next_level()

func on_player_out_of_bounds(player: Player):
	die(player)

func die(player: Player):
	player.die()
	player.name = "_Player"
	if player._last_obj_touched == 0:
		await get_tree().create_timer(0.2).timeout
	var new_player = player_proto.instantiate()
	new_player.name = "Player"
	new_player.global_position = player_initial_position
	call_deferred("add_child", new_player)
	for resettable in resettable_objects:
		resettable.call_deferred("reset")

func on_bubble_popped():
	current_bubbles -= 1
	if current_bubbles == 0:
		animate_out()

func go_to_next_level():
	var path = path_for(current_level + 1)
	if ResourceLoader.exists(path):
		get_tree().call_deferred("change_scene_to_file", path)


func _exit_tree() -> void:
	if current == self:
		resettable_objects = []
		current = null

func extract_level(path: String) -> int:
	return int(path.split("/")[-1].split(".")[0])

func path_for(level: int) -> String:
	return "res://scenes/levels/LEVEL.tscn".replace("LEVEL", str(level))
