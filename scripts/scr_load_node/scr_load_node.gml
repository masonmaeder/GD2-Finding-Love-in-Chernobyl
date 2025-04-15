function scr_load_node(node_id) {
    if (!ds_map_exists(dialogue_nodes, node_id)) {
    show_debug_message("Missing node: " + string(node_id));
    return;
}
var node = dialogue_nodes[? node_id];


    current_node = node_id;
    current_page = 0;
    selected_choice = 0;

    //Sanitize
	var raw_text = string_replace_all(node.text, "’", "'");
    raw_text = string_replace_all(raw_text, "“", "\"");
    raw_text = string_replace_all(raw_text, "”", "\"");
    raw_text = string_replace_all(raw_text, "‘", "'");
    raw_text = string_replace_all(raw_text, "—", "-");

    var max_chars = 460;
    pages = [];

    //split by new line
    var lines = string_split(raw_text, "\n");

    for (var i = 0; i < array_length(lines); i++) {
        var line = string_trim(lines[i]);

        //If short enough, push as its own page
        if (string_length(line) <= max_chars) {
            array_push(pages, line);
        } else {
            //Split long lines into multiple pages
            while (string_length(line) > max_chars) {
                var split_at = max_chars;
                for (var j = max_chars; j < string_length(line); j++) {
                    if (string_char_at(line, j) == " ") {
                        split_at = j;
                        break;
                    }
                }

                var part = string_copy(line, 1, split_at);
                array_push(pages, part);
                line = string_delete(line, 1, split_at);
            }

            //Add any leftover part of the line
            if (string_length(line) > 0) {
                array_push(pages, line);
            }
        }
    }

    typewriter_text = pages[0];
    typewriter_index = 0;
    is_typing = true;
}