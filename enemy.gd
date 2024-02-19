extends Area2D
@export var speed = 300
var player_position
var target_position
@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = target_position * speed
		position += velocity * delta
