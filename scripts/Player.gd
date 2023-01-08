extends KinematicBody

# Cooldown time in seconds after moving
export var cooldown = 0.125
# Separation in meters of side lanes from central
export var lane_distance = 4.5
# Catch sound
export(AudioStream) var catch_sound

# Current lane
var lane = 0
# Control flags
var can_catch = true
var can_move = true


func _ready():	
	$CooldownTimer.wait_time = cooldown

func _process(_delta):
	if (not can_move):
		return
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1
	move(direction)
	
func kill():
	can_move = false
	can_catch = false
	queue_free()

func move(direction):
	can_move = false
	lane = clamp(lane + direction, -1, 1)
	translation.x = lane * lane_distance
	$CooldownTimer.start()
	
func _on_CooldownTimer_timeout():
	can_move = true

func _on_PenguinDetector_body_entered(body):
	if body.is_in_group("friend") and can_catch:
		$CatchAudioStreamPlayer.play()
		body.catch()
