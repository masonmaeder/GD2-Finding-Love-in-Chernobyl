var _count = ChatterboxGetOptionCount(chatterbox); // Get the number of options we have


if ChatterboxIsWaiting(chatterbox) and keyboard_check_pressed(vk_space) // Is Chatterbox waiting for user input
{
    ChatterboxContinue(chatterbox);
    chatterbox_update();
}
else if _count // Is Chatterbox presenting the user with options
{
    var _key = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    
    // Move option_index twice if next option is invalid
    repeat (1 + (ChatterboxGetOptionConditionBool(chatterbox, wrap(option_index + _key, 0, _count - 1)) == false))
    {
        option_index = wrap(option_index + _key, 0, _count - 1);
    }

    if keyboard_check_pressed(vk_space)
    {
		if (option_index == 0) {
			background_set_index([0]);
			text = "Glad to hear!";
			alarm[0] = game_get_speed(gamespeed_fps) * 3;
		} 
		else if (option_index == 1) {
			background_set_index([0]); // Set background to tile 1
			text = "Oh noooo, did I do something to upset you?";
			alarm[0] = game_get_speed(gamespeed_fps) * 3;
		} 
		else if (option_index == 2) {
			background_set_index([0]); // Set background to tile 2
			text = "Lets get married!!";
			alarm[0] = game_get_speed(gamespeed_fps) * 3;
		}
    }
}

if ChatterboxIsStopped(chatterbox) // End when reached end of chatterbox
{
    instance_destroy();
}
