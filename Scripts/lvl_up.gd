extends Control

var upgrades

@onready var center_container: CenterContainer = $HBoxContainer/CenterContainer
@onready var center_container_2: CenterContainer = $HBoxContainer/CenterContainer2
@onready var center_container_3: CenterContainer = $HBoxContainer/CenterContainer3


@onready var texture_rect1: TextureRect = $HBoxContainer/CenterContainer/NinePatchRect/TextureRect
@onready var texture_rect2: TextureRect = $HBoxContainer/CenterContainer2/NinePatchRect/TextureRect
@onready var texture_rect3: TextureRect = $HBoxContainer/CenterContainer3/NinePatchRect/TextureRect

@onready var title1: Label = $HBoxContainer/CenterContainer/NinePatchRect/Title
@onready var title2: Label = $HBoxContainer/CenterContainer2/NinePatchRect/Title
@onready var title3: Label = $HBoxContainer/CenterContainer3/NinePatchRect/Title

@onready var desc1: Label = $HBoxContainer/CenterContainer/NinePatchRect/Desc
@onready var desc2: Label = $HBoxContainer/CenterContainer2/NinePatchRect/Desc
@onready var desc3: Label = $HBoxContainer/CenterContainer3/NinePatchRect/Desc

signal upgrade_finished(num)


func _ready() -> void:
	pass
	

func fill_upgrades():
	
	var containers = [center_container,center_container_2,center_container_3]
	var textures = [texture_rect1,texture_rect2,texture_rect3]
	var titles = [title1,title2,title3]
	var descs = [desc1,desc2,desc3]
	
	
	var i = 0
	
	for upgrade in upgrades:
		containers[i].show()
		textures[i].texture = load("res://Assets/icon2.svg") #load("res://Assets/upgrades/"+SceneManager.UPGRADE_TYPE.keys()[upgrade.TYPE] +".svg") 
		titles[i].text = SceneManager.UPGRADE_TYPE.keys()[upgrade.type] 
		descs[i].text = upgrade.desc
		i += 1
	pass

func _on_button1_pressed() -> void:
	upgrade_finished.emit(0)
	get_tree().paused = false
	%LvlUp.hide()
	pass # Replace with function body.


func _on_button2_pressed() -> void:
	upgrade_finished.emit(1)
	get_tree().paused = false
	%LvlUp.hide()
	pass # Replace with function body.


func _on_button3_pressed() -> void:
	upgrade_finished.emit(2)
	get_tree().paused = false
	%LvlUp.hide()
	pass # Replace with function body.
