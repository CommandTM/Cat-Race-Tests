extends FileDialog

func _on_file_selected(path:String) -> void:
	get_tree().change_scene_to_file(path)
	pass # Replace with function body.
