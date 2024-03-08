extends Node2D

@onready var spawn_timer = $SpawnTimer
var projectile_scene = preload("res://scenes/invader_shot.tscn")

func _ready():
	spawn_timer.setup_timer()

func _on_spawn_timer_timeout():
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D") as Sprite2D
	projectile_sprite.modulate = Color(0.62, 0.2, 0.2, 1)
	projectile.global_position = global_position
	get_tree().root.add_child(projectile)
	spawn_timer.setup_timer()
