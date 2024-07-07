extends Button

@onready var transition = %Transition

func _on_pressed():
	transition.play("fade_out")

func _on_transition_animation_finished(_anim_name):
	PlayerVariables.reset_variables()
	Global.go_to_current_level()
