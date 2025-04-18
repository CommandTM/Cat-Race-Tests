extends CharacterBody2D

@export var SPEED = 400.0
@export var BOUNCE_RANDOMNESS = PI/6

var direction: Vector2

@onready var spin: Node2D = %Spin
@onready var direction_indicate: Sprite2D = %Direction

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	spin.rotation_degrees = randf_range(0, 360)
	direction = position.direction_to(direction_indicate.global_position)
	print(direction)
	velocity = direction * SPEED
	print(direction)

	
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		direction = velocity / SPEED
		spin.look_at(position+direction)
		spin.rotate(rng.randf_range(-BOUNCE_RANDOMNESS, BOUNCE_RANDOMNESS))
		direction = position.direction_to(direction_indicate.global_position)
		print(direction)
