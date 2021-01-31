extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		global_transform.origin.y = y_pos + 0.01

var max_speed = 2.5
var separation_dist = 2
var separation_strength = 0.1
var arrive_rad = 5

var activate_distance_from_player = 4000
var check_height = 0 
func _process(delta):
	
	var target = Global.ground_player
	if not target:
		return
	
	
	var target_pos = target.global_transform.origin
	var target_dist = target_pos - global_transform.origin
	var dis_sq = target_dist.length_squared()
	if  dis_sq > activate_distance_from_player:
		$RayCast.enabled = false
		hide()
		return
	
	if dis_sq < 0.2:
		Global.emit_signal("you_lose")
		Global.game_stopped = true
		return
	
	$RayCast.enabled = true
	show()
			
		
	var desired_vel = target_dist.normalized()
	if dis_sq < arrive_rad:
		desired_vel *= dis_sq / arrive_rad
	var others = get_tree().get_nodes_in_group("zombie")
	for zom in others:
		if zom != self:
			var dist = global_transform.origin - zom.global_transform.origin
			if dist.length_squared() < separation_dist:
				desired_vel += dist.normalized() * separation_strength * ( 1- dist.length_squared() / separation_dist)
			
	desired_vel = desired_vel.normalized() * max_speed
	global_transform.origin += desired_vel * delta
	
	if check_height > 0:
		check_height -=1
		return
	
	check_height = 30 + randi() % 180
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		global_transform.origin.y = y_pos + 0.01
