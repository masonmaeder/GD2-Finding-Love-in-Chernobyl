audio_stop_sound(snd_walking)
if (!audio_is_playing(snd_talking)) {
    audio_play_sound(snd_talking, 1, true);
}
