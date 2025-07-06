extends CharacterBody2D

var speed = 1
var direction = Vector2.LEFT

func _physics_process(delta: float) -> void:
	var movementVector = direction * speed * delta
	global_position = global_position + movementVector
	
	if global_position.x < 0:
		queue_free()
