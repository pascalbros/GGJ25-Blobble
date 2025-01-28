extends Node2D

var crt_effect = load("res://prefabs/crt_effect.tscn")

static var is_mobile_set = false
static var is_mobile = false

var is_visible: bool:
	set(value):
		$CanvasLayer.visible = value
		$WorldEnvironment.environment.glow_enabled = value
	get(): return $CanvasLayer.visible

func _ready() -> void:
	set_mobile()
	if not is_mobile:
		$CanvasLayer.add_child(crt_effect.instantiate())
	else:
		is_visible = false

func set_mobile():
	if is_mobile_set: return
	if OS.get_name() == "Web":
		is_mobile = JavaScriptBridge.eval("/windows phone/i.test(navigator.userAgent || navigator.vendor || window.opera) || /android/i.test(navigator.userAgent || navigator.vendor || window.opera) || (/iPad|iPhone|iPod/.test(navigator.userAgent || navigator.vendor || window.opera) && !window.MSStream)", true)
	is_mobile_set = true
