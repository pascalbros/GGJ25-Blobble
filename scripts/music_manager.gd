extends Node

var song_1 = load("res://assets/sounds/two_left_socks.ogg")

func play_song_1():
	$Player.stream = song_1
	$Player.play()
