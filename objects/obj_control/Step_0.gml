var node = dialogue_nodes[? current_node];
var space_pressed = keyboard_check_pressed(vk_space);

//Typewriter Logic
if (is_typing) {
    if (space_pressed) {
        // Instantly finish the text
        typewriter_index = string_length(typewriter_text);
        is_typing = false;
    } else if (typewriter_index < string_length(typewriter_text)) {
        typewriter_index += 1;
    }
}
else
{
    //If more pages remain, advance
    if (current_page < array_length(pages) - 1 && space_pressed) {
        current_page += 1;
        typewriter_text = pages[current_page];
        typewriter_index = 0;
        is_typing = true;
    }

    //Final Page
    else if (current_page == array_length(pages) - 1 && array_length(node.choices) > 0) {
        var count = array_length(node.choices);

        //Move up/down through choices
        if (keyboard_check_pressed(vk_down)) {
            selected_choice = (selected_choice + 1) mod count;
        }
        if (keyboard_check_pressed(vk_up)) {
            selected_choice = (selected_choice - 1 + count) mod count;
        }

        //Choose selected option
        if (space_pressed) {
            var next_node = node.choices[selected_choice][1];
            scr_load_node(next_node);
        }
    }
}
