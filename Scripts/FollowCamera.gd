extends Spatial


export(NodePath) var target_path

var target
func _ready():
	if has_node(target_path):
		target = get_node(target_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target:
		return
	global_transform.origin = target.global_transform.origin
