extends Area2D

@export var speed = 200
var player_position
var target_position
var screen_size
var velocity = Vector2.ZERO # The player's movement vector.
@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = target_position * speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
			
