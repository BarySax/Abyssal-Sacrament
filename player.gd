extends CharacterBody2D

#region Variables

@export var walking_speed = 20000# speed en pixel/sec
@export var running_speed = 40000 # speed en pixel/sec
@export var stamina = 100
@export var hp = 100
@export var xp = 0
@export var str = 20
@export var weapon_damage = 25
@export var level = 0
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
var damage = str + weapon_damage
var max_stamina = stamina
var max_hp = hp
var dead = false
var max_xp = 50
var stamina_up = false
var speed = walking_speed
var running = false
var turning = false
var attack_rotation
var attack_direction = Vector2.ZERO
var attack_number = 0
var attack_name
var chosen_attack_one = "Attack"
var chosen_attack_two = "Attack"
var chosen_attack_three = "Attack"
var chosen_attack_four = "Attack"
var chosen_attack_five = "Attack"
var old_attack = -1
enum {
	Move,
	Attack,
	Dead,
}
var state = Move
#endregion
func _ready():
	pass
func _physics_process(delta):
	match state:
		Move:
			move_state(delta)
		Attack:
			attack_state(delta)
		Dead:
			dead_state(delta)
	if hp <= 0:
		state = Dead
	if xp >= max_xp:
		leveling()
#region Attack_Input

	if Input.is_action_just_pressed("start_attack"):
		if Input.is_action_just_pressed("action_one"):
			attack_number = 1
		if Input.is_action_just_pressed("action_two"):
			attack_number = 2
		if Input.is_action_just_pressed("action_three"):
			attack_number = 3
		if Input.is_action_just_pressed("action_four"):
			attack_number = 4
		if Input.is_action_just_pressed("action_five"):
			attack_number = 5
		if attack_number != old_attack:
			old_attack = attack_number
			turning = true
		else:
			turning = false
			old_attack = -1
#endregion
	if turning == true:
#region Direction_And_Anim

		attack_rotation = get_node("Attack_rotation").get_rotation()
		attack_rotation = rad_to_deg(attack_rotation)
		if attack_rotation <= -360:
			get_node("Attack_rotation").set_rotation(0)
		elif attack_rotation >= 360:
			get_node("Attack_rotation").set_rotation(0)
		attack_rotation = int(round(attack_rotation))
		if attack_rotation <= 22 and attack_rotation >= -22:
			attack_direction = Vector2(1,0)
		elif attack_rotation <= 67 and attack_rotation >= 23:
			attack_direction = Vector2(0.71,-0.71)
		elif attack_rotation <= 112  and attack_rotation >= 68:
			attack_direction = Vector2(0,1)
		elif attack_rotation <= 157  and attack_rotation >= 113:
			attack_direction = Vector2(-0.71,-0.71)
		elif attack_rotation <= 202  and attack_rotation >= 158:
			attack_direction = Vector2(-1,0)
		elif attack_rotation <= 247  and attack_rotation >= 203:
			attack_direction = Vector2(-0.71,0.71)
		elif attack_rotation <= 292  and attack_rotation >= 248:
			attack_direction = Vector2(0,-1)
		elif attack_rotation <= 337  and attack_rotation >= 293:
			attack_direction = Vector2(0.71,0.71)
		elif attack_rotation >= -67 and attack_rotation <= -23:
			attack_direction = Vector2(0.71,0.71)
		elif attack_rotation >= -112  and attack_rotation <= -68:
			attack_direction = Vector2(0,-1)
		elif attack_rotation >= -157  and attack_rotation <= -113:
			attack_direction = Vector2(-0.71,0.71)
		elif attack_rotation >= -202  and attack_rotation <= -158:
			attack_direction = Vector2(-1,0)
		elif attack_rotation >= -247  and attack_rotation <= -203:
			attack_direction = Vector2(-0.71,-0.71)
		elif attack_rotation >= -292  and attack_rotation <= -248:
			attack_direction = Vector2(0,1)
		elif attack_rotation >= -337  and attack_rotation <= -293:
			attack_direction = Vector2(0.71,-0.71)
		print(attack_direction)
		animationTree.set("parameters/Idle/blend_position", attack_direction)
		animationTree.set("parameters/Attack/blend_position", attack_direction)
		animationTree.set("parameters/Walk/blend_position", attack_direction)
#endregion
		if Input.is_action_just_pressed("attack"):
			state = Attack
	move_and_slide()
func leveling():
	max_hp += 100
	hp = max_hp
	max_stamina += 100
	stamina = max_stamina
	str += 10
	damage = str + weapon_damage
	level += 1
	max_xp = max_xp * 2
	xp = 0
func move_state(delta):		
	if stamina >= max_stamina:
		stamina_up = false
		stamina = max_stamina
	if stamina_up == true:
		stamina += 1
	if Input.is_action_just_pressed("run") and stamina > 0:
		if running == false:
			running = true
			speed = running_speed
			stamina_up = false
		else:
			running = false
			speed = walking_speed
			stamina_up = true
	if running == true:
		if velocity != Vector2.ZERO:
			stamina -= 0.5
			if stamina <= 0:
				running = false
				stamina_up = true
				speed = walking_speed
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * delta * speed 
	else:
		velocity = Vector2.ZERO
		animationState.travel("Idle")
func attack_state(delta):
	if attack_number == 1:
		attack_name = chosen_attack_one
	if attack_number == 2:
		attack_name = chosen_attack_two
	if attack_number == 3:
		attack_name = chosen_attack_three
	if attack_number == 4:
		attack_name = chosen_attack_four
	if attack_number == 5:
		attack_name = chosen_attack_five
	animationState.travel(attack_name)
func continue_attack():
	if Input.is_action_just_pressed("attack"):
		state = Attack
func attack_animation_finished():
	state = Move

func _on_hurt_box_area_entered(area):
	hp -= 20
func dead_state(delta):
	visible = false
	velocity = Vector2.ZERO
