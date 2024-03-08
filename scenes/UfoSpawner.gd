extends Node2D

@onready var spawn_timer = $SpawnTimer
var spawned_ufo: Ufo
var ufo_scene: PackedScene = preload("res://scenes/ufo.tscn")

func _ready():
	(spawn_timer as SpawnTimer).setup_timer()

func _on_spawn_timer_timeout():
	if !spawned_ufo:
		var ufo = ufo_scene.instantiate()
		spawned_ufo = ufo
		get_tree().root.add_child(ufo)
		ufo.global_position = position

