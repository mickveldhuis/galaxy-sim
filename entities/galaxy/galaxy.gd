extends Spatial

export(Vector3) var initial_position = Vector3.ZERO
export(Vector3) var initial_velocity = Vector3.ZERO
export(int) var particle_count = 5

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var position : Vector3 = Vector3.ZERO
var velocity : Vector3 = Vector3.ZERO

var gal_scale : float = 20.0 # Scale length
var sat_scale : float = 0.1

var sat_pot : Potential = Potential.new(sat_scale)
var gal_pot : Potential = Potential.new(gal_scale)

var lf : Leapfrog

var trail : Node

onready var particle_container : Spatial = $Particles
#onready var trails : Spatial = $ParticleTrails
onready var trails : Spatial = get_tree().current_scene.get_node("ParticleTrails")

func _ready() -> void:
	var f_ref : FuncRef = funcref(gal_pot, "force")
	lf = Leapfrog.new(initial_position, initial_velocity, f_ref, Global.time_multiplier * Global.TIME_STEP)
	
	# Add a trail to the galaxy mesh
	var _gal_trail : ImmediateGeometry = ResourceManager.trail.instance()
	trails.add_child(_gal_trail)
	trail = get_node(_gal_trail.get_path())
	trail.toggle_visibility()
	
	# Spawn the particles that make up the galaxy
	for particle_n in particle_count:
		var _particle : KinematicBody = ResourceManager.particle.instance()
		var _trail : ImmediateGeometry = ResourceManager.trail.instance()

		particle_container.add_child(_particle)
		trails.add_child(_trail)

		_particle.set_trail(_trail.get_path())


func _physics_process(delta: float) -> void:	
	if not Global.is_paused:
		position = lf.next()
		translation = position
		
		if trail:
			trail.new_vertex(position)


func toggle_trail() -> void:
	if trail:
		trail.toggle_visibility()


func update_lf() -> void:
	lf.update_time_step()
