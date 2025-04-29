dialogue_nodes = ds_map_create();

if (!variable_global_exists("dialogue_progress")) {
    global.dialogue_progress = ds_map_create();
}

if (!variable_global_exists("dialogue_file")) {
    global.dialogue_file = "dialogue_priest.txt"; // fallback if not set
}
if (!variable_global_exists("character_sprite")) {
    global.character_sprite = spr_preacher_anime;
}
var file = file_text_open_read(global.dialogue_file);
var current_id = "";
var node_text = "";
var choices = [];
var reading_text = false;

while (!file_text_eof(file)) {
    var line = string_trim(file_text_read_string(file));
    file_text_readln(file);

    if (string_starts_with(line, "#ID:")) {
        if (current_id != "") {
            ds_map_add(dialogue_nodes, current_id, {
                text: string_trim(node_text),
                choices: choices
            });
        }

        current_id = string_trim(string_delete(line, 1, 4));
        node_text = "";
        choices = [];
        reading_text = false;
    }
    else if (string_starts_with(line, "TEXT:")) {
        node_text = string_trim(string_delete(line, 1, 5));
        reading_text = true;
    }
    else if (string_starts_with(line, "CHOICE:")) {
        var parts = string_split(string_trim(string_delete(line, 1, 7)), "|");
        array_push(choices, parts);
        reading_text = false;
    }
    else if (reading_text) {
        node_text += "\n" + line;
    }
}

if (current_id != "") {
    ds_map_add(dialogue_nodes, current_id, {
        text: string_trim(node_text),
        choices: choices
    });
}
file_text_close(file);

if (ds_map_exists(global.dialogue_progress, global.dialogue_file)) {
    current_node = global.dialogue_progress[? global.dialogue_file];
} else {
    current_node = "start";
}

selected_choice = 0;
current_page = 0;
pages = [];

typewriter_text = "";
typewriter_index = 0;
typewriter_speed = 0.25;
typewriter_timer = 0;
is_typing = true;

// === Portrait Settings ===
// Important: sprite should be already set before entering room
character_sprite = global.character_sprite;
size = [0.7, 0.75];
colour = [c_white, c_white];

// === Load First Node ===
scr_load_node(current_node);
