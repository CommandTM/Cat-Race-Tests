extends Area2D

@export var cat_group: String = "1"

@onready var win_text: RichTextLabel = get_node("CanvasLayer/Cat Name")
@onready var win_image: Sprite2D = get_node("CanvasLayer/Win")
@onready var meow: AudioStreamPlayer2D = get_node("Meow")
@onready var timer: Timer = get_node("Timer")
@onready var image_timer: Timer = get_node("Image Timer")
@onready var victory: AudioStreamPlayer2D = get_node("Victory")
@onready var music: AudioStreamPlayer2D = %Music
@onready var cats: Node2D = get_parent().get_node("Cats")

var text_size: int = 0

var image_size: float = 0

var triggered: bool = false

var cat_name: String

var cat_color: String

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("cat") and not triggered:
		triggered = true
		TheWorldIsFrozen.truth = true
		cat_name = body.data['name']
		cat_color = body.data['color']
		win_text.visible = true
		text_size = text_size + 1
		win_text.text = "[color=" + cat_color + "][font_size=" + str(text_size) + "]" + cat_name
		var image = Image.new()
		image.load(body.data['sprites']['win'])
		win_image.texture = ImageTexture.create_from_image(image)
		music.playing = false
		meow.play()


func _on_timer_timeout() -> void:
	text_size = text_size + 1
	win_text.text = "[color=" + cat_color + "][font_size=" + str(text_size) + "]" + cat_name
	if text_size < 150:
		timer.start()
		
func _on_image_timer_timeout() -> void:
	image_size = image_size + 0.02
	win_image.scale = Vector2(image_size, image_size)
	if image_size < 2:
		image_timer.start()
	else:
		timer.start()


func _on_meow_finished() -> void:
	victory.play()
	image_timer.start()


func _on_victory_finished() -> void:
	if not TheWorldIsFrozen.first_cat_won:
		TheWorldIsFrozen.first_cat_won = true
		for cat in cats.get_children():
			if cat.is_in_group(cat_group):
				cat.queue_free()
		TheWorldIsFrozen.truth = false
		music.play()
		queue_free()
