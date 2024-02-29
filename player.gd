extends CharacterBody2D


@export var walking_speed = 20000# speed en pixel/sec
@export var running_speed = 40000 # speed en pixel/sec
@export var stamina = 100
@export var hp = 100
var max_stamina = stamina
var max_hp = hp
var dead = false
var stamina_up = false
var speed = walking_speed
var running = false
var turning = false
var attack_rotation
var attack_direction = "Right"
func _physics_process(delta):
	if stamina != 100:
		print(stamina)
	if stamina >= 100:
		stamina_up = false
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
		velocity = input_vector * delta * speed 
	else:
		velocity = Vector2.ZERO
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if Input.is_action_just_pressed("action_one"):
		if turning == false:
			turning = true
			print("turning")
		else:
			turning = false
			print("not turning")
	if turning == false:
		if velocity.y < 0 and velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_down_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = velocity.x > 0
		elif velocity.y > 0 and velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_up_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = velocity.x > 0	
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
		elif velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = velocity.x > 0		
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_up"
			#$AnimatedSprite2D.flip_v = velocity.y > 0
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
	else:
		attack_rotation = get_node("Attack_rotation").get_rotation()
		attack_rotation = rad_to_deg(attack_rotation)
		if attack_rotation <= -360:
			get_node("Attack_rotation").set_rotation(0)
		elif attack_rotation >= 360:
			get_node("Attack_rotation").set_rotation(0)
		attack_rotation = int(round(attack_rotation))
		if attack_rotation <= 22 and attack_rotation >= -22:
			$AnimatedSprite2D.animation = "walk_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 1
			attack_direction = "Right"
		elif attack_rotation <= 67 and attack_rotation >= 23:
			$AnimatedSprite2D.animation = "walk_down_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 1
			attack_direction = "Down_Right"
		elif attack_rotation <= 112  and attack_rotation >= 68:
			$AnimatedSprite2D.animation = "walk_down"
			attack_direction = "Down"
		elif attack_rotation <= 157  and attack_rotation >= 113:
			$AnimatedSprite2D.animation = "walk_down_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Down_Left"
		elif attack_rotation <= 202  and attack_rotation >= 158:
			$AnimatedSprite2D.animation = "walk_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Left"
		elif attack_rotation <= 247  and attack_rotation >= 203:
			$AnimatedSprite2D.animation = "walk_up_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Up_Left"
		elif attack_rotation <= 292  and attack_rotation >= 248:
			$AnimatedSprite2D.animation = "walk_up"
			attack_direction = "Up"
		elif attack_rotation <= 337  and attack_rotation >= 293:
			$AnimatedSprite2D.animation = "walk_up_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 1
			attack_direction = "Up_Right"
		elif attack_rotation >= -67 and attack_rotation <= -23:
			$AnimatedSprite2D.animation = "walk_up_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 1
			attack_direction = "Up_Right"
		elif attack_rotation >= -112  and attack_rotation <= -68:
			$AnimatedSprite2D.animation = "walk_up"
			attack_direction = "Up"
		elif attack_rotation >= -157  and attack_rotation <= -113:
			$AnimatedSprite2D.animation = "walk_up_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Up_Left"
		elif attack_rotation >= -202  and attack_rotation <= -158:
			$AnimatedSprite2D.animation = "walk_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Left"
		elif attack_rotation >= -247  and attack_rotation <= -203:
			$AnimatedSprite2D.animation = "walk_down_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 0
			attack_direction = "Down_Left"
		elif attack_rotation >= -292  and attack_rotation <= -248:
			$AnimatedSprite2D.animation = "walk_down"
			attack_direction = "Down"
		elif attack_rotation >= -337  and attack_rotation <= -293:
			$AnimatedSprite2D.animation = "walk_down_left"
			$AnimatedSprite2D.flip_v = false
			# See the note below about boolean assignment.
			$AnimatedSprite2D.flip_h = 1
			attack_direction = "Down_Right"
					
		if Input.is_action_just_pressed("attack"):
					print(attack_direction)
				
	move_and_slide()
	
