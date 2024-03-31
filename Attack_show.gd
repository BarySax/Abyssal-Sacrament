extends ProgressBar

@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_number = player.attack_number
	if player.turning == false:
		player_number = 0
	value = player_number
