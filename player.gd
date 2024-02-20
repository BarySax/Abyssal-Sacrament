extends Area2D
signal hit

@export var walking_speed = 400 # speed en pixel/sec
@export var running_speed = 1000 # speed en pixel/sec
@export var stamina = 100
var max_stamina = stamina
var speed = walking_speed
var running = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if stamina != 100:
		print(stamina)
	if Input.is_action_just_pressed("run") and stamina > 0:
		if running == false:
			running = true
			speed = running_speed
			print("running")
		else:
			running = false
			speed = walking_speed
			stamina = max_stamina
			print("not running")
	if running == true:
		stamina -= 0.5
		if stamina <= 0:
			running = false
			stamina = max_stamina
			speed = walking_speed
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1	
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1

	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	
	position += velocity * delta
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
