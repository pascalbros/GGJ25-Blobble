class_name PlayerMenu extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0

@onready var sprite: AnimatedSprite2D = $Sprite

var _is_ready = false

func _get_ready():
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
		velocity += get_gravity() * delta
		if velocity.y < 0:
			sprite.animation = "jump_up"
		else:
			sprite.animation = "jump_down"
	else:
		sprite.animation = "idle"
	move_and_slide()
