extends Spatial


var zombie_fab = preload("res://zombie.tscn")

var zombie_count = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in zombie_count:
		var new_zombie = zombie_fab.instance()
		add_child(new_zombie)
	
	for zom in get_children():
		zom.global_transform.origin = Vector3(5 + (randi() % 370), 0, 5+ (randi() % 370))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
