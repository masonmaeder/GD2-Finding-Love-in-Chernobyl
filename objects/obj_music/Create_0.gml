if (!audio_is_playing(snd_main)) {
    audio_play_sound(snd_main, 1, true);
}
if (instance_exists(obj_music) && instance_id != obj_music) {
    instance_destroy();
}