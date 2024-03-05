extends CharacterBody2D
@export var speed = 300
@export var attack_range = 66.6
@export var see_range = 300
@export var hp = 100
@export var enemy_rotation_spawn = Vector2(0,1)#A user pour definir la rotation de enemy lors du spawn
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

enum {
	Stand,
	Walk,
	Chase,
	Attack,
}
var state = Stand
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
<<<<<<< HEAD
func _physics_process(delta):
	match state:
		Stand:
			stand_state(delta)
		Chase:
			chase_state(delta)
		Attack:
			attack_state(delta)
	if hp <= 0:
		queue_free()
=======
func _process(delta):
	$AnimatedSprite2D.play()
	var velocity = Vector2.ZERO
>>>>>>> main
	player_position = player.position
	target_position = (player_position - position).normalized()
	if position.distance_to(player_position) < see_range:
		state = Chase
	if position.distance_to(player_position) < attack_range:
		state = Attack
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
		enemy_direction = Vector2(1,1)
	elif enemy_rotation <= 112  and enemy_rotation >= 68:
		enemy_direction = Vector2(0,1)
	elif enemy_rotation <= 157  and enemy_rotation >= 113:
		enemy_direction = Vector2(-1,1)
	elif enemy_rotation <= 202  and enemy_rotation >= 158:
		enemy_direction = Vector2(-1,0)
	elif enemy_rotation <= 247  and enemy_rotation >= 203:
		enemy_direction = Vector2(-1,-1)
	elif enemy_rotation <= 292  and enemy_rotation >= 248:
		enemy_direction = Vector2(0,-1)
	elif enemy_rotation <= 337  and enemy_rotation >= 293:
		enemy_direction = Vector2(1,-1)
	elif enemy_rotation >= -67 and enemy_rotation <= -23:
		enemy_direction = Vector2(1,-1)
	elif enemy_rotation >= -112  and enemy_rotation <= -68:
		enemy_direction = Vector2(0,-1)
	elif enemy_rotation >= -157  and enemy_rotation <= -113:
		enemy_direction = Vector2(-1,-1)
	elif enemy_rotation >= -202  and enemy_rotation <= -158:
		enemy_direction = Vector2(-1,0)
	elif enemy_rotation >= -247  and enemy_rotation <= -203:
		enemy_direction = Vector2(-1,1)
	elif enemy_rotation >= -292  and enemy_rotation <= -248:
		enemy_direction = Vector2(0,1)
	elif enemy_rotation >= -337  and enemy_rotation <= -293:
		enemy_direction = Vector2(1,1)
	animationTree.set("parameters/idle/blend_position", enemy_direction)
	animationTree.set("parameters/Walk/blend_position", enemy_direction)
	animationTree.set("parameters/Attack/blend_position", enemy_direction)
	move_and_slide()
func stand_state(delta):
	animationState.travel("idle")
func chase_state(delta):
	var velocity = Vector2.ZERO
	velocity = target_position * speed 
	position += velocity * delta
	animationState.travel("Walk")
func attack_state(delta):
	animationState.travel("Attack")
func attack_animation_finished():
	state = Chase
func _on_hurt_box_area_entered(area):
	hp -= 20
