extends Node

var points : int = 0
var bonus_multiplayer : float = 1.0
var highscore : int = 0

func add_points(p : int) -> int:
	var points_added = roundi(p * bonus_multiplayer)
	self.points += points_added
	# Change label with new points
	get_tree().get_first_node_in_group("score").text = str(self.points)
	return points_added


func set_score():
	if points > highscore: highscore = points
	get_tree().get_first_node_in_group("highscore").text = str(self.highscore)
	points = 0
