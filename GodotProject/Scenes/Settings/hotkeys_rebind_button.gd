extends Control

@onready var label = $HBoxContainer/Label
@onready var button = $HBoxContainer/Button

# /!\ THE NAME HAVE TO MATCH THE NAME OF THE ACTION IN THE KEYBINDINGS
@export var action_name : String = "play_music"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_keys()

# set the label's name based on the data given 
func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"open_menu":
			label.text = "Open menu"
		"NoteInput":
			label.text = "Play music"
			

# get the name of the keys in the OS to put them in the buttons
func set_text_for_keys() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode

# change the text when the button is pressed
func _on_button_toggled(button_pressed) -> void:
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_keys()

func _unhandled_key_input(event) -> void:
	rebind_action_key(event)
	button.button_pressed = false

# rebind action key
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_keys()
	set_action_name()
