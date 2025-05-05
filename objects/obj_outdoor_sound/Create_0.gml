if (!audio_is_playing(snd_outdoor)) {
    audio_play_sound(snd_outdoor, 1, true); // priority 1, loop = true
}
