extends TextureRect



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Global.copter_player:
		return

	$Dial.rect_rotation = - rad2deg(Global.copter_player.get_compass_rotation())
