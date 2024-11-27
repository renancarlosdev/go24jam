extends Node2D

@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	player.killed.connect(_on_player_killed)


func _on_player_killed():
	print("dead")
	pass
