extends StaticBody2D

var player
var move = false
@export var points = 30

signal exp_obtained

func _process(delta: float) -> void:
	if move:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",player.position,0.6).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
		if position.distance_to(player.position) < 70:
			exp_obtained.emit(points)
			#player.exp += 1
			queue_free()
	pass

func get_pulled(body) -> void:
	player = body
	exp_obtained.connect(player._on_exp_obtained)
	move=true
