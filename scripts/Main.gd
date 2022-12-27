extends Node

export (PackedScene) var friend_scene

var lane_distance
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	rng.randomize()
	$UserInterface/Retry.hide()
	lane_distance = $Player.lane_distance
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_SpawnTimer_timeout():
	var friend = friend_scene.instance()
	var friend_position = $SpawnLocation.transform.origin
	friend_position.x = rng.randi_range(-1, 1) * lane_distance
	friend.initialize(friend_position)
	add_child(friend)
	friend.connect("catched", $UserInterface/ScoreLabel, "on_Friend_catched")
	friend.connect("died", $UserInterface/LifesLabel, "on_Friend_died")

func _on_PenguinDetector_body_entered(body):
	if body.is_in_group("friend"):
		body.die()

func _on_LifesLabel_game_over():
	$Player.kill()
	$SpawnTimer.stop()
	$UserInterface/Retry.show()
