extends Node

class_name FormManager

var is_player_transformed = false
var player_invader_form = 0
var form_points = 0

func _on_player_cycle(form):
	is_player_transformed = true
	player_invader_form = form
	
	if form == 0:
		form_points = 40
	elif form == 1:
		form_points = 20
	elif form == 2:
		form_points = 10

func _on_player_reset_form():
	is_player_transformed = false
	form_points = 0
