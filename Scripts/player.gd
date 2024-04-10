# player.gd

extends CharacterBody2D

@export var speed = 100
@export var health = 100
@export var max_inertia = 20 
@export var deceleration = 0.01 
@export var bullet_speed = 600
@export var bullet_damage = 10



var target_velocity = Vector2()
var inertia = Vector2()
var bullet_path = preload("res://Models/bullet.tscn")


func get_input():
	if health <= 0:
		return
	look_at(get_global_mouse_position())
	target_velocity = transform.x * speed
	if Input.is_action_pressed("down"):
		if inertia.length() > max_inertia:
			inertia = inertia.normalized() * max_inertia
	else:
		if target_velocity.length() > 0:
			inertia = target_velocity
		else:
			inertia = inertia.lerp(Vector2.ZERO, deceleration)
	if Input.is_action_just_pressed("fire"):
		shoot()

func shoot():
	if health <= 0:
		return
	var bullet = bullet_path.instantiate()
	bullet.speed = bullet_speed
	bullet.damage = bullet_damage
	var offset = Vector2(speed / float(4), 0).rotated(get_rotation())
	bullet.set_position(get_position() + offset)
	bullet.set_rotation(get_rotation())
	get_parent().add_child(bullet)

func _process(_delta):
	if health <= 0:
		return
	

func _physics_process(_delta):
	get_input()
	velocity = inertia
	move_and_slide()
