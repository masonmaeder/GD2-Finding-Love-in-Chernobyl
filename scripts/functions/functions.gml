function wrap(_val, _min, _max) {
    if (_val > _max) return _min;
    else if (_val < _min) return _max;
    else return _val;
}

function draw_rectangle_center(_x, _y, _width, _height, _outline, _colour, _alpha) {
    var _old_colour = draw_get_colour();
    var _old_alpha = draw_get_alpha();

    draw_set_colour(_colour);
    draw_set_alpha(_alpha);

    draw_rectangle(_x - _width / 2, _y - _height / 2, _x + _width / 2, _y + _height / 2, _outline);

    draw_set_colour(_old_colour);
    draw_set_alpha(_old_alpha);
}

function background_set_index(_arr) {
    var lay_id = layer_get_id("Background");
    var back_id = layer_background_get_id(lay_id);

    if (is_array(_arr) && array_length(_arr) > 0) {
        layer_background_index(back_id, _arr[0]);
    } else {
        show_debug_message("Error: _arr is not an array or is empty. _arr = " + string(_arr));
    }
}

function chatterbox_update() {
    var node = ChatterboxGetCurrent(chatterbox);
    var text = ChatterboxGetContent(chatterbox, 0);
}