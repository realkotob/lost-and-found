extends Spatial

export(float) var player_speed = 40

var player_number = 1
onready var cam = $CameraHelper/Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func horizontalify(vec : Vector3):
	return (vec - Vector3.UP*vec.dot( Vector3.UP)).normalized()
	
func _process(delta):
	var move_vec = Vector3(0,0,0)
	if Input.is_action_pressed("p%s_down" %str(player_number)):
		move_vec += horizontalify(cam.global_transform.basis.z)
	if Input.is_action_pressed("p%s_up" %str(player_number)):
		move_vec -= horizontalify(cam.global_transform.basis.z)
	if Input.is_action_pressed("p%s_right" %str(player_number)):
		move_vec += horizontalify(cam.global_transform.basis.x)
	if Input.is_action_pressed("p%s_left" %str(player_number)):
		move_vec -= horizontalify(cam.global_transform.basis.x)
		
	var next_pos = global_transform.origin + move_vec * delta * player_speed
	if next_pos.z < 384 and next_pos.x < 384 and next_pos.z > 0 and next_pos.x > 0:
		global_transform.origin = next_pos
	
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		global_transform.origin.y = y_pos + 0.01
