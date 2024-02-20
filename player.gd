extends Area2D
signal hit

@export var walking_speed = 400 # speed en pixel/sec
@export var running_speed = 1000 # speed en pixel/sec
var speed = walking_speed
var running = false
# Called when the node enters the scene tree for the first time.
func _ready():
<<<<<<< HEAD:player.gd
	pass
=======
	screen_size = get_viewport_rect().size
	#hide()


var velocity = Vector2.ZERO # The player's movement vector.


>>>>>>> 56d16190cffb52c24b3b8d055d502c6e7693ec05:jeu/player.gd
func _process(delta):
	speed = 400
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_just_pressed("run"):
		if running == false:
			running = true
			speed = running_speed
			print(1)
		else:
			running = false
			speed = walking_speed
			print(2)
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
<<<<<<< HEAD:player.gd

=======
	
>>>>>>> 56d16190cffb52c24b3b8d055d502c6e7693ec05:jeu/player.gd
