extends Node2D

class_name InvaderSpawner 

signal invader_destroyed(points: int)
signal game_won
signal game_lost

const ROWS = 5
const COLS = 11
const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POS = -50
const INVADERS_POS_X_INC = 10
const INVADERS_POS_Y_INC = 20

var move_direction = Vector2(1, 0)
var invader_scene = preload("res://scenes/invader.tscn")
var invader_shot_scene = preload("res://scenes/invader_shot.tscn")

@onready var move_timer = $MoveTimer
@onready var shot_timer = $ShotTimer

var invader_destroyed_count = 0
var invader_total_count = ROWS * COLS

func _ready():
	var invader_config
	var invader_1_res = preload("res://resources/invader_1.tres")
	var invader_2_res = preload("res://resources/invader_2.tres")
	var invader_3_res = preload("res://resources/invader_3.tres")
	
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 || row == 2:
			invader_config = invader_2_res
		elif row == 3 || row == 4:
			invader_config = invader_3_res

		var row_width = (COLS * invader_config.width * 3) + (COLS - 1) * HORIZONTAL_SPACING
		var start_x = (position.x - row_width) / 2

		for col in COLS:
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POS + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_pos = Vector2(x, y)
			spawn_invader(invader_config, spawn_pos)

func spawn_invader(invader_config, spawn_pos):
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_pos
	invader.invader_destroyed.connect(_on_invader_destroyed)
	add_child(invader)

func _on_move_timer_timeout():
	var start_bound
	var end_bound
	var screen = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	
	start_bound = (camera.position.x - screen.size.x) / 4
	end_bound = (camera.position.x + screen.size.x) / 4

	if ((position.x <= start_bound / 2 or position.x >= end_bound / 2) and move_direction.y == 0):
		position.y += INVADERS_POS_Y_INC 
		move_direction.x *= -1
		move_direction.y = -1
	else:
		position.x += INVADERS_POS_X_INC * move_direction.x
		move_direction.y = 0

func _on_shot_timer_timeout():
	var random_child_pos = get_children().filter(func (c): return c as Invader).map(func (invader): return invader.global_position).pick_random()
	var invader_shot = invader_shot_scene.instantiate() as InvaderShot
	get_tree().root.add_child(invader_shot)
	invader_shot.global_position = random_child_pos

func _on_invader_destroyed(points: int):
	invader_destroyed.emit(points)
	invader_destroyed_count += 1
	if invader_destroyed_count == invader_total_count:
		game_won.emit()
		shot_timer.stop()
		move_timer.stop()


func _on_bottom_wall_area_entered(area):
	game_lost.emit()
	move_timer.stop()
	move_direction = 0
