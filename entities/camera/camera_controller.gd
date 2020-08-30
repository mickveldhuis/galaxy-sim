extends Spatial


export(float) var rot_speed = PI/2
export(float) var zoom_speed = 0.1
export(float) var max_zoom = 10
export(float) var min_zoom = 0.5

var origin : Vector3 = Vector3.ZERO
var zoom : float = 5
var ray_length : float = 1000.0
var has_full_rot : bool = true
var is_following_galaxy : bool = false

onready var inner_gimbal : Spatial = $InnerGimbal
onready var camera : Camera = $InnerGimbal/Camera
onready var galaxy : Spatial = get_tree().current_scene.get_node("Galaxy")


func _process(delta: float) -> void:
	handle_keyboard_input(delta)
	handle_mouse_input(delta)
	handle_zoom(delta)
	
	if not has_full_rot:
		inner_gimbal.rotation.x = clamp(inner_gimbal.rotation.x, -PI/2, PI/2)
	
	if is_following_galaxy:
		translation = galaxy.global_transform.origin


func handle_keyboard_input(delta : float) -> void:
	var y_rot : float = 0
	
	if Input.is_action_pressed("cam_right"):
		y_rot += 1
	
	if Input.is_action_pressed("cam_left"):
		y_rot -= 1
	
	rotate_object_local(Vector3.UP, y_rot * rot_speed * delta)
	
	var x_rot : float = 0
	
	if Input.is_action_pressed("cam_up"):
		x_rot -= 1
	
	if Input.is_action_pressed("cam_down"):
		x_rot += 1
	
	inner_gimbal.rotate_object_local(Vector3.RIGHT, x_rot * rot_speed * delta)


func handle_mouse_input(delta : float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("select"):
		var res : Dictionary = raycast_from_mouse(mouse_pos)
		if not res.empty() and res.collider.is_in_group("particles") and res.collider.has_method("toggle_trail"):
			res.collider.toggle_trail()


func handle_zoom(delta : float) -> void:
	if Input.is_action_just_released("cam_zoom_in"):
		zoom -= zoom_speed
	
	if Input.is_action_just_released("cam_zoom_out"):
		zoom += zoom_speed
	
	zoom = clamp(zoom, min_zoom, max_zoom)
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	

func raycast_from_mouse(mouse_pos : Vector2) -> Dictionary:
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space_state = get_world().direct_space_state
	
	return space_state.intersect_ray(from, to)
