extends Control

signal endGame

#Use this func on Main game scene, to allow player to go back to main menu
func show_retry() -> void:
	$NinePatchRect/VBoxContainer/HBoxContainer/RetryButton.show()

func _on_back_button_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	endGame.emit()
	hide()
