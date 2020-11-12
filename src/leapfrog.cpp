#include "leapfrog.h"

Leapfrog::Leapfrog(Vector3 init_position, Vector3 init_velocity, Ref<FuncRef> f, float delta) {
    force = f;
    time_step = delta;

    position = init_position;
    velocity = init_velocity + 0.5 * time_step * (Vector3)force->call_func(position);

    prev_position = Vector3(0, 0, 0);
    prev_velocity = Vector3(0, 0, 0);
}

Leapfrog::~Leapfrog() {
}

Vector3 Leapfrog::next() {
    prev_position = position;
    prev_velocity = velocity;


    position += time_step * velocity;
    velocity += time_step * (Vector3)force->call_func(position);

    return position;
}

void Leapfrog::set_time_step(float delta) {
    time_step = delta;
}
