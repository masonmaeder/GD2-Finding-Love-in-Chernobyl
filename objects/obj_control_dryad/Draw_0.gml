var node = dialogue_nodes[? current_node];

// === Text and Box Style ===
draw_set_font(fnt_dialogue);
draw_set_color(c_white);

// === Portrait ===
var char_x = 275;
var char_y = room_height - (size[0]);
draw_sprite_ext(character_sprite, 0, char_x, char_y, size[0], size[0], 0, colour[0], 1);

// === Dialogue Box ===
var margin = 32;
var box_w = room_width - 64;
var box_h = 220;
var box_x = (room_width - box_w) / 2;
var box_y = room_height - box_h - 32;

draw_set_alpha(0.92);
draw_set_color(make_color_rgb(15, 15, 15));
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
draw_set_alpha(1);
draw_set_color(c_white);

// === Typewriter Text ===
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var shown_text = string_copy(typewriter_text, 1, typewriter_index);
draw_text_ext(box_x + 24, box_y + 24, shown_text, -1, box_w - 48);

// === Choices (only after last page is done) ===
if (!is_typing && current_page == array_length(pages) - 1) {
    var choice_x = room_width / 2;
    var choice_start_y = room_height / 2 - 140;
    var choice_width = 880;
    var text_padding = 24;
    var vertical_spacing = 20;

    var choice_data = [];

    // Pass 1: Precompute choice text + height
    for (var i = 0; i < array_length(node.choices); i++) {
        var raw = node.choices[i][0];
        raw = string_replace_all(raw, "’", "'");
        raw = string_replace_all(raw, "“", "\"");
        raw = string_replace_all(raw, "”", "\"");

        var prefix = (i == selected_choice) ? "> " : "";
        var choice_text = prefix + raw;
        var text_w = choice_width - 64;
        var lines = ceil(string_width(choice_text) / text_w);
        var box_height = lines * (string_height("A") + 6) + text_padding;

        array_push(choice_data, [choice_text, box_height]);
    }

    // Total height for centering
    var total_height = 0;
    for (var i = 0; i < array_length(choice_data); i++) {
        total_height += choice_data[i][1];
        if (i < array_length(choice_data) - 1) total_height += vertical_spacing;
    }

    var y_cursor = choice_start_y - total_height / 2;

    // Pass 2: Draw each choice
    for (var i = 0; i < array_length(choice_data); i++) {
        var choice_text = choice_data[i][0];
        var box_height = choice_data[i][1];

        // Background
        draw_set_alpha(0.85);
        draw_set_color(make_color_rgb(25, 25, 25));
        draw_rectangle(choice_x - choice_width / 2, y_cursor, choice_x + choice_width / 2, y_cursor + box_height, false);

        // Text
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_halign(fa_left);

        var text_x = choice_x - choice_width / 2 + 32;
        var text_y = y_cursor + 12;

        draw_text_ext(text_x, text_y, choice_text, -1, choice_width - 64);

        y_cursor += box_height + vertical_spacing;
    }
}
