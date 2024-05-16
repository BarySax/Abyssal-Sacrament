extends Area2D

var damage = 140
var animation = "AOE"
var radius = 200
var expension_time = 0.45
var circle_shape = preload("res://Ressources/CircleShape.res")
var damaged_targets = []
var origin
# Called when the node enters the scene tree for the first time.
func _ready():
	if origin == "Player":
		damage = 140
		radius = 200
		expension_time = 0.45
		set_collision_mask_value(2, false)
	elif origin == "Enemy":
		damage = 70
		radius = 150
		expension_time = 0.5
		set_collision_mask_value(3, false)
	aoe_attack()
func aoe_attack():
	get_node("AnimationPlayer").play(animation)
	var radius_step = radius / (expension_time / 0.05)
	while get_node("CollisionShape2D").get_shape().radius < radius:
		var shape = circle_shape.duplicate()
		shape.set_radius(get_node("CollisionShape2D").get_shape().radius + radius_step)
		get_node("CollisionShape2D").set_shape(shape)
		var targets = get_overlapping_bodies()
		for target in targets:
			if damaged_targets.has(target):
				continue
			else:
				target.on_hit(damage)
				
		await(get_tree().create_timer(0.05).timeout)
		continue
	queue_free()
