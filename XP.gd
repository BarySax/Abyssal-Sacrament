extends ProgressBar

@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if value != player.xp * 100 / player.max_xp:
		if value <= player.xp * 100 / player.max_xp:
			value += 2.5
		else:
			value -= 2.5
