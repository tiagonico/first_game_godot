extends Node2D

@onready var player = %Player
@onready var game_manager = %GameManager
@onready var collision_polygon_2d = $Killzone/CollisionPolygon2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

const RANGE = 130
const SPEED = 150
var direction 
var start_running = false

func _process(delta):
	var distance = player.position.x - position.x
	
	if !start_running:
		if distance < 0:
			direction = -1
		else:
			direction = 1
			
		if direction < 0 and !animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = true
		elif direction > 0 and animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = false			
		position.distance_to(player.position)
	if position.distance_to(player.position) < RANGE and !game_manager.is_dead:
		start_running = true
		animated_sprite_2d.play("running")
		
	if start_running:
		position.x += delta * SPEED * direction

func _on_timer_timeout():
	queue_free()
