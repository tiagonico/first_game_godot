extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer

func _on_ready():
	if PlayerVariables.checkpoint >= 2:
		animated_sprite_2d.play("idle")
	if Global.is_hardcore:
		visible = false
		
func _on_body_entered(_body):
	if PlayerVariables.checkpoint != 2 and !Global.is_hardcore:
		audio_stream_player.play()
		PlayerVariables.checkpoint = 2
		animated_sprite_2d.play("idle")
	
