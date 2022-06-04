extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 4
export var velocity_decay = 6
export var rotation_speed = 0.85

var velocity = Vector3.ZERO

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
func get_input(delta):
	var old_velocity = velocity
	velocity = Vector3.ZERO
	if Input.is_action_pressed("player_forward"):
		velocity = -transform.basis.z * speed
	elif old_velocity.z < 0:
		velocity.z = min(0, old_velocity.z + (velocity_decay * delta))
		print(velocity.z)
	if Input.is_action_pressed("player_backwards"):
		velocity = transform.basis.z * speed
	if Input.is_action_pressed("player_turn_left"):
		rotate_y(rotation_speed * delta)
	if Input.is_action_pressed("player_turn_right"):
		rotate_y(-rotation_speed * delta)
	velocity.y = old_velocity.y
