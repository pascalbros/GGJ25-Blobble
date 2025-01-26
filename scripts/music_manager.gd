extends Node

var song_1 = load("res://assets/sounds/two_left_socks.ogg")

@onready var player: AudioStreamPlayer = $Player

func play_song_1():
	player.stream = song_1
	player.play()
