extends CharacterBody2D
@export var speed = 12500
var max_hp = 800
var current_hp
var can_fire = true
var rate_of_fire = 0.4
var casting = false
var melee = false
var selected_skill
var damage
var attack_direction
# Called when the node enters the scene tree for the first time.
func _ready():
	current_hp = max_hp

func _process(_delta):
	skill_func()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed * delta
	else:
		velocity = Vector2.ZERO
	if casting == true:
		if melee == true:
			get_node("AnimationPlayer").play("Attack")
	move_and_slide()
func skill_func():
	if Input.is_action_pressed("Cast") and can_fire == true:
		can_fire = false
		casting = true #permet de mettre une anim de lancer si true/false
		speed = 0
		attack_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		selected_skill = "Explosion"
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		match selected_skill:
			"Spear":
				var skill = preload("res://range_single_target_skill.tscn")
				var skill_instance = skill.instantiate()
				skill_instance.rotation = get_angle_to(get_global_mouse_position())
				skill_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
				skill_instance.origin = "Player"
				get_parent().add_child(skill_instance)
			"Explosion":
				var skill = preload("res://range_aoe_skill.tscn")
				var skill_instance = skill.instantiate()
				skill_instance.position = get_global_mouse_position()
				skill_instance.origin = "Player"
				get_parent().add_child(skill_instance)
			"SelfExplosion":
				var skill = preload("res://expending_aoe_skill.tscn")
				var skill_instance = skill.instantiate()
				skill_instance.position = get_global_position()
				skill_instance.origin = "Player"
				get_parent().add_child(skill_instance)
			"MeleeAttack":
				melee = true
				damage = 100
		await(get_tree().create_timer(rate_of_fire).timeout)
		can_fire = true
		casting = false
		speed = 12500

func on_hit(damage):
	current_hp -= damage
	if current_hp <= 0:
		killed()
func killed():
	get_node("CollisionShape2D").set_deferred("disabled", true) #Quand yaurai anim de mort et cadav par terre sa la rejoue pas
	queue_free()

func _on_melee_range_body_entered(body):
	if body.is_in_group("Enemies"):
		if ((get_angle_to(body.position)/3.14)*180) <= (attack_direction + 25) and ((get_angle_to(body.position)/3.14)*180) >= (attack_direction - 25):
			body.on_hit(damage)
