extends Camera


export(int) var player_number = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func horizontalify(vec : Vector3):
	return (vec - Vector3.UP*vec.dot( Vector3.UP)).normalized()
	
func _process(delta):
	var move_vec = Vector3(0,0,0)
	if Input.is_action_pressed("p%s_down" %str(player_number)):
		move_vec += horizontalify(global_transform.basis.z)
	if Input.is_action_pressed("p%s_up" %str(player_number)):
		move_vec -= horizontalify(global_transform.basis.z)
	if Input.is_action_pressed("p%s_right" %str(player_number)):
		move_vec += horizontalify(global_transform.basis.x)
	if Input.is_action_pressed("p%s_left" %str(player_number)):
		move_vec -= horizontalify(global_transform.basis.x)
		
	global_transform.origin += move_vec
