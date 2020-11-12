
#include "trail.h"

using namespace godot;

void Trail::_register_methods() {
    register_method("_process", &Trail::_process);
    register_method("new_vertex", &Trail::new_vertex);
    register_method("toggle_visibility", &Trail::toggle_visibility);

    // register_property();
}

void Trail::_init() {
    
}

void Trail::_process(float delta) {
    
}

void Trail::new_vertex(Vector3 position) {
    
}

void Trail::toggle_visibility() {
    
}

void Trail::set_is_enabled(bool b) {
    
}

bool Trail::get_is_enabled() {
    
}
