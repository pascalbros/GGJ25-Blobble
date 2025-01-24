@tool
class_name Portal extends Area2D

enum PortalColor {
	ONE, TWO, THREE, FOUR
}

@export var is_disabled := false:
	set(value):
		if value == is_disabled: return
		is_disabled = value
		monitoring = not is_disabled
		create_tween().tween_property(self, "modulate:a", 0.1 if is_disabled else 1.0, 0.2)
		if linked_portal != null:
			linked_portal.is_disabled = is_disabled

@export var color: PortalColor = PortalColor.ONE:
	set(value):
		if value == color: return
		color = value
		if linked_portal != null:
			linked_portal.color = value

@export var linked_portal: Portal

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var _should_react := true
var _was_disabled = false

func _ready() -> void:
	_was_disabled = is_disabled
	if not Engine.is_editor_hint():
		GameManager.resettable_objects.append(self)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func get_nodes_with_script(target_script: Script, root: Node = EditorInterface.get_edited_scene_root()) -> Array:
	if root == null: return []
	var nodes_with_script = []
	var script = root.get_script()
	if script != null and script == target_script:
		nodes_with_script.append(root)
	for child in root.get_children():
		nodes_with_script += get_nodes_with_script(target_script, child)
	return nodes_with_script

func enum_to_color(portal_color: PortalColor) -> Color:
	match portal_color:
		PortalColor.ONE: return Color("16C47F")
		PortalColor.TWO: return Color("FFD65A")
		PortalColor.THREE: return Color("FF9D23")
		PortalColor.FOUR: return Color("1C6DD0")
		_: return Color.WHITE


func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint(): return
	if not _should_react: return
	if body is not Player: return
	#linked_portal._should_react = false
	body.global_position = linked_portal.global_position
	body.on_portal_exit(linked_portal)


func _on_body_exited(body: Node2D) -> void:
	if Engine.is_editor_hint(): return
	if body is not Player: return
	_should_react = true

func enable():
	is_disabled = false

func disable():
	is_disabled = true

func switch():
	is_disabled = not is_disabled

func reset():
	is_disabled = _was_disabled

func _draw():
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, 10, enum_to_color(color), false, 1)
