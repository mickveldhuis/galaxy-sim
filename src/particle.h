#include <vector>

#include <Godot.hpp>
#include <KinematicBody.hpp>
#include <ImmediateGeometry.hpp>

#include "leapfrog.h"
#include "initial_conditions.h"
#include "trail.h"

namespace godot {

class Particle : public KinematicBody {
    GODOT_CLASS(Particle, KinematicBody)

private:
    float mean_velocity;
    float velocity_error;

    std::vector<Vector3> prev_positions;
    Leapfrog* leapfrog;
    InitialConditions* ic;
    
    Spatial* galaxy;
    Trail* trail;

    Vector3 get_initial_position();
    Vector3 get_initial_velocity();

public:
    static void _register_methods();

    // Particle();
    // ~Particle();

    void _init();
    void _ready();
    void _physics_process(float delta);

    void set_trail(NodePath path);
    void toggle_trail();
};

}