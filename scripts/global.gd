extends Node

var current_scene = null
var max_level = 2
var coins_to_life = 20

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	go_to_main_menu()
	
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

func go_to_next_level():
	var next_level = PlayerVariables.player_level + 1
	if next_level <= max_level:
		PlayerVariables.player_level += 1
		goto_scene("res://scenes/level_"+str(next_level)+".tscn")
	else:
		go_to_main_menu()
		
func go_to_current_level():
	goto_scene("res://scenes/level_"+str(PlayerVariables.player_level)+".tscn")
	
func go_to_main_menu():
	goto_scene("res://scenes/menu.tscn")
