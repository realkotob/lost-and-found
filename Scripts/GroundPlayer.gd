extends Spatial

export(float) var player_speed = 40

var player_number = 1
onready var cam = $CameraHelper/Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ground_player = self

func horizontalify(vec : Vector3):
	return (vec - Vector3.UP*vec.dot( Vector3.UP)).normalized()

var check_height = 0
var des_height = 0
func _process(delta):
	if Global.game_stopped:
		return
		
	var move_vec = Vector3(0,0,0)
	if Input.is_action_pressed("p%s_down" %str(player_number)):
		move_vec += horizontalify(cam.global_transform.basis.z)
	if Input.is_action_pressed("p%s_up" %str(player_number)):
		move_vec -= horizontalify(cam.global_transform.basis.z)
	
	var rotate_dir = 0
	if Input.is_action_pressed("p%s_right" %str(player_number)):
		rotate_dir -= delta
#		move_vec += horizontalify(cam.global_transform.basis.x)
	if Input.is_action_pressed("p%s_left" %str(player_number)):
		rotate_dir += delta
#		move_vec -= horizontalify(cam.global_transform.basis.x)
	
	$CameraHelper.rotate_y(rotate_dir)
		
	var next_pos = global_transform.origin + move_vec * delta * player_speed
	if next_pos.z < 384 and next_pos.x < 384 and next_pos.z > 0 and next_pos.x > 0:
		global_transform.origin = next_pos
	
#	global_transform.origin.y = lerp(global_transform.origin.y,des_height, delta * 30)
		
#	if check_height > 0:
#		check_height -=1
#		return
#
#	check_height = 2
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		des_height = y_pos + 0.01
		global_transform.origin.y = des_height
		
func get_compass_rotation():
	return $CameraHelper.rotation.y
