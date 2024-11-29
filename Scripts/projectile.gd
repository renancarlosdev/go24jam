extends Area2D

var traveled_distance = 0
@export var res: projectile_resource

func _ready() -> void:
	$Sprite2D.texture = res.texture

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * delta * res.speed
	
	traveled_distance += res.speed * delta
	
	if traveled_distance > res.range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	
	#if !res.bounce TODO
	queue_free()
	
	if body.has_method("take_damage"):
		body.take_damage(res.damage)
