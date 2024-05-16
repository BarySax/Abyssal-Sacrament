extends CharacterBody2D
@onready var hp_bar = get_node("hp_bar")
@onready var player = get_parent().get_node("Player")
@export var speed = 120
var max_hp = 800
var current_hp
var percentage_hp
var can_attack = true
var attack_direction
var state = "Attack"
# Called when the node enters the scene tree for the first time.
func _ready():
	current_hp = max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match state:
		"Rest":
			print("ZZZZZZZZZ")
		"Attack":
			if can_attack == true:
				attack()
		"Follow":
			pass
		"Search":
			pass
func attack():
	can_attack = false
	speed = 0
	attack_direction = (get_angle_to(player.get_global_position())/3.14)*180
	get_node("TurnAxis").rotation = get_angle_to(player.get_global_position())
	var skill = load("res://range_single_target_skill.tscn")
	var skill_instance = skill.instantiate()
	skill_instance.rotation = get_angle_to(player.get_global_position())
	skill_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
	skill_instance.origin = "Enemy"
	get_parent().add_child(skill_instance)
	await(get_tree().create_timer(0.6).timeout)
	can_attack = true
	speed = 120
func on_hit(damage):
	current_hp -= damage
	hp_bar_update()
	if current_hp <= 0:
		killed()
func hp_bar_update():
	percentage_hp = int(float(current_hp) / max_hp * 100)
	hp_bar.value = percentage_hp
	if percentage_hp >= 60:
		hp_bar.set_tint_progress("6b0015") #Dark Red
	elif percentage_hp < 60 and percentage_hp >= 25:
		hp_bar.set_tint_progress("610012") #Really Dark Red
	else:
		hp_bar.set_tint_progress("53000e") #Absolutely Dark Red

func killed():
	get_node("CollisionShape2D").set_deferred("disabled", true) #Quand yaurai anim de mort et cadav par terre sa la rejoue pas
	self.hide()
