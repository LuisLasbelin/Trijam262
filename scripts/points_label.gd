extends Node2D

var points : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(points)


func delete():
	self.queue_free()
