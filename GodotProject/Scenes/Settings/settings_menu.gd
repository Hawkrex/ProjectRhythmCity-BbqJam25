extends Control

signal exit_settings_menu

# emit a signal to the settings script when the exit button is pressed
func _on_exit_button_pressed() -> void:
	exit_settings_menu.emit()
