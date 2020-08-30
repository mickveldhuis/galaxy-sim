extends Control


onready var bottom_panel : Panel = $BottomContainer/Panel
onready var time_box : SpinBox = $TopContainer/Panel/HBoxRight/SpinBox


func _ready() -> void:
	Global.time_multiplier = int(time_box.value)


func _process(delta: float) -> void:
	bottom_panel.visible = Global.is_paused


func _unhandled_input(event):
	var current_focus : Control = get_focus_owner()
	if current_focus:
		current_focus.release_focus()


func _on_spinbox_value_changed(value: float) -> void:
	Global.time_multiplier = int(time_box.value)
	get_tree().call_group("moving_bodies", "update_lf")


func _on_res_and_pause_button_up() -> void:
	Global.is_paused = not Global.is_paused


func _on_galaxy_trail_toggled(button_pressed: bool) -> void:
	var galaxy : Spatial = get_tree().current_scene.get_node("Galaxy")
	galaxy.toggle_trail()
