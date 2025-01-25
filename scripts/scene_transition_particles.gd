extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await finished
	await get_tree().create_timer(3.5).timeout
	amount = 200



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
