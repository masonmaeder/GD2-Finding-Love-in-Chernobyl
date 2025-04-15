chatterbox = undefined;
text = "Would you love me if I was a worm?"
ChatterboxLoadFromFile("test.yarn");				//Load file
ChatterboxAddFunction("bg", background_set_index);  //Add function to change background index
chatterbox = ChatterboxCreate();
ChatterboxJump(chatterbox, "Start");
chatterbox_update();

option_index = 0;

size = [0.7, 0.75];           //Character size (speaking/not speaking)
colour = [c_ltgray, c_white];
