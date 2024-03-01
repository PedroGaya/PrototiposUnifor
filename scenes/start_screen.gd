extends CanvasLayer

@onready var texture_rect_1 = %TextureRect1
@onready var points_1 = %Points1
@onready var texture_rect_2 = %TextureRect2
@onready var points_2 = %Points2
@onready var texture_rect_3 = %TextureRect3
@onready var points_3 = %Points3

@onready var button = %Button
@onready var timer = $Timer

var controls = []

func _ready():
	controls = [
		texture_rect_1, 
		points_1, 
		texture_rect_2, 
		points_2, 
		texture_rect_3, 
		points_3,
		button
	]
	
	for control in controls:
		(control as Control).visible = false

func _show_next_control():
	var control = controls.pop_front()
	if control != null:
		control.visible = true
	else:
		timer.stop()
		timer.queue_free()

func _load_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
