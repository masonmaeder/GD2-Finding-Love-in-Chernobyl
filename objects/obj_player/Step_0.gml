if (place_meeting(x,y,obj_barrel) && keyboard_check_pressed(vk_space)){
	jumpedIn = !jumpedIn;
}

if (jumpedIn) {
	    visible = false; // Hide player
	    xSpeed = 0;
	    ySpeed = 0;
	    exit; // Stop movement processing
} else {
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


	//wall collisions
	if place_meeting(x+xSpeed, y, obj_wall){
		xSpeed = 0;
	}
	if place_meeting(x, y+ySpeed, obj_wall){
		ySpeed = 0;
	}


	//move player
	x += xSpeed;
	y += ySpeed;

	//keep players within boundaries
	x = clamp(x, 0, room_width-sprite_width);
	y = clamp(y, 0, room_height - sprite_height);

}