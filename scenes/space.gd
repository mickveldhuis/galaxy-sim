extends Node


export(float) var time_multiplier = 100


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("pause"):
		Global.is_paused = not Global.is_paused
