class_name Player extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0

var _should_slide = false

@export var should_animate_in = true
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

var _has_touched_floor = false
var _has_jumped = false
var _last_obj_touched = 0
var _is_ready = false

func _ready() -> void:
	GameManager.player_initial_position = global_position
	if should_animate_in:
		sprite.play("born")
		await sprite.animation_finished
	_is_ready = true

func _physics_process(delta: float) -> void:
	if not _is_ready:
		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()
		return
	if not is_on_floor():
		if _has_touched_floor:
			_has_jumped = true
		if _should_slide and is_on_wall_only():
			velocity.y = get_gravity().y * delta
		else:
			velocity += get_gravity() * delta
			if velocity.y < 0:
				sprite.animation = "jump_up"
			else:
				sprite.animation = "jump_down"
	else:
		sprite.animation = "idle"
		_has_touched_floor = true
		if _has_jumped and _is_on_forbidden_ground():
			GameManager.current.die(self)

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or _should_slide):
		_should_slide = false
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	move_and_slide()

func is_last_obj_touched(obj: Object) -> bool:
	return obj.get_instance_id() == _last_obj_touched

func _is_on_forbidden_ground() -> bool:
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var body = collision.get_collider()
		if body is TileMapLayer:
			return true
	return false

func die():
	audio_player.play()
	set_physics_process(false)
	sprite.play("die")
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 0.1, 0.5)
	await sprite.animation_finished
	queue_free()

func on_bubble_collision(_bubble: Node2D):
	if is_last_obj_touched(_bubble):
		GameManager.current.die(self)
		return true
	velocity.y = JUMP_VELOCITY
	_last_obj_touched = _bubble.get_instance_id()
	return false

func on_button_collision(_button: PushButton):
	_last_obj_touched = _button.get_instance_id()
	velocity.y = JUMP_VELOCITY

func on_portal_exit(_portal: Portal):
	_last_obj_touched = _portal.get_instance_id()
	velocity.y = JUMP_VELOCITY

func on_slime_wall_entered(_slime_wall: SlimeWall):
	_last_obj_touched = _slime_wall.get_instance_id()
	_should_slide = true

func on_slime_wall_exited(_slime_wall: SlimeWall):
	_should_slide = false
