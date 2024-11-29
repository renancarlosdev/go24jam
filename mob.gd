extends CharacterBody2D

@export var damage = 5.0

@export var health = 10

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()


func take_damage(damage):
	health -= damage
	
	if health <= 0:
		queue_free()
		
		const EXP_TOKEN_SCENE = preload("res://Scenes/exp_token.tscn")		
		var token = EXP_TOKEN_SCENE.instantiate()
		get_parent().add_child(token)
		token.global_position = global_position
		
	
