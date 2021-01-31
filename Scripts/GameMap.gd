extends TextureRect



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("toggle_game_map",self,"toggle_game_map")
	Global.connect("update_player_pos",self,"set_player_pos")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func toggle_game_map():
	visible = not visible

func set_player_pos(global_x, global_z):
	if not visible:
		return
	$PlayerPos.rect_position.x =global_x/Global.MAP_WIDTH * rect_size.x
	$PlayerPos.rect_position.y =global_z/Global.MAP_WIDTH * rect_size.y

