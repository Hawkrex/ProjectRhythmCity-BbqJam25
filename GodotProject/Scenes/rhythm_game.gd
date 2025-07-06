extends Node2D

@onready var target: Node2D = $Target
@onready var conductor: AudioStreamPlayer = $Conductor

@export var beatsBeforeStart: int

var note = preload("res://Scenes/RhythmGameControls/Note.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	conductor.play_with_beat_offset(beatsBeforeStart)

func _on_conductor_beat_signal(position: int) -> void:
	var note_instance = note.instantiate()
	note_instance.global_position = target.global_position
	note_instance.global_position.x += 1920
	note_instance.speed = 1920 / (conductor.secondsPerBeat * beatsBeforeStart)
	
	add_child(note_instance)
