extends CharacterBody2D

<<<<<<< HEAD

@export var walking_speed = 20000# speed en pixel/sec
@export var running_speed = 40000 # speed en pixel/sec
@export var stamina = 100
@export var hp = 100
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
var max_stamina = stamina
var max_hp = hp
var dead = false
var stamina_up = false
var speed = walking_speed
var running = false
var turning = false
var attack_rotation
var attack_direction = Vector2.ZERO
enum {
	Move,
	Attack,
}
var state = Move
func _ready():
	pass
func _physics_process(delta):
	match state:
		Move:
			move_state(delta)
		Attack:
			attack_state(delta)
	if hp <= 0:
		queue_free()
	if Input.is_action_just_pressed("action_one"):
		if turning == false:
			turning = true
			print("turning")
		else:
			turning = false
			print("not turning")
	if turning == true:
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
		if Input.is_action_just_pressed("attack"):
			state = Attack
				
	move_and_slide()
func move_state(delta):		
	if stamina != 100:
		print(stamina)
	if stamina >= 100:
		stamina_up = false
		stamina = 100
	if stamina_up == true:
		stamina += 1
	if Input.is_action_just_pressed("run") and stamina > 0:
		if running == false:
			running = true
			speed = running_speed
			stamina_up = false
			print("running")
		else:
			running = false
			speed = walking_speed
			stamina_up = true
			print("not running")
	if running == true:
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
=======
@export var speed = 400 # speed en pixel/sec


var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


var velocity = Vector2.ZERO # The player's movement vector.



func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_just_pressed("run"):
		if not running :
			running = true
			speed = 1000
			print(1)
		else:
			running = false
			speed = 1000
			print(2)
	if not running :
		speed = 400
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1	
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("run"):
		speed = 800

	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
>>>>>>> main
	else:
		velocity = Vector2.ZERO
		animationState.travel("Idle")
func attack_state(delta):
	animationState.travel("Attack")
	
func attack_animation_finished():
	state = Move

<<<<<<< HEAD
func _on_hurt_box_area_entered(area):
	hp -= 20
=======
	
	position += velocity * delta
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk_left"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x > 0
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
>>>>>>> main
