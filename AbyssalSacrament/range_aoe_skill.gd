extends Area2D

var damage = 180
var animation = "AOE"
var damage_delay_time = 0.3 #pas sur mais je crois que c en raport avec lanim( yen a pas mais quand faudrait chois la valeur)
var remove_delay_time = 3
var origin

# Called when the node enters the scene tree for the first time.
func _ready():
	if origin == "Player":
		damage = 180
		damage_delay_time = 0.3 
		remove_delay_time = 3
		set_collision_mask_value(2, false)
	elif origin == "Enemy":
		damage = 90
		damage_delay_time = 0.3 
		remove_delay_time = 3
		set_collision_mask_value(3, false)
	aoe_attack()
func aoe_attack():
	get_node("AnimationPlayer").play(animation)
	await(get_tree().create_timer(damage_delay_time).timeout)
	var targets = get_overlapping_bodies()
	for target in targets:
		target.on_hit(damage)
	await(get_tree().create_timer(remove_delay_time).timeout)
	self.queue_free()
