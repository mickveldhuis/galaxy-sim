#include "initial_conditions.h"

InitialConditions::InitialConditions() {
    rng = Ref<RandomNumberGenerator>(RandomNumberGenerator::_new());
    rng->randomize();
}

InitialConditions::~InitialConditions() {
}

float InitialConditions::sample_polar_angle() {
    float n = rng->randf();

    return acos(2 * n - 1);
}

float InitialConditions::sample_radius(FuncRef pdf, float scale_factor) {
    float sample;

    while (!sample) {
        float prob = rng->randf();
        float trial_sample = rng->randf_range(0, scale_factor);
        
        if ((float)pdf.call_func(trial_sample) <= prob) {
            sample = trial_sample;
        }
    }

    return sample;
}

Vector3 InitialConditions::random_position() {
    
}

Vector3 InitialConditions::random_velocity() {
    
}

Vector3 InitialConditions::spherical_to_cartesian(float radius, float polar_angle, float azimuthal_angle) {
    float x = radius * cos(azimuthal_angle) * sin(polar_angle);
    float y = radius * sin(azimuthal_angle) * sin(polar_angle);
    float z = radius * cos(polar_angle);

    return Vector3(x, y, z);
}
