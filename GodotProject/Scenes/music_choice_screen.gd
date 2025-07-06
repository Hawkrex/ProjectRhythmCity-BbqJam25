extends Control

const songs_folder_path = "res://Songs/"

@onready var v_box_container : VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

func _ready() -> void:
	find_songs()

func find_songs() -> void:
	var songs = DirAccess.get_files_at(songs_folder_path)
	for song in songs:
		if song.contains(".import") or song.contains(".cfg"):
			pass
		else:
			var button = Button.new()
			button.text = song.replace(".mp3", "").to_upper()
			v_box_container.add_child(button)
			
			button.pressed.connect(func():
				SongChoice.chosen_song = button.text
				get_tree().change_scene_to_file("res://Scenes/RhythmGame.tscn")
			)
