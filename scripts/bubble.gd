@tool
class_name Bubble extends Area2D

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

func _ready() -> void:
	_was_disabled = is_disabled
	_initial_life = life
	life = _initial_life
	if not Engine.is_editor_hint():

		GameManager.resettable_objects.append(self)
		GameManager.current_bubbles += 1

func _on_body_entered(body: Node2D) -> void:
	if is_disabled || Engine. is_editor_hint(): return
	if body is not Player: return
	decrease_life(body as Player)

func decrease_life(player: Player):
	life -= 1
	player.on_bubble_collision(self)
	if life == 0:
		modulate.a = 0
		$Collider.set_deferred("disabled", true)
		GameManager.current.on_bubble_popped()

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
