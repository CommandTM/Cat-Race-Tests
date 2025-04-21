extends CharacterBody2D

@export var SPEED = 400.0
@export var BOUNCE_RANDOMNESS = PI/6
@export var JSON_PATH = ''

var direction: Vector2

var json = JSON.new()

var data

var north: Image
var south: Image
var east: Image
var west: Image
var north_east: Image
var north_west: Image
var south_east: Image
var south_west: Image

@onready var spin: Node2D = get_node("Spin")
@onready var direction_indicate: Node2D = get_node("Spin/Direction")
@onready var hitbox: CollisionShape2D = get_node("Hitbox")
@onready var sprite: Sprite2D = get_node("Sprite")
@onready var bounce: AudioStreamPlayer2D = get_node("Bounce")

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	#start()
	data = json.parse_string(FileAccess.open(JSON_PATH, FileAccess.READ).get_as_text())
	create()
	pass


func _physics_process(delta: float) -> void:
	if not TheWorldIsFrozen.truth:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		bounce.play()
		direction = velocity / SPEED
		spin.look_at(position+direction)
		spin.rotate(rng.randf_range(-BOUNCE_RANDOMNESS, BOUNCE_RANDOMNESS))
		direction = position.direction_to(direction_indicate.global_position)
		look()
	
	
func start() -> void:
	spin.rotation_degrees = randf_range(0, 360)
	direction = position.direction_to(direction_indicate.global_position)
	look()
	

func create() -> void:
	hitbox.shape = ResourceLoader.load(data['hitbox'])
	north = Image.new()
	south = Image.new()
	east = Image.new()
	west = Image.new()
	north_east = Image.new()
	north_west = Image.new()
	south_east = Image.new()
	south_west = Image.new()
	north.load(data['sprites']['north'])
	south.load(data['sprites']['south'])
	east.load(data['sprites']['east'])
	west.load(data['sprites']['west'])
	north_east.load(data['sprites']['north_east'])
	north_west.load(data['sprites']['north_west'])
	south_east.load(data['sprites']['south_east'])
	south_west.load(data['sprites']['south_west'])
	sprite.texture = ImageTexture.create_from_image(east)
	pass
	

func look() -> void: 
	var look: Vector2 = direction.round()
	if look.x == 0 and look.y == -1:
		sprite.texture = ImageTexture.create_from_image(north)
		pass
	if look.x == 0 and look.y == 1:
		sprite.texture = ImageTexture.create_from_image(south)
		pass
	if look.x == 1 and look.y == 0:
		sprite.texture = ImageTexture.create_from_image(east)
		pass
	if look.x == -1 and look.y == 0:
		sprite.texture = ImageTexture.create_from_image(west)
		pass
	if look.x == 1 and look.y == -1:
		sprite.texture = ImageTexture.create_from_image(north_east)
		pass
	if look.x == -1 and look.y == -1:
		sprite.texture = ImageTexture.create_from_image(north_west)
		pass
	if look.x == 1 and look.y == 1:
		sprite.texture = ImageTexture.create_from_image(south_east)
		pass
	if look.x == -1 and look.y == 1:
		sprite.texture = ImageTexture.create_from_image(south_west)
		pass
	
	
