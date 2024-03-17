extends ProgressBar

@onready var player = get_parent().get_parent().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.turning == true:
		value = 1
	else:
		value = 0
