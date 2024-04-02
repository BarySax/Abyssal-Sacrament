extends Label


# Called when the node enters the scene tree for the first time.
@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	set_text(str(player.level))


