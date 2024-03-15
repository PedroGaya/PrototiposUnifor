extends Node

class_name LifeManager

signal life_lost(lifes_left: int)

@export var lives = 3
@onready var player: Player = $"../Player"
var player_scene = preload("res://scenes/player.tscn")

func _ready():
	(player as Player).player_destroyed.connect(_player_lives)

func _player_lives():
	lives -= 1
	life_lost.emit(lives)
	if lives != 0:
		var player = player_scene.instantiate() as Player
		player.global_position = Vector2(0, 302)
		player.player_destroyed.connect(_player_lives)
		get_tree().root.add_child(player)
