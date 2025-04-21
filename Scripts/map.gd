extends Node2D

@onready var count: AudioStreamPlayer2D = get_node("Count That Shit")
@onready var cats: Node2D = get_node("Cats")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count.play()


func _on_count_that_shit_finished() -> void:
	for child in cats.get_children():
		child.start()
