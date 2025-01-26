extends Node2D

var is_visible: bool:
	set(value):
		$CanvasLayer.visible = value
		$WorldEnvironment.environment.glow_enabled = value
	get(): return $CanvasLayer.visible
