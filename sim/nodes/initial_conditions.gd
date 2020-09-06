class_name InitialConditions
extends Node


var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func _init() -> void:
	# Generate a time based seed
	rng.randomize()


func rand_position(pdf : FuncRef, r_max : float) -> Vector3:
	var r : float = _r_sample(pdf, r_max)
	
	var azim := rng.randf_range(0, TAU)
	var polar := _rand_polar()
	
	return _spher_to_cart(r, polar, azim)


func rand_velocity(mean : float, error : float, r : float, esc_vel : FuncRef) -> Vector3:
	var vel : Vector3
	
	while not vel:
		var v := Vector3(
			rng.randfn(mean, error),
			rng.randfn(mean, error),
			rng.randfn(mean, error))

		if v.length() < esc_vel.call_func(r):
			vel = v
	
	return vel


func _rand_polar() -> float:
	var n : float = rng.randf()
	return acos(2*n - 1)


func _r_sample(pdf : FuncRef, scale_factor : float = 1) -> float:
	var sample : float
	
	while not sample:
		var prob = rng.randf()
		var trial_sample = rng.randf_range(0, scale_factor)
		
		if pdf.call_func(trial_sample) <= prob:
			sample = trial_sample
		
	return sample


func _spher_to_cart(r, polar, azim) -> Vector3:
	var x : float = r*cos(azim)*sin(polar)
	var y : float = r*sin(azim)*sin(polar)
	var z : float = r*cos(polar)
	
	return Vector3(x, y, z)
