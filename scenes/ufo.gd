extends Area2D

class_name Ufo

signal on_ufo_destroyed

@export var speed = 100
@onready var sprite_2d = $Sprite2D
@onready var ufo_shooting = $UfoShooting

var explosion_texture = preload("res://assets/Ufo/Ufo-explosion.png")

func _process(delta):
	position.x -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Laser:
		ufo_shooting.queue_free()
		speed = 0
		sprite_2d.texture = explosion_texture
		await get_tree().create_timer(1).timeout
		on_ufo_destroyed.emit()
		queue_free()
