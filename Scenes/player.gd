extends CharacterBody2D


func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%playeranimation.play_walk_animation()
	else:
		%playeranimation.play_idle_animation()
		
