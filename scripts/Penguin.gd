extends RigidBody

# Emmited when the player catches the friend
signal catched
# Emmited when the friend touches the ground and dies
signal died

export(AudioStream) var die_sound

func initialize(start_position):
	translate(start_position)

func catch():
	emit_signal("catched")
	queue_free()
	
func die():
	$DieAudioStreamPlayer.play()
	emit_signal("died")

func _on_VisibilityNotifier_screen_exited():
	queue_free()
