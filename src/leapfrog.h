#include <Godot.hpp>
#include <Vector3.hpp>
#include <FuncRef.hpp>

using namespace godot;

class Leapfrog {
private:
    Vector3 position;
    Vector3 velocity;

    Vector3 prev_position;
    Vector3 prev_velocity;

    float time_step;
    Ref<FuncRef> force;
    
public:
    Leapfrog(Vector3 init_position, Vector3 init_velocity, Ref<FuncRef> f, float delta);
    ~Leapfrog();

    Vector3 next();
    void set_time_step(float delta);

};