extends Control


func _on_play_button_pressed() -> void:
	SceneManager.load_scene("main_game_test")
	pass # Replace with function body.

#remove later, add config
func _on_exit_button_pressed() -> void:
	print("exit")
	pass # Replace with function body.
