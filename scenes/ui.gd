extends CanvasLayer

@onready var points_label = $MarginContainer/HBoxContainer/Points
@onready var points_change = $MarginContainer/HBoxContainer/PointChange
@onready var lives_container = $MarginContainer/Lives
@onready var game_over_container = $MarginContainer/GameOver
@onready var game_over_label = %GameOverLabel
@onready var game_over_button = %GameOverButton
@onready var chain_label = %Chain
@onready var multiplier_label = %Multiplier

@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var points_counter = $"../PointsCounter" as PointsCounter

var life_texture = preload('res://assets/Player/Player.png')

func _ready():
	points_label.text = 'SCORE = %d' % 0
	chain_label.text = 'CHAIN = %d' % 0
	
	points_counter.on_points_increased.connect(_on_points_increased)
	points_counter.on_points_change.connect(_on_points_change)
	points_counter.on_chain_increase.connect(_on_chain_increase)
	points_counter.on_chain_reset.connect(_on_chain_reset)
	points_counter.on_multiplier_increase.connect(_on_multiplier_increase)
	points_counter.on_multiplier_reset.connect(_on_multiplier_reset)
	
	life_manager.life_lost.connect(_on_life_lost)
	life_manager.life_gained.connect(_on_life_gained)
	
	invader_spawner.game_lost.connect(_on_game_lost)
	invader_spawner.game_won.connect(_on_game_won)

	for i in range(life_manager.lives):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.custom_minimum_size = Vector2(40, 25)
		life_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		life_texture_rect.texture = life_texture
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		lives_container.add_child(life_texture_rect)

func _on_points_increased(points: int):
		points_label.text = 'SCORE = %d' % points

func _on_life_lost(lives: int):
	if lives != 0:
		var life_texture_rect = lives_container.get_child(lives)
		life_texture_rect.queue_free()
	else:
		_on_game_lost()

func _on_life_gained():
	var life_texture_rect = TextureRect.new()
	life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	life_texture_rect.custom_minimum_size = Vector2(40, 25)
	life_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	life_texture_rect.texture = life_texture
	life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	lives_container.add_child(life_texture_rect)

func _on_game_lost():
	game_over_container.visible = true

func _on_game_won():
	game_over_container.visible = true
	game_over_label.text = "VICTORY"
	game_over_label.add_theme_color_override("font_color", Color.YELLOW)

func _on_button_pressed():
	get_tree().reload_current_scene()

func _on_chain_increase(chain):
	chain_label.text = 'CHAIN = %d' % chain.size()
func _on_chain_reset():
	chain_label.text = 'CHAIN = %d' % 0
func _on_multiplier_increase(multiplier):
	multiplier_label.text = 'MULTI = X%d' % multiplier
func _on_multiplier_reset():
	multiplier_label.text = 'MULTI = X%d' % 1
func _on_points_change(amount):
	points_change.text = "(+%d)" % amount
