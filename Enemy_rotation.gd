extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")

var player_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_hp = player.hp
	if player.hp > 0:
		player_position = player.position
		look_at(player_position)
