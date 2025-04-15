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
	rightKey = keyboard_check(vk_right);
	leftKey = keyboard_check(vk_left);
	upKey= keyboard_check(vk_up);
	downKey= keyboard_check(vk_down);
	

	
	//getting x and y speeds
	xSpeed = (rightKey - leftKey) * moveSpeed;
	ySpeed = (downKey - upKey) * moveSpeed;
	
	show_debug_message(xSpeed);

	// all of the collidable obj
    var collidable_obj = [obj_invis, obj_bin, obj_boulder, obj_dryad_pixel, obj_enemy, obj_fire, obj_fog, obj_guide_pixel, obj_hobo_pixel, obj_lake, obj_ooze_pixel, obj_preacher_pixel, obj_tent, obj_tree, obj_tree_2, obj_wall];

    //wall collisions
    for (var i = 0; i < array_length(collidable_obj); i++) {
        if place_meeting(x+xSpeed, y, collidable_obj[i]){
            xSpeed = 0;
        }
        if place_meeting(x, y+ySpeed, collidable_obj[i]){
            ySpeed = 0;
        }
		
		if (collidable_obj[i] == obj_preacher_pixel) {
			if (keyboard_check_pressed(vk_space)) {
				room_goto(rm_stage);
			}	
		}
		if (collidable_obj[i] == obj_dryad_pixel) {
			if (keyboard_check_pressed(vk_space)) {
				room_goto(rm_woods);
			}	
		}
	}

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