extends Node2D

@onready var player: CharacterBody2D = $Player
#@onready var lvl_up: Control = $CanvasLayer/LvlUp

var upgrades

func _ready() -> void:
	player.killed.connect(_on_player_killed)
	player.leveled_up.connect(_on_player_leveled_up)
	%LvlUp.upgrade_finished.connect(_on_upgrade_finished)

func _spawn_mob():
	const MOB = preload("res://Scenes/mob.tscn")
	var new_mob = MOB.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_player_killed():
	print("dead")
	pass


func _on_mob_timer_timeout() -> void:
	_spawn_mob()

func _on_upgrade_finished(num):
	var power = player.get_node("Power")
	
	match upgrades[num].type:
		SceneManager.UPGRADE_TYPE.COOLDOWN:
			power.res.cooldown = (power.res.cooldown  * upgrades[num].boost) / 100
		SceneManager.UPGRADE_TYPE.COUNT:
			power.res.p_count += upgrades[num].boost
		SceneManager.UPGRADE_TYPE.DAMAGE:
			power.res_projectile.damage += upgrades[num].boost
		SceneManager.UPGRADE_TYPE.SPEED:
			power.res_projectile.speed += upgrades[num].boost
	
	#print(power.res_projectile.speed)

func _on_player_leveled_up():
	
	
	var upgrade1 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	var upgrade2 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	var upgrade3 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	
	upgrades = []
	upgrades.append(upgrade1)
	upgrades.append(upgrade2)
	upgrades.append(upgrade3)
	
	%LvlUp.upgrades = upgrades
	%LvlUp.fill_upgrades()
	get_tree().paused = true
	%LvlUp.show()
