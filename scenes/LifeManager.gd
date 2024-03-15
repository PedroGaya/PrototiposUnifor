extends Node

class_name LifeManager

signal life_lost(lifes_left: int)
signal life_gained

@export var lives = 3
@onready var player: Player = $"../Player"
var player_scene = preload("res://scenes/player.tscn")

@onready var form_manager: FormManager = $"../FormManager"
@onready var points_manager: PointsCounter = $"../PointsCounter"

func _ready():
	(player as Player).player_destroyed.connect(_player_lives)

func _player_lives():
	lives -= 1
	life_lost.emit(lives)
	if lives != 0:
		@warning_ignore("shadowed_variable")
		var player = player_scene.instantiate() as Player
		player.global_position = Vector2(0, 302)
		
		player.player_destroyed.connect(_player_lives)
		player.cycle.connect(form_manager._on_player_cycle)
		player.reset_form.connect(form_manager._on_player_reset_form)
		player.absorbed_shot.connect(points_manager._on_player_absorbed_shot)
		
		get_tree().root.add_child(player)

func _on_points_counter_on_life_gain():
	lives = max(lives + 1, 3)
	life_gained.emit()
