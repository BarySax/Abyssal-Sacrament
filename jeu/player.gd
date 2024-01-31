extends Area2D
signal hit

@export var speed = 400 # speed en pixel/sec
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	#hide()


var velocity = Vector2.ZERO # The player's movement vector.
var direction = 0


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
		direction = 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
		direction = -1
	if Input.is_action_pressed("jump"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_just_pressed("sword_hit"):
		if direction > 0:
			$Area2D/Sprite.rotation = 58.6
			await get_tree().create_timer(1).timeout
			$Area2D/Sprite.rotation = 38.6
		elif direction < 0:
			$Area2D/Sprite.rotation = -58.6
			await get_tree().create_timer(1).timeout
			$Area2D/Sprite.rotation = -38.6
			
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_left"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = true
		$Area2D/Sprite.position.x = 1
		$Area2D/Sprite.rotation = -36.8
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = false
		$Area2D/Sprite.position.x = -1
		$Area2D/Sprite.rotation = 36.8
		
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
	
