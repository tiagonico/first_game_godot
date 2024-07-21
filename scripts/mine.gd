extends Node2D


@onready var mine = $Mine
@onready var explosion = $Explosion
@onready var timer = $Timer
@onready var explosion_sound = $ExplosionSound

func _ready():
	explosion.visible = false

func _on_area_2d_body_entered(body):
	if !Global.player_dead:
		explosion_sound.play()
		explosion.visible = true
		explosion.play("explosion")
		mine.visible = false
		Engine.time_scale = 0.5
		Global.player_dead = true
		SignalManager.player_died.emit()
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	Global.player_dead = false
	if PlayerVariables.has_lifes():
		Global.go_to_current_level()
	else:
		if Global.is_hardcore:
			Global.go_to_game_over()
		else:
			PlayerVariables.reset_variables(false)
			Global.go_to_current_level()


func _on_animated_sprite_2d_animation_finished():
	explosion.visible = false
