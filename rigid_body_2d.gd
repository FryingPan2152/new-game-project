extends RigidBody2D
#double vel for shift

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("foward"):
		var direction = Vector2(cos(rotation),sin(rotation))
		linear_velocity += direction * delta * 150.0 
	if Input.is_action_pressed("back"):
		var direction = Vector2(cos(rotation), sin(rotation))
		linear_velocity -= direction * delta * 150.0 
	if Input.is_action_pressed(("left")):
		var direction = Vector2(cos(rotation), sin(rotation))
		rotation -= 1 * delta
	if Input.is_action_pressed(("right")):
		var direction = Vector2(cos(rotation), sin(rotation))
		rotation += 1 * delta
	if Input.is_action_pressed("brake"):
		linear_velocity -= linear_velocity.limit_length(70) * 1.5 * delta
		print("braking: ", linear_velocity)
	
	
	pass
