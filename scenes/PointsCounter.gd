extends Node

class_name PointsCounter

signal on_points_increased(points: int)
signal on_points_change(amount: int)

signal on_chain_increase(chain: Array[int])
signal on_chain_reset()

signal on_multiplier_increase(multiplier: int)
signal on_multiplier_reset()

signal on_life_gain()

var points = 0

@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var chain_timer = $"Timer"

@export var overflow_points = 10000
@export var ufo_points = 5000
@export var absorb_points = 500

var chain: Array[int] = []
var multiplier: int = 1

func _ready():
	invader_spawner.invader_destroyed.connect(increase_points)

func increase_points(amt: int):
	if chain_timer.is_stopped():
		if chain.find(amt) == -1 or chain.all(func (x): return x == amt):
			chain.append(amt)
			on_chain_increase.emit(chain)
		else:
			chain = []
			on_chain_reset.emit()
			
		if chain.size() == 3:
			chain_timer.start()
		
	points += amt * multiplier
	on_points_change.emit(amt * multiplier)
	on_points_increased.emit(points)


func _on_timer_timeout():
	chain = []
	multiplier += 1
	
	if multiplier % 10 == 0:
		if life_manager.lives == 3:
			points += overflow_points
			on_points_change.emit(overflow_points)
		else:
			on_life_gain.emit()
	
	on_chain_reset.emit()
	on_multiplier_increase.emit(multiplier)


func _on_life_manager_life_lost(_lifes_left):
	chain = []
	multiplier = 1
	
	on_chain_reset.emit()
	on_multiplier_reset.emit()


func _on_ufo_spawner_on_ufo_destroyed():
	points += ufo_points
	multiplier += 1
	
	if multiplier % 10 == 0 and life_manager.lives < 3:
			on_life_gain.emit()
	
	on_points_change.emit(ufo_points)
	on_points_increased.emit(points)
	on_multiplier_increase.emit(multiplier)

func _on_player_absorbed_shot():
	points += absorb_points
	on_points_change.emit(absorb_points)
	on_points_increased.emit(points)
