class_name Player
extends RigidBody2D
#double vel for shift

@onready var camera := $Camera2D
@onready var text := $CanvasLayer/Control/RichTextLabel
@onready var timer:= $Timer
@onready var physray := $PhsGunRay
@onready var physpoint: Node2D = $PhsGunPoint
var currentlyHeldObject: RigidBody2D = null

# TODO: add a hl2 style phys gun using a raycast on the forklift!

func _physics_process(delta: float) -> void:
	
	text.text = "Time left: %d" % timer.time_left
	
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
	
	if Input.is_action_just_pressed("PhysTog"):
		if is_instance_valid(currentlyHeldObject):
			currentlyHeldObject = null
		else:
			if physray.is_colliding():
				var object = physray.get_collider()
				if object is Crate:
					currentlyHeldObject = object
	
	if is_instance_valid(currentlyHeldObject):
		var direction = currentlyHeldObject.global_position.direction_to(physpoint.global_position)
		var mult = physpoint.global_position.distance_to(currentlyHeldObject.global_position) * 30.0
		currentlyHeldObject.apply_force(direction * mult)


func _on_timer_timeout(delta: float) -> void:
	linear_velocity -= linear_velocity.limit_length(0) * 0 * delta
	print("braking: ", linear_velocity)
	pass # Replace with function body.
