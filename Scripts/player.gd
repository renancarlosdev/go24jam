extends CharacterBody2D

var exp = 0
var lvl = 0
var hp = 100.0

signal killed

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%playeranimation.play_walk_animation()
	else:
		%playeranimation.play_idle_animation()
		
	var overlaping_mobs = $%HurtBox.get_overlapping_bodies()
	if overlaping_mobs.size() > 0: 
		for mob in overlaping_mobs:
			hp -=  mob.damage * delta
		%HPProgressBar.value= hp
		
		if hp < 0.0:
			killed.emit()
	
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("get_pulled"):
		body.get_pulled(self)
	
func _on_exp_obtained(points):
	exp += points
	%EXPProgressBar.value = exp
