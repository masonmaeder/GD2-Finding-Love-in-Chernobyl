chatterbox = undefined;
text = "How are you today?"
ChatterboxLoadFromFile("test1.yarn");				//Load file
ChatterboxAddFunction("bg", background_set_index);  //Add function to change background index
chatterbox = ChatterboxCreate();
ChatterboxJump(chatterbox, "Start");
chatterbox_update();

option_index = 0;

size = [0.7, 0.75];           //Character size (speaking/not speaking)
colour = [c_ltgray, c_white];
