extends CharacterBody2D

@export var SPEED = 400.0

var count: int = 10

var direction: Vector2

var rng = RandomNumberGenerator.new()

@onready var text: RichTextLabel = get_node("Num")

func _on_timer_timeout() -> void:
	count = count -1
	if count <= -1:
		visible = false
		pass
	if count > 0:
		text.text = "[font_size=70][center]" + str(count)
	else:
		text.text = "[font_size=50][center]GO!"
	
	
func _ready() -> void:
	direction = Vector2(rng.randf(), rng.randf())
	
	
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	direction = velocity / SPEED
	
