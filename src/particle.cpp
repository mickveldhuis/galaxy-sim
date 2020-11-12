#include "particle.h"

using namespace godot;

void Particle::_register_methods() {
    register_method("_ready", &Particle::_ready);
    register_method("_physics_process", &Particle::_physics_process);
    register_method("set_trail", &Particle::set_trail);
    register_method("toggle_trail", &Particle::toggle_trail);
}

void Particle::_init() {
    
}

void Particle::_ready() {
    Vector3 init_pos = get_initial_position();
    Vector3 init_vel = get_initial_velocity();

    Ref<FuncRef> f_ref = Ref<FuncRef>(FuncRef::_new());
    galaxy = Object::cast_to<Spatial>(get_node("/root/Galaxy"));

    f_ref->set_instance(galaxy);
    f_ref->set_function("force");

    set_translation(init_pos);

    leapfrog = new Leapfrog(init_pos, init_vel, f_ref, 1/60);
}

void Particle::_physics_process(float delta) {
    Vector3 next_position = leapfrog->next();
    set_translation(next_position);

    if (trail) {
        trail->new_vertex(get_global_transform().get_origin());
    }
}

void Particle::set_trail(NodePath path) {
    
}

void Particle::toggle_trail() {
    
}

Vector3 Particle::get_initial_position() {
    
}

Vector3 Particle::get_initial_velocity() {
    
}
