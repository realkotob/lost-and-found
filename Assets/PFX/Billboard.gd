extends MeshInstance
tool

export(float) var UNIT_SIZE = 10 setget set_unit_size
export(PackedScene) var TWODEE_SCENE 
export(bool) var press_to_refresh = false setget on_refresh_billboard
#  setget set_twodee_scene, get_twodee_scene

var scene2d : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("set_viewport_tex")

	set_twodee_scene(TWODEE_SCENE)
#	get_tree().connect("node_added", self, "on_nodes_changed")
#	get_tree().connect("node_removed", self, "on_nodes_changed")
	
	refresh_billboard()

func set_viewport_tex():
#	var view_tex = ViewportTexture.new()
#	view_tex.viewport_path = owner.get_path_to(get_node("Viewport"))
#	get_surface_material(0).albedo_texture = view_tex
	var whatever = owner
	if not whatever:
		whatever = self
	get_surface_material(0).albedo_texture.viewport_path = owner.get_path_to(get_node("Viewport"))
	get_surface_material(0).params_billboard_mode = SpatialMaterial.BILLBOARD_ENABLED
	get_surface_material(0).flags_albedo_tex_force_srgb = true

func on_nodes_changed(some_node):
	if some_node.get_parent() == $Viewport:
		call_deferred("refresh_billboard")

func refresh_billboard():
	if $Viewport.get_child_count()>0:
		if not scene2d:
			scene2d = $Viewport.get_child(0)
		if not scene2d:
			return
		$Viewport.size = scene2d.rect_size
		
		mesh.size = Vector2(UNIT_SIZE, UNIT_SIZE / scene2d.rect_size.x * scene2d.rect_size.y)

func set_unit_size(value):
	UNIT_SIZE = value
	if not scene2d:
		return
	mesh.size = Vector2(UNIT_SIZE, UNIT_SIZE / scene2d.rect_size.x * scene2d.rect_size.y)

func set_twodee_scene(twodee_scene):
	for thing in $Viewport.get_children():
		thing.call_deferred("queue_free")
		
	if twodee_scene:
		scene2d = twodee_scene.instance()
		$Viewport.add_child(scene2d)
		scene2d.name = "Control"
		scene2d.owner = owner
		$Viewport.size = scene2d.rect_size
		mesh.size = Vector2(UNIT_SIZE, UNIT_SIZE / (scene2d.rect_size.x / scene2d.rect_size.y))

func on_refresh_billboard(value):
	print("on_refresh_billboard")
	set_twodee_scene(TWODEE_SCENE)
	press_to_refresh = false
