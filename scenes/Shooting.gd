extends Node2D

@export var laser_scene: PackedScene
var can_player_shoot = true

func _input(_event):
	if Input.is_action_just_pressed("shoot") and can_player_shoot:
		var laser = laser_scene.instantiate() as Laser
		add_child(laser)
		laser.global_position = get_parent().global_position - Vector2(0, 20)
		can_player_shoot = false
		laser.tree_exited.connect(_tree_exited)

func _tree_exited():
	can_player_shoot = true
