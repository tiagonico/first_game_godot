extends AnimatableBody2D

@onready var timer = $Timer
@onready var collision_shape_2d = $CollisionShape2D
var aux = 0

func _ready():
	timer.wait_time = 2
	timer.start()

func _on_timer_timeout():
	if aux%2:
		show()
		collision_shape_2d.disabled = false
	else:
		hide()
		collision_shape_2d.disabled = true
	aux+=1
	timer.start()
