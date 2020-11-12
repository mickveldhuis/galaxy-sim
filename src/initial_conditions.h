#include <Godot.hpp>
#include <Vector3.hpp>
#include <FuncRef.hpp>
#include <RandomNumberGenerator.hpp>

using namespace godot;

class InitialConditions {
private:
    Ref<RandomNumberGenerator> rng;

    float sample_polar_angle();
    float sample_radius(FuncRef pdf, float scale_factor);
    
public:
    InitialConditions();
    ~InitialConditions();

    Vector3 random_position();
    Vector3 random_velocity();

    static Vector3 spherical_to_cartesian(float radius, float polar_angle, float azimuthal_angle);
};