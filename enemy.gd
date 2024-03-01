extends CharacterBody2D
@export var speed = 300
@export var attack_range = 66.6
@export var see_range = 300
@export var hp = 100
var player_position
var target_position
var player_seen = false
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var player = get_parent().get_node("Player")
var enemy_rotation
var enemy_direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if hp <= 0:
		queue_free()
	player_position = player.position
	target_position = (player_position - position).normalized()
	if position.distance_to(player_position) < see_range:
		player_seen = true
	if player_seen == true:
		if position.distance_to(player_position) <= attack_range:
			player.hp -= 0.1
		else:
			velocity = target_position * speed 
			position += velocity * delta
			animationState.travel("Walk")
	else:
		animationState.travel("idle")
	enemy_rotation = get_node("Enemy_rotation").get_rotation()
	enemy_rotation = rad_to_deg(enemy_rotation)
	if enemy_rotation <= -360:
		get_node("Enemy_rotation").set_rotation(0)
	elif enemy_rotation >= 360:
		get_node("Enemy_rotation").set_rotation(0)
	enemy_rotation = int(round(enemy_rotation))
	if enemy_rotation <= 22 and enemy_rotation >= -22:
		enemy_direction = Vector2(1,0)
	elif enemy_rotation <= 67 and enemy_rotation >= 23:
		enemy_direction = "Down_Right"
	elif enemy_rotation <= 112  and enemy_rotation >= 68:
		enemy_direction = Vector2(0,1)
	elif enemy_rotation <= 157  and enemy_rotation >= 113:
		enemy_direction = "Down_Left"
	elif enemy_rotation <= 202  and enemy_rotation >= 158:
		enemy_direction = Vector2(-1,0)
	elif enemy_rotation <= 247  and enemy_rotation >= 203:
		enemy_direction = "Up_Left"
	elif enemy_rotation <= 292  and enemy_rotation >= 248:
		enemy_direction = Vector2(0,-1)
	elif enemy_rotation <= 337  and enemy_rotation >= 293:
		enemy_direction = "Up_Right"
	elif enemy_rotation >= -67 and enemy_rotation <= -23:
		enemy_direction = "Up_Right"
	elif enemy_rotation >= -112  and enemy_rotation <= -68:
		enemy_direction = Vector2(0,-1)
	elif enemy_rotation >= -157  and enemy_rotation <= -113:
		enemy_direction = "Up_Left"
	elif enemy_rotation >= -202  and enemy_rotation <= -158:
		enemy_direction = Vector2(-1,0)
	elif enemy_rotation >= -247  and enemy_rotation <= -203:
		enemy_direction = "Down_Left"
	elif enemy_rotation >= -292  and enemy_rotation <= -248:
		enemy_direction = Vector2(0,1)
	elif enemy_rotation >= -337  and enemy_rotation <= -293:
		enemy_direction = "Down_Right"	
	animationTree.set("parameters/idle/blend_position", enemy_direction)
	animationTree.set("parameters/Walk/blend_position", enemy_direction)
	
	move_and_slide()
	
func _on_hurt_box_area_entered(area):
	hp -= 50
