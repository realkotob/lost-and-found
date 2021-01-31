extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game_stopped = false
	Global.pick_random_positions()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()
