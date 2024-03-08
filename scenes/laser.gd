extends Area2D

class_name Laser

@export var speed = 300
var x_spawn = 0

func _ready():
	x_spawn = global_position.x	

func _process(delta):
	global_position.x = x_spawn
	position.y -= speed * delta
