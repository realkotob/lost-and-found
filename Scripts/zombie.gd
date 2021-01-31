extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var max_speed = 5
var separation_dist = 2
var separation_strength = 0.1
var arrive_rad = 5
func _process(delta):
	
	var target = Global.ground_player
	if not target:
		return
	
	var target_pos = target.global_transform.origin
	var target_dist = target_pos - global_transform.origin
	var desired_vel = target_dist.normalized() * max_speed
	if target_dist.length_squared() < arrive_rad:
		desired_vel *= target_dist.length_squared() / arrive_rad
	var others = get_tree().get_nodes_in_group("zombie")
	for zom in others:
		if zom != self:
			var dist = global_transform.origin - zom.global_transform.origin
			if dist.length_squared() < separation_dist:
				print("Too close")
				desired_vel += dist.normalized() * separation_strength * max_speed * ( 1- dist.length_squared() / separation_dist)
			
	desired_vel = desired_vel.normalized() 
	global_transform.origin += desired_vel * delta
	
	var rayobj = $RayCast.get_collider()
	if rayobj:
		var y_pos = $RayCast.get_collision_point().y
		global_transform.origin.y = y_pos + 0.01
