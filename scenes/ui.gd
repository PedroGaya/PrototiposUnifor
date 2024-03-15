extends CanvasLayer

@onready var points_label = $MarginContainer/Points
@onready var lives_container = $MarginContainer/Lives
@onready var game_over_container = $MarginContainer/GameOver
@onready var game_over_label = %MarginContainer/GameOver/VBoxContainer/Label
@onready var game_over_button = %MarginContainer/GameOver/VBoxContainer/Button

@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var points_counter = $"../PointsCounter" as PointsCounter

var life_texture = preload('res://assets/Player/Player.png')

func _ready():
	points_label.text = 'SCORE: %d' % 0
	points_counter.on_points_increased.connect(_on_points_increased)
	life_manager.life_lost.connect(_on_life_lost)
	invader_spawner.game_lost.connect(_on_game_lost)
	invader_spawner.game_won.connect(_on_game_won)

	for i in range(life_manager.lives):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.custom_minimum_size = Vector2(40, 25)
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
