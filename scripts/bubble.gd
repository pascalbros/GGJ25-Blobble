@tool
class_name Bubble extends Area2D

const pop_sound = preload("res://assets/sounds/fx/pop_1.wav")
const boing_sound = preload("res://assets/sounds/fx/boing_2.wav")

@export var is_disabled := false:
	set(value):
		if not is_active(): return
		is_disabled = value
		create_tween().tween_property(self, "modulate:a", 0.1 if is_disabled else 1.0, 0.2)

@export var life: int = 1:
	set(value):
		life = value
		if label != null:
			label.text = "" if life <= 1 else str(life)


var _was_disabled = false
var _initial_life = 0

@onready var label: Label = $Label
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

var time = 0.0
var amplitude = 0.05
var speed = 2.0
var _is_popping = false

func _ready() -> void:
	_was_disabled = is_disabled
	_initial_life = life
	life = _initial_life
	if not Engine.is_editor_hint():
		GameManager.resettable_objects.append(self)
		GameManager.current_bubbles += 1

func _process(delta: float):
	if Engine.is_editor_hint(): return
	if not _is_popping:
		time += delta * speed
		position.y = position.y + amplitude * sin(time)

func _on_body_entered(body: Node2D) -> void:
	if is_disabled || Engine. is_editor_hint(): return
	if body is not Player: return
	decrease_life(body as Player)

func decrease_life(player: Player):
	life -= 1
	var is_player_dead = player.on_bubble_collision(self)
	if is_player_dead: return
	if life == 0:
		audio_player.pitch_scale = randf_range(0.5, 1.5)
		audio_player.stream = pop_sound
		audio_player.play()
		$Collider.set_deferred("disabled", true)
		GameManager.current.on_bubble_popped()
		sprite.play("pop")
		await sprite.animation_finished
		modulate.a = 0
		sprite.play("idle")
	else:
		audio_player.stream = boing_sound
		audio_player.pitch_scale = 1
		audio_player.play()
		sprite.play("squeeze")
		await sprite.animation_finished
		sprite.play("idle")

func redraw():
	create_tween().tween_property(self, "modulate:a", 0.1 if is_disabled else 1.0, 0.2)

func enable():
	is_disabled = false

func disable():
	is_disabled = true

func switch():
	is_disabled = not is_disabled

func is_active() -> bool:
	return not $Collider.disabled

func reset():
	if not is_active():
		GameManager.current_bubbles += 1
	$Collider.disabled = false
	is_disabled = _was_disabled
	life = _initial_life
	redraw()
