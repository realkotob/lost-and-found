extends Node


var MAP_WIDTH = 384

var ground_player
var copter_player

signal toggle_game_map
signal you_win
signal you_lose
signal update_player_pos(global_x,global_y)


var game_stopped = false

var quadrants = []
var ground_start_pos = Vector2(0,0)
var copter_start_pos = Vector2(0,0)
func _ready():
	randomize()
#	for i in 16:
#		quadrants.push_back(i)
#	print(quadrants)
#	quadrants.shuffle()
#
#	var ground_player_quadrant = quadrants[0]
#	var offset = 
#	ground_start_pos = 384/16
#	var copter_player_quadrant = quadrants[1]
	ground_start_pos= Vector2(randf() * 384, randf() * 384)
	copter_start_pos= Vector2(randf() * 384, randf() * 384)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
