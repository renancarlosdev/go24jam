extends Node

var scene_instance

var hearing = false
var vision = false

var player_lvl = 1

enum UPGRADE_TYPE {COOLDOWN,DAMAGE,COUNT,SPEED,RANGE,VISION,HEARING}#ADD RANGE

const FADE_TRANSITION = preload("res://Scenes/fade_transition.tscn")

func _ready() -> void:
	#first scene
	scene_instance = get_tree().current_scene
	

func unload_scene():
	if(is_instance_valid(scene_instance)):
		scene_instance.queue_free()
	scene_instance = null
	
func load_scene(scene_name: String):
	
	#Add canvas to bypass camera2D movement
	var canvas = CanvasLayer.new()
	
	#Play fade animation from old scene	
	var fade_screen_instance = FADE_TRANSITION.instantiate()
	
	canvas.add_child(fade_screen_instance)
	
	get_tree().root.add_child(canvas)	
	var AnimationP = fade_screen_instance.get_node("AnimationPlayer")
	AnimationP.play("fade_to_black")
	await AnimationP.animation_finished
	
	unload_scene()
	
	#load new scene
	var scene_path = "res://Scenes/%s.tscn" % scene_name
	var scene_resource = load(scene_path)	
	if(scene_resource):
		scene_instance = scene_resource.instantiate()
	get_tree().root.add_child(scene_instance)
	
	#Play fade animation to new scene
	#await AnimationP.animation_finished
	AnimationP.play("fade_from_black")
	await AnimationP.animation_finished
	canvas.queue_free()#fade_screen_instance.queue_free()
	
	
