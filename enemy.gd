extends CharacterBody2D
#region Variables
@export var walk_speed = 300
@export var run_speed = 400
@export var attack_range = 66.6
@export var see_range = 300
@export var hp = 100
var speed = walk_speed
var run_range = see_range/2
var player_position
var target_position
var player_seen = false
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var player = get_parent().get_node("Player")
@onready var enemy_spawn_position = position
var enemy_rotation
var enemy_direction = Vector2.ZERO

enum {
	Stand,
	Walk,
	Chase,
	Attack,
}
var state = Stand

#endregion
func _physics_process(delta):
	match state:
		Stand:
			stand_state(delta)
		Chase:
			chase_state(delta)
		Attack:
			attack_state(delta)
#region Get_Direction_And_Some_Variables
	if hp <= 0:
		queue_free()
		player.xp += 25
	player_position = player.position
	if player.hp > 0: 
		target_position = (player_position - position).normalized()
		enemy_rotation = get_node("Enemy_rotation").get_rotation()
	else:
		target_position = (enemy_spawn_position - position).normalized()
	if position.distance_to(player_position) > run_range:
		speed = run_speed
	else:
		speed = walk_speed
#endregion
#region State
	if position.distance_to(player_position) < see_range:
		state = Chase
	if position.distance_to(player_position) < attack_range:
		if player.hp > 0:
			state = Attack
#endregion
#region Get_Rotation_And_Animation
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
#endregion
	move_and_slide()
func stand_state(delta):
	animationState.travel("idle")
func chase_state(delta):
	var velocity = Vector2.ZERO
	velocity = target_position * speed 
	position += velocity * delta
	animationState.travel("Walk")
	if player.hp < 0:
		velocity = Vector2.ZERO
func attack_state(delta):
	animationState.travel("Attack")
func attack_animation_finished():
	state = Chase
func _on_hurt_box_area_entered(area):
	hp -= player.damage
