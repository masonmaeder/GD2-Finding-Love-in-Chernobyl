/* if (place_meeting(x,y,obj_barrel) && keyboard_check_pressed(vk_space)){
	jumpedIn = !jumpedIn;
}

if (jumpedIn) {
	    visible = false; // Hide player
	    xSpeed = 0;
	    ySpeed = 0;
	    exit; // Stop movement processing
} else { */
	// If jumped out, allow movement and make visible
	visible = true;

	//get inputs
	rightKey = keyboard_check(vk_right) || keyboard_check(ord("D"));
	leftKey = keyboard_check(vk_left) || keyboard_check(ord("A"));
	upKey= keyboard_check(vk_up) || keyboard_check(ord("W"));
	downKey= keyboard_check(vk_down) || keyboard_check(ord("S"));
	

	
	//getting x and y speeds
	xSpeed = (rightKey - leftKey) * moveSpeed;
	ySpeed = (downKey - upKey) * moveSpeed;
	
	// Handle walking sound
if (xSpeed != 0 || ySpeed != 0) {
    // Player is moving
    if (!audio_is_playing(snd_walking)) {
        audio_play_sound(snd_walking, 1, true); // Loop the walking sound
    }
} else {
    // Player is idle
    if (audio_is_playing(snd_walking)) {
        audio_stop_sound(snd_walking);
    }
}

	
	//show_debug_message(xSpeed);

//var scene_objects = [obj_invis, obj_bin, obj_boulder, obj_dryad_pixel, obj_enemy, obj_fire, obj_guide_pixel, obj_hobo_pixel, obj_lake, obj_ooze_pixel, obj_preacher_pixel, obj_tent, obj_tree, obj_tree_2];

// Max distance to interact
var interact_range = 24;

// List of objects that can trigger scenes
/*
var scene_objects = [obj_preacher_pixel, obj_dryad_pixel];

// Loop through each type of scene object
for (var i = 0; i < array_length(scene_objects); i++) {
*/
    
if (keyboard_check_pressed(vk_space)) {
    var target = instance_nearest(x, y, obj_interactable);
    if (target != noone && distance_to_object(target) < interact_range) {
        // Store data and go to scene
        audio_play_sound(snd_boop, 1, false); 
        global.return_x = x;
        global.return_y = y;
        global.return_room = room;
        
        if (variable_instance_exists(target.id, "dialogue_file")) {
            global.dialogue_file = target.dialogue_file;
        }
        if (variable_instance_exists(target.id, "character_sprite")) {
            global.character_sprite = target.character_sprite;
        }
        if (variable_instance_exists(target.id, "portrait_offset")) {
            global.portrait_offset = target.portrait_offset;
        }
        
        room_goto(target.scene_to_load);
    }
}



// Array of collidable objects
/*
var collidable_obj = [
    obj_bin,
    obj_boulder,
    obj_dryad_pixel,
    obj_enemy,
    obj_fire,
    obj_guide_pixel,
    obj_hobo_pixel,
    obj_lake,
    obj_ooze_pixel,
    obj_preacher_pixel,
    obj_tent,
    obj_tree,
    obj_tree_2
];

// Loop to check collisions on the x-axis
for (var i = 0; i < array_length(collidable_obj); i++) {
    if (place_meeting(x + xSpeed, y, collidable_obj[i])) {
        xSpeed = 0;
    }
}

// Loop to check collisions on the y-axis
for (var i = 0; i < array_length(collidable_obj); i++) {
    if (place_meeting(x, y + ySpeed, collidable_obj[i])) {
        ySpeed = 0;
    }
}
*/



	//move player
	x += xSpeed;
	y += ySpeed;

	//keep players within boundaries
	x = clamp(x, 0, room_width-sprite_width);
	y = clamp(y, 0, room_height - sprite_height);

// }


// Toggle vignette
if (x > 670) {
	layer_set_visible("fx_vignette", true);
} else {
	layer_set_visible("fx_vignette", false);
}

