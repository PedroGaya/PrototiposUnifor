extends Node2D

signal on_ufo_destroyed

@onready var spawn_timer = $SpawnTimer
var spawned_ufo: Ufo
var ufo_scene: PackedScene = preload("res://scenes/ufo.tscn")
var hard_mode = false

func _ready():
	(spawn_timer as SpawnTimer).setup_timer()

func _on_spawn_timer_timeout():
	if not spawned_ufo or hard_mode:
		var ufo = ufo_scene.instantiate()
		spawned_ufo = ufo
		get_tree().root.add_child(ufo)
		ufo.global_position = position
		ufo.on_ufo_destroyed.connect(_on_ufo_destroyed)
		print("Spawned ufo.")

func _on_ufo_destroyed():
	on_ufo_destroyed.emit()

func start_hard_mode():
	hard_mode = true
	spawn_timer.wait_time = 1.5
