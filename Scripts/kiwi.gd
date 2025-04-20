extends Area2D

@onready var win_text: RichTextLabel = get_node("CanvasLayer/Cat Name")
@onready var timer: Timer = get_node("Timer")

var text_size: int = 0

var triggered: bool = false

var cat_name: String

var cat_color: String

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("cat") and not triggered:
		triggered = true
		cat_name = body.data['name']
		cat_color = body.data['color']
		win_text.visible = true
		text_size = text_size + 1
		win_text.text = "[color=" + cat_color + "][font_size=" + str(text_size) + "]" + cat_name
		timer.start()


func _on_timer_timeout() -> void:
	text_size = text_size + 1
	win_text.text = "[color=" + cat_color + "][font_size=" + str(text_size) + "]" + cat_name
	if text_size < 75:
		timer.start()
	
