extends Area2D

@onready var label = $Label

func _on_body_entered(_body):
	label.show()

func _on_ready():
	label.hide()

func _on_body_exited(_body):
	label.hide()
