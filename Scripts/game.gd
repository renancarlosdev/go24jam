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
	SceneManager.load_scene("main_menu")
	#player.get_node("AnimatedSprite2D").play("killed")
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
		SceneManager.UPGRADE_TYPE.HEARING:
			SceneManager.hearing = true
			AudioServer.remove_bus_effect(1, 0)
		SceneManager.UPGRADE_TYPE.VISION:
			SceneManager.vision = true
			%PlayerLight.texture.width = 850
			%PlayerLight.texture.height = 850
	
	#print(power.res_projectile.speed)

func _on_player_leveled_up():
	
	SceneManager.player_lvl += 1	
	%PlayerLevelLabel.text = "LEVEL " + str(SceneManager.player_lvl)
	
	var localUpgradeTypeArray = SceneManager.UPGRADE_TYPE.keys()
	
	if(SceneManager.hearing):
		localUpgradeTypeArray.erase("HEARING")
	if(SceneManager.vision):
		localUpgradeTypeArray.erase("VISION")
	
	var choice1 = localUpgradeTypeArray.pick_random()
	var x_position = localUpgradeTypeArray.find(choice1)
	localUpgradeTypeArray.erase(choice1)
	
	var choice2 = localUpgradeTypeArray.pick_random()
	x_position = localUpgradeTypeArray.find(choice2)
	localUpgradeTypeArray.erase(choice2)
	
	var choice3 = localUpgradeTypeArray.pick_random()
	x_position = localUpgradeTypeArray.find(choice3)
	localUpgradeTypeArray.erase(choice3)
	
	var upgrade1 = load("res://Resources/upgrades/"+choice1.to_lower()+".tres")
	var upgrade2 = load("res://Resources/upgrades/"+choice2.to_lower()+".tres")
	var upgrade3 = load("res://Resources/upgrades/"+choice3.to_lower()+".tres")
	
	
	#var upgrade1 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	#var upgrade2 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	#var upgrade3 = load("res://Resources/upgrades/"+SceneManager.UPGRADE_TYPE.keys().pick_random().to_lower()+".tres")
	#
	upgrades = []
	upgrades.append(upgrade1)
	upgrades.append(upgrade2)
	upgrades.append(upgrade3)
	
	%LvlUp.upgrades = upgrades
	%LvlUp.fill_upgrades()
	get_tree().paused = true
	%LvlUp.show()


func _on_mob_level_up_timer_timeout() -> void:
	if $MobTimer.wait_time >= 0.3:
		$MobTimer.wait_time -= 0.3
	pass # Replace with function body.
