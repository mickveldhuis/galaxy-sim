extends Control


onready var bottom_panel : Panel = $BottomContainer/Panel
onready var multiplier_label : Label = $TopContainer/Panel/HBoxRight/MultiplierLabel
onready var help_window : MarginContainer = $HelpContainer


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	bottom_panel.visible = Global.is_paused
	multiplier_label.text = "Time Multiplier: {x}".format({"x": Global.time_multiplier})
	
	handle_multiplier_input(delta)


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("toggle_help"):
		help_window.visible = not help_window.visible


func handle_multiplier_input(_delta : float) -> void:
	if Input.is_action_pressed("multiplier_up") and Global.time_multiplier < Global.MAX_MULTIPLIER:
		Global.time_multiplier += 1
	
	if Input.is_action_pressed("multiplier_down") and Global.time_multiplier > Global.MIN_MULTIPLIER:
		Global.time_multiplier -= 1
	
	if Input.is_action_just_pressed("multiplier_up_slow") and Global.time_multiplier < Global.MAX_MULTIPLIER:
		Global.time_multiplier += 1
	
	if Input.is_action_just_pressed("multiplier_down_slow") and Global.time_multiplier > Global.MIN_MULTIPLIER:
		Global.time_multiplier -= 1
	
	get_tree().call_group("moving_bodies", "update_lf")


func _on_res_and_pause_button_up() -> void:
	Global.is_paused = not Global.is_paused


func _on_galaxy_trail_toggled(button_pressed: bool) -> void:
	var galaxy : Spatial = get_tree().current_scene.get_node("Galaxy")
	galaxy.toggle_trail()
