extends AudioStreamPlayer

@onready var start_timer: Timer = $StartTimer

@export var songBPM: int
var beatsBeforeStart: int

var secondsPerBeat: float
var songPosition: float

var songPositionInBeats := 0
var previousSongPositionInBeats := 0

signal beatSignal(position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	secondsPerBeat = 60.0 / songBPM

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if playing:
		# Compensation with Godot audio motor to be very precise
		songPosition = get_playback_position() + AudioServer.get_time_since_last_mix()
		songPosition -= AudioServer.get_output_latency()
		songPositionInBeats = int(floor(songPosition / secondsPerBeat)) + beatsBeforeStart
		_report_beat()

func _report_beat() -> void:
	if previousSongPositionInBeats < songPositionInBeats:
		emit_signal("beatSignal", songPositionInBeats)
		previousSongPositionInBeats = songPositionInBeats

func play_with_beat_offset(beats: int) -> void:
	beatsBeforeStart = beats
	start_timer.wait_time = secondsPerBeat
	start_timer.start()

func _on_start_timer_timeout() -> void:
	songPositionInBeats +=1
	if songPositionInBeats < beatsBeforeStart - 1: # Waiting
		start_timer.start()
	elif songPositionInBeats == beatsBeforeStart - 1: # Just before playing song
		start_timer.wait_time -= (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		start_timer.start()
	else: # We can finally play the song
		play()
		start_timer.stop()
	_report_beat()
