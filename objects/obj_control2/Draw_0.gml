draw_set_font(Font1);
draw_set_valign(fa_middle);

var _margin_text = 128; // Horizontal text margin
var _margin_char = 200; // Horizontal character margin

if IsChatterbox(chatterbox) and text != undefined
{
    var _me = (ChatterboxGetContentSpeaker(chatterbox, 0) == "Me");

// Move character to the bottom-left corner
var char_x = 0;  // Small offset from the left edge
var char_y = 180;  // Near the bottom

draw_sprite_ext(characters2, 0, char_x, char_y, size[0], size[0], 0, colour[0], 1);




    var _yy = room_height - (_margin_text / 2);

    draw_rectangle_center(room_width / 2, _yy, room_width, _margin_text, false, c_black, 0.5);

    draw_set_halign(fa_center); // Align text to the center

    var _xx = room_width / 2;

    draw_text(_xx, _yy, text);
	
	// If there are options, draw them to the center of the screen
	if ChatterboxGetOptionCount(chatterbox)
	{
		draw_set_halign(fa_center);

		var _width = 400;
		var _height = 64;
	
		for (var i = 0; i < ChatterboxGetOptionCount(chatterbox); i++)
		{
			if ChatterboxGetOptionConditionBool(chatterbox, i)
			{
				_xx = room_width / 2;
				_yy = (room_height / 6) * (i + 2);

				draw_rectangle_center(_xx, _yy, _width, _height, false, c_black, 0.5);

				var _icon = "";
				if (option_index == i) _icon = "> ";

				var _option = ChatterboxGetOption(chatterbox, i);
				draw_text(_xx, _yy, _icon + _option);
			}
		}
	}
}
