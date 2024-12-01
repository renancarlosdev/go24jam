extends Control


func _on_play_button_pressed() -> void:
	SceneManager.load_scene("survivor_game")
	pass # Replace with function body.

#remove later, add config
func _on_exit_button_pressed() -> void:
	print("exit")
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	$OptionsScreen.show()
	pass # Replace with function body.
