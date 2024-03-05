extends Node2D
var mouse_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	mouse_position = get_viewport().get_mouse_position()
	look_at(mouse_position)
