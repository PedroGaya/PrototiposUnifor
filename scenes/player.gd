extends Area2D

@export var speed = 200
var direction = Vector2.ZERO

@onready var collision_rect = $CollisionShape2D

var bounding_box_width
var start_bound
var end_bound

func _ready():
	bounding_box_width = collision_rect.shape.get_rect().size.x
	var screen = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	
	start_bound = (camera.position.x - screen.size.x) / 2
	end_bound = (camera.position.x + screen.size.x) / 2

func _process(delta):
	var input = Input.get_axis("left", "right")
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var delta_movement = input * speed * delta

	if (
		position.x + delta_movement < start_bound + bounding_box_width * transform.get_scale().x or
		position.x + delta_movement > end_bound - bounding_box_width * transform.get_scale().x
	):
		return
		
	position.x += delta_movement

