extends RigidBody2D
#double vel for shift

@onready var camera := $Camera2D

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("zoom in"):
		camera.zoom += Vector2(1,1) * delta
	if Input.is_action_pressed("zoom out"):
		camera.zoom -= Vector2(1,1) * delta
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
	
	if Input.is_action_pressed("traction"):
		var speed = linear_velocity.length()
		var angle_dif = linear_velocity.angle_to(Vector2.from_angle(rotation))
		if abs(angle_dif) < PI / 4:
			linear_velocity -= linear_velocity * abs(angle_dif) * delta
		#linear_velocity = (linear_velocity.rotated(angle_dif) * delta) + (linear_velocity * (1-delta))
		linear_velocity = (linear_velocity.rotated(angle_dif))
	
	
	pass
