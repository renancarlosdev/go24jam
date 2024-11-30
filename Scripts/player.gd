extends CharacterBody2D

var exp = 95
var lvl = 0
var hp = 100.0

signal killed
signal leveled_up

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		$AnimatedSprite2D.play_walking_animation()
	else:
		$AnimatedSprite2D.play_idle_animation()
		
	var overlaping_mobs = $%HurtBox.get_overlapping_bodies()
	if overlaping_mobs.size() > 0: 
		for mob in overlaping_mobs:
			hp -=  mob.damage * delta
		%HPProgressBar.value= hp
		
		if hp < 0.0:
			$AnimatedSprite2D.play_killed_animation()
			killed.emit()
	
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("get_pulled"):
		body.get_pulled(self)
	
func _on_exp_obtained(points):
	exp += points
	%EXPProgressBar.value = exp
	
	if exp >= 100:
		leveled_up.emit()
