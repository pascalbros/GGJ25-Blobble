@tool
class_name Portal extends Area2D

enum PortalColor {
	ONE, TWO, THREE, FOUR
}

@export var id: String = "":
	set(value):
		if value == id: return
		id = value
		if Engine.is_editor_hint():
			link_portal()

@export var color: PortalColor = PortalColor.ONE:
	set(value):
		if value == color: return
		color = value
		#if sprite != null:
			#sprite.self_modulate = enum_to_color(value)
		#if linked_portal != null:
			#linked_portal.color = value

@export var linked_portal: Portal

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var _is_enabled := true

#func _ready() -> void:
	#if Engine.is_editor_hint():
		#sprite.self_modulate = enum_to_color(color)

func link_portal():
	var portals = get_nodes_with_script(Portal)
	for portal: Portal in portals:
		if portal.id == id && portal.get_path() != get_path():
			linked_portal = portal
			portal.linked_portal = self
			return

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
	if not _is_enabled: return
	if body is not Player: return
	#linked_portal._is_enabled = false
	body.global_position = linked_portal.global_position
	body.on_portal_exit(linked_portal)


func _on_body_exited(body: Node2D) -> void:
	if Engine.is_editor_hint(): return
	if body is not Player: return
	_is_enabled = true
