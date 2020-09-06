class_name Leapfrog
extends Node


var pos : Vector3 = Vector3.ZERO
var vel : Vector3 = Vector3.ZERO
#var vel_resync : Vector3 = Vector3.ZERO

var prev_pos : Vector3 = Vector3.ZERO
var prev_vel : Vector3 = Vector3.ZERO
#var prev_vel_resync : Vector3 = Vector3.ZERO

var t_step : float = 1.0 # Time step
var f : FuncRef # Force/acceleration function


func _init(pos_init : Vector3, vel_init : Vector3, force : FuncRef, time_step : float = 1.0) -> void:
	f = force
	t_step = time_step
	
	pos = pos_init
	vel = vel_init + 0.5 * t_step * f.call_func(pos)


func next() -> Vector3:
	# Store the previous pos/vel
	prev_pos = pos
	prev_vel = vel
	
	# Compute the next vel/pos
	pos += t_step * vel
	vel += t_step * f.call_func(pos)
	
	return pos


func update_time_step() -> void:
	t_step = Global.time_multiplier * Global.TIME_STEP
