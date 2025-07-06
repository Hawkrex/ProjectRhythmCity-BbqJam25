extends Control

@onready var audio_name_label: Label = $HBoxContainer/audio_name_label
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_num_label: Label = $HBoxContainer/audio_num_label

# allow to choose an audio bus to modify
@export_enum("Master", "Music", "SFX") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	set_name_label_text()
	get_bus_name_by_index()
	set_slider_value()

# set the label's name to the bus name
func set_name_label_text() -> void:
	audio_name_label.text = str(bus_name) + " Volume"
	
# set the percentage based on the slider
func set_audio_num_label_text() -> void:
	audio_num_label.text = str(h_slider.value * 100) + "%"

# get the bus name
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

# change audio volume when the slider is moved
func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_label_text()
