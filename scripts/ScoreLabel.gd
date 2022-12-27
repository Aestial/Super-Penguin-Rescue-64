extends Label

var score = 0

func on_Friend_catched():
	score += 1
	text = "Score: %s" % score
