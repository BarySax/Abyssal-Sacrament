extends RigidBody2D
var speed = 400
var life_time = 3
var damage = 90
var origin
# Called when the node enters the scene tree for the first time.
func _ready():
	if origin == "Player":
		speed = 400
		damage = 90
		set_collision_mask_value(2, false)
	elif origin == "Enemy":
		speed = 300
		damage = 45
		set_collision_mask_value(3, false)
	apply_central_impulse(Vector2(speed,0).rotated(rotation)) 
	SelfDestruct()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func SelfDestruct():
	await(get_tree().create_timer(life_time).timeout)
	queue_free()


func _on_body_entered(body):
	get_node("CollisionShape2D").set_deferred("disabled", true)
	if body.is_in_group("Enemies") and origin == "Player":
		body.on_hit(damage)
	elif body.is_in_group("Player") and origin == "Enemy":
		body.on_hit(damage)
	self.hide()
