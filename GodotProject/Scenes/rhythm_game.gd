extends Node2D

@onready var target: Node2D = $Target
@onready var conductor: AudioStreamPlayer = $Conductor

@export var songName: String

var beatsBeforeStart: int
var songBpm: int
var notesOnBeat: Array[int]

var note = preload("res://Scenes/RhythmGameControls/Note.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	songName = SongChoice.chosen_song
	load_song_file()
	conductor.initialise(songBpm)
	conductor.stream = load("res://Songs/" + songName + ".mp3")
	conductor.play_with_beat_offset(beatsBeforeStart)

func _on_conductor_beat_signal(position: int) -> void:
	if notesOnBeat.has(position):
		var note_instance = note.instantiate()
		note_instance.global_position = target.global_position
		note_instance.global_position.x += 1920
		note_instance.speed = 1920 / (conductor.secondsPerBeat * beatsBeforeStart)
	
		add_child(note_instance)

func load_song_file():
	var file = FileAccess.open("res://Songs/" + songName + ".cfg", FileAccess.READ)
	songBpm = int(file.get_line())
	beatsBeforeStart = int(file.get_line())
	
	while file.eof_reached() == false:
		notesOnBeat.append(int(file.get_line()))
	notesOnBeat.remove_at(0) # Godot creates a first element that we do not want
