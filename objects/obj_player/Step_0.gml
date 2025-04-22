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
    var obj = obj_interactable;

    // Check proximity to ANY instance of the object
    with (obj) {
        if (point_distance(other.x, other.y, x, y) < interact_range) {
            // Optional: draw prompt or effect here

            if (keyboard_check_pressed(vk_space) && variable_instance_exists(id, "scene_to_load")) {
				global.return_x = obj_player.x;
				global.return_y = obj_player.y;
                room_goto(scene_to_load);
            }
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

