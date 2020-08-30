class_name Potential
extends Node


var r_s : float


func _init(scale_length : float = 1) -> void:
	r_s = scale_length


func potential(r : float) -> float:
	return - 1/(r + r_s)


func force(pos : Vector3) -> Vector3:
	var r : float = pos.length()
	var cst : float = - (r * pow(r + r_s, -2))
	return cst * pos


func esc_vel(r : float) -> float:
	return sqrt(-2*potential(r))


func cumul_mass(r : float) -> float:
	return pow(r/(r + r_s), 2)
