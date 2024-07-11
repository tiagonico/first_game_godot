extends Node2D


@onready var sound_pause = $SoundPause
@onready var sound_unpause = $SoundUnpause

func play_pause_sound():
	sound_pause.play()
	
func play_unpause_sound():
	sound_unpause.play()

