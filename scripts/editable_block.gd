extends StaticBody2D
class_name EditableBlock

var editing : bool = false
var last_mouse_pos : Vector2


func _ready():
	self.connect("input_event", clicked)
	stop_edit()


func clicked(viewport, event: InputEvent, shape):
	if not get_parent().level_edit:
		# Cant edit
		return
	if event.is_action_pressed("click"):
		# Start editing
		%Click.play()
		if !editing: edit()


func _unhandled_input(event):
	if event.is_action_pressed("confirm") or event.is_action_pressed("start"):
		if editing:
			stop_edit()
			%Confirm.play()


func _process(delta):
	if editing:
		self.rotate((get_global_mouse_position().x-last_mouse_pos.x) * 0.01)
		last_mouse_pos = get_global_mouse_position()


func edit():
	editing = true
	if editing:
		$Rotate1.show()
		$Rotate2.show()
		last_mouse_pos = get_global_mouse_position()


func stop_edit():
	editing = false
	$Rotate1.hide()
	$Rotate2.hide()
