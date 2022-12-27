extends Label

signal game_over

export var lifes = 3

var is_dead = false

func _ready():
	update_text()
	
func update_text():
	text = "Lifes: %s" % lifes

func on_Friend_died():
	# Return if game over
	if (is_dead):
		return
	# Update lifes and text
	lifes -= 1
	update_text()
	# Meeting game over condition
	if (lifes <= 0):
		is_dead = true
		emit_signal("game_over")
		
