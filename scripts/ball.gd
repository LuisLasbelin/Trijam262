extends RigidBody2D


@export var MAX_LENGTH : int = 50
@export var line_gradient : Gradient
@export var line_width : Curve
@export var points_prefab : PackedScene
var trail : Line2D
var time_since_last_hit : float = 0.0


func _ready():
	trail = Line2D.new()
	trail.gradient = line_gradient
	trail.width_curve = line_width
	get_parent().add_child.call_deferred(trail)
	self.freeze = true


func unfreeze():
	self.freeze = false


func _process(delta):
	var queue : Array = trail.points
	var point_pos = self.position
	queue.append(point_pos)
	
	if queue.size() > MAX_LENGTH:
		queue.remove_at(0)
	
	trail.points = queue
	
	# Calculate time since last hit
	time_since_last_hit += delta


func _on_body_entered(body):
	var points_added = GameManager.add_points(1+ceil(time_since_last_hit*100))
	time_since_last_hit = 0
	#Spawn numbers to show the added points
	var p = points_prefab.instantiate()
	p.points = points_added
	p.global_position = self.global_position
	get_parent().add_child(p)
	# If the block is a power block, add force
	if body.is_in_group("power"):
		self.linear_velocity = self.linear_velocity * 1.2
	# Make sound
	$Bling.play()


func _on_visible_on_screen_notifier_2d_screen_exited():
	get_tree().get_first_node_in_group("level_manager").visible_balls -= 1
