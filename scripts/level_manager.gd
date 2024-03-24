extends Node2D


var level_edit : bool = true
@export var level_time : float = 15
@onready var timer : Timer = $Timer
var visible_balls : int = 0


func _ready():
	GameManager.set_score()


func _unhandled_input(event):
	if event.is_action_pressed("start"):
		if level_edit:
			level_edit = false
			start_level()
		else:
			get_tree().change_scene_to_file("res://scenes/map_1.tscn")


func start_level():
	var balls = get_tree().get_nodes_in_group("ball")
	for ball in balls:
		visible_balls += 1
		ball.unfreeze()
	# Start timeout
	timer.wait_time = level_time
	timer.connect("timeout", end_level)
	timer.start()
	# Hide tutorial
	%Tutorial.hide()


func _process(delta):
	if level_edit:
		%TimeLeft.text = str(level_time)
	else:
		%TimeLeft.text = str(snapped(timer.time_left, 1))
		if visible_balls <= 0:
			end_level()


func end_level():
	timer.stop()
	var balls = get_tree().get_nodes_in_group("ball")
	for ball in balls:
		ball.freeze = true
	GameManager.set_score()
