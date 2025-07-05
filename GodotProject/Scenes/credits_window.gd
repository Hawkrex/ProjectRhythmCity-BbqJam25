extends Control

signal exit_credits_window

# emit a signal to the settings script when the exit button is pressed
func _on_exit_button_pressed() -> void:
	exit_credits_window.emit()
