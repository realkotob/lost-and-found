extends Spatial


var player_number = 2
var camera_path

onready var cam = $CameraHelper/Camera

export(float) var player_speed = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global.copter_player = self
	
	global_transform.origin.x = Global.copter_start_pos.x
	global_transform.origin.z = Global.copter_start_pos.y

	$CameraHelper.rotate_y(deg2rad(randi() % 360))
	
func horizontalify(vec : Vector3):
	return (vec - Vector3.UP*vec.dot( Vector3.UP)).normalized()

var check_height = 0
var des_height = 0
func _process(delta):
	var move_vec = Vector3(0,0,0)
	if force_move_to_ground_player:
		move_vec = Global.ground_player.global_transform.origin - global_transform.origin
		if move_vec.length_squared() > 1:
			move_vec = move_vec.normalized() * delta * player_speed
			global_transform.origin += move_vec
		return
	
	if Global.game_stopped:
		return
		
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
	
	if Input.is_action_just_pressed("toggle_map"):
		Global.emit_signal("toggle_game_map")
	Global.emit_signal("update_player_pos",global_transform.origin.x, global_transform.origin.z)
	
	
	global_transform.origin.y = lerp(global_transform.origin.y,des_height, delta * 3)
	
	if check_height > 0:
		check_height -=1
		return
	
	check_height = 9
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		des_height = y_pos + 15
func get_compass_rotation():
	return $CameraHelper.rotation.y

var force_move_to_ground_player = false
func _on_Area_body_entered(body):
	print("Body entered")
	if "player_number" in body and body.player_number == 1:
		print("You win")
		Global.game_stopped = true
		Global.emit_signal("you_win")
		force_move_to_ground_player = true
