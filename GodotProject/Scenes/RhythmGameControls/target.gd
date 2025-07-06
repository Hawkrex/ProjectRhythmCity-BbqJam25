extends Node2D

@export var input := "NoteInput"

var perfect := false
var good := false
var okay := false

var note = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(input):
		if note != null:
			if perfect:
				print("Perfect")
			elif good:
				print("Good")
			elif okay:
				print("Okay")
			note.queue_free()
		else:
			print("miss")

func _on_perfect_body_entered(body: Node2D) -> void:
	perfect = true

func _on_perfect_body_exited(body: Node2D) -> void:
	perfect = false

func _on_good_body_entered(body: Node2D) -> void:
	good = true

func _on_good_body_exited(body: Node2D) -> void:
	good = false

func _on_okay_body_entered(body: Node2D) -> void:
	okay = true
	note = body
	
func _on_okay_body_exited(body: Node2D) -> void:
	okay = false
	note = null
