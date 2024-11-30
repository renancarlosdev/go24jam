extends Area2D

@export var res: power_resource
@export var res_projectile: projectile_resource

func _ready() -> void:
	%Cooldown.wait_time = res.cooldown

func _physics_process(delta: float) -> void:
	
	var  enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func _shoot():
	const PROJECTILE =  preload("res://Scenes/projectile.tscn")
	
	var new_projectile = PROJECTILE.instantiate()
	
	new_projectile.res = res_projectile#load("res://Resources/basic_projectile.tres")
	
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	
	%ShootingPoint.add_child(new_projectile)

func _on_timer_timeout() -> void:
	for i in res.p_count:
		await get_tree().create_timer(0.05).timeout 
		_shoot()
