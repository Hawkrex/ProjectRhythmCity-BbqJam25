extends Control

@onready var settings_menu = get_tree().current_scene.get_node("settings_menu")
@onready var credits_window = get_tree().current_scene.get_node("credits_window")

func _ready() -> void:
	settings_menu.set_process(false)
	
func _process(delta: float) -> void:
	if $MarginContainer.visible == false :
		if credits_window.visible == true :
			if Input.is_action_just_pressed("ui_cancel"):
				$MarginContainer.visible = true
				credits_window.visible = false
	elif $MarginContainer.visible == true:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
			

# if start button is pressed, get into the game
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/RhythmGame.tscn")

# if settings button pressed, open the settings window
func _on_settings_button_pressed() -> void:
	$MarginContainer.visible =  false
	settings_menu.visible = true
	settings_menu.set_process(true)
	
# exit settings menu when exit button is pressed (the signal is sent by the settings menu script)
func _on_settings_menu_exit_settings_menu() -> void:
	$MarginContainer.visible =  true
	settings_menu.visible = false
	settings_menu.set_process(false)
	
func _on_credits_button_pressed() -> void:
	$MarginContainer.visible =  false
	credits_window.visible = true
	
func _on_credits_window_exit_credits_window() -> void:
	$MarginContainer.visible =  true
	credits_window.visible = false
	
# if quit button pressed, quit the game
func _on_quit_button_pressed() -> void:
	get_tree().quit()
