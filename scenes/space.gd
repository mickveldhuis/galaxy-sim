extends Node


export(float) var time_multiplier = 100


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("pause"):
		Global.is_paused = not Global.is_paused


func handle_multiplier_input(_delta : float) -> void:
	if Input.is_action_pressed("multiplier_up") and Global.time_multiplier < Global.MAX_MULTIPLIER:
		_update_multiplier(1)
	
	if Input.is_action_pressed("multiplier_down") and Global.time_multiplier > Global.MIN_MULTIPLIER:
		_update_multiplier(-1)
	
	if Input.is_action_just_pressed("multiplier_up_slow") and Global.time_multiplier < Global.MAX_MULTIPLIER:
		_update_multiplier(1)
	
	if Input.is_action_just_pressed("multiplier_down_slow") and Global.time_multiplier > Global.MIN_MULTIPLIER:
		_update_multiplier(-1)
	

func _update_multiplier(amount : int) -> void:
	Global.time_multiplier += amount
	get_tree().call_group("moving_bodies", "update_lf")
