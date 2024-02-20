extends Area2D
signal hit

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
	else:
		$AnimatedSprite2D.stop()

	
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
