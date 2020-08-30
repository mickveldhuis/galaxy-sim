extends ImmediateGeometry


var history : Array = []
var is_enabled : bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if is_enabled:
		clear()
		begin(PrimitiveMesh.PRIMITIVE_LINE_STRIP)
		
		for pos in history:
			add_vertex(pos)
		
		end()

func new_vertex(pos : Vector3) -> void:
	history.append(pos)


func toggle_visibility() -> void:
	clear()
	history.clear()
	
	is_enabled = not is_enabled
