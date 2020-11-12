#include <vector>

#include <Godot.hpp>
#include <Vector3.hpp>
#include <ImmediateGeometry.hpp>

namespace godot {

class Trail : public ImmediateGeometry {
    GODOT_CLASS(Trail, ImmediateGeometry)

private:
    bool is_enabled;
    std::vector<Vector3> history;

public:
    static void _register_methods();

    void _init();
    void _process(float delta);

    void new_vertex(Vector3 position);
    void toggle_visibility();

    void set_is_enabled(bool b);
    bool get_is_enabled();
};

}