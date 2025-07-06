extends Control

const songs_folder_path = "res://Songs/"

@onready var v_box_container : VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

func find_songs() -> void:
	var songs = DirAccess.get_files_at(songs_folder_path)
	for song in songs:
		var button = Button.new()
		button.text = song.replace(".mp3", "").to_upper().replace("_", " ")
		v_box_container.add_child(button)
