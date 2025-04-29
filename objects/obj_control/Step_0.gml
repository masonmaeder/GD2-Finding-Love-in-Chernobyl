var node = dialogue_nodes[? current_node];
var space_pressed = keyboard_check_pressed(vk_space);

if (is_typing) {
    if (space_pressed) {
		audio_play_sound(snd_boop, 1, false); 
        typewriter_index = string_length(typewriter_text);
        is_typing = false;
    } else if (typewriter_index < string_length(typewriter_text)) {
        typewriter_index += 1;
		audio_play_sound(snd_boop2, 0, false);
    }
}
else {
    if (current_page < array_length(pages) - 1 && space_pressed) {
        current_page += 1;
        typewriter_text = pages[current_page];
        typewriter_index = 0;
        is_typing = true;
    }
    else if (current_page == array_length(pages) - 1 && array_length(node.choices) > 0) {
        var count = array_length(node.choices);
        var total_choices = count + 1; // +1 because of "Leave" option

        if (keyboard_check_pressed(vk_down)) {
			selected_choice = (selected_choice + 1) mod total_choices;
			audio_play_sound(snd_boop, 1, false); // Play boop when moving down
		}
		if (keyboard_check_pressed(vk_up)) {
			selected_choice = (selected_choice - 1 + total_choices) mod total_choices;
			audio_play_sound(snd_boop, 1, false); // Play boop when moving up
		}


  if (space_pressed) {
    if (selected_choice == count) {
        // Leave button clicked
		 audio_play_sound(snd_boop, 1, false); 
        global.dialogue_progress[? global.dialogue_file] = current_node;
        room_goto(rm_game);
    } else {
        var next_node = node.choices[selected_choice][1];

        if (is_string(next_node)) {
            var lower_node = string_lower(next_node);

            if (lower_node == "leave") {
                global.dialogue_progress[? global.dialogue_file] = "leave";
                room_goto(rm_game);
            } else if (lower_node == "endgame") {
                room_goto(rm_endgame);
            } else if (lower_node == "gameover") {
                room_goto(rm_gameover);
            } else {
                scr_load_node(next_node);
            }
        }
    }
}


    }
}

// === Mouse check for Leave Button ===
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var btn_x = room_width - 180;
var btn_y = room_height - 80;
var btn_w = 140;
var btn_h = 40;

if (mouse_check_button_pressed(mb_left)) {
    if (mx >= btn_x && mx <= btn_x + btn_w && my >= btn_y && my <= btn_y + btn_h) {
        // Save before leaving
        global.dialogue_progress[? global.dialogue_file] = current_node;
        room_goto(global.return_room); // Again, use return room
    }
}
