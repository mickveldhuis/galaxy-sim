extends KinematicBody


export(float) var vel_mean = 0.1
export(float) var vel_error = 0.02

var prev_positions : Array = []

var ic : InitialConditions = InitialConditions.new()
var lf : Leapfrog

onready var galaxy : Spatial = get_tree().current_scene.get_node("Galaxy")
onready var trail : ImmediateGeometry


func _ready() -> void:	
#	var pos_init : Vector3 = _get_initial_position()
#	var vel_init : Vector3 = _get_initial_velocity(pos_init)
	var pos_init : Vector3 = _get_initial_position() + galaxy.initial_position
	var vel_init : Vector3 = _get_initial_velocity(pos_init) + galaxy.initial_velocity
	var f_ref : FuncRef = funcref(galaxy.gal_pot, "force")

	translation = pos_init
	
	lf = Leapfrog.new(pos_init, vel_init, f_ref, Global.time_multiplier * Global.TIME_STEP)


func _physics_process(delta: float) -> void:
	if not Global.is_paused:
		var next_pos : Vector3 = lf.next()
		translation = next_pos
		
		if trail and trail.has_method("new_vertex"):
			trail.new_vertex(global_transform.origin)


func _get_initial_position() -> Vector3:
	var pdf_ref : FuncRef = funcref(galaxy.sat_pot, "cumul_mass") 
	var r_max : float = 10 * galaxy.sat_scale
	
	return ic.rand_position(pdf_ref, r_max)


func _get_initial_velocity(pos : Vector3) -> Vector3:
	var ev_ref : FuncRef = funcref(galaxy.sat_pot, "esc_vel")
	var r : float = pos.length()
	
	return ic.rand_velocity(vel_mean, vel_error, r, ev_ref)


func set_trail(path : NodePath) -> void:
	trail = get_node(path)


func toggle_trail() -> void:
	if trail:
		trail.toggle_visibility()


func update_lf() -> void:
	lf.update_time_step()
