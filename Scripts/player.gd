extends CharacterBody2D

@export var speed = 100
@export var health = 100
@export var damage = 10
@export var max_inertia = 20 
@export var deceleration = 0.01 
var target_velocity = Vector2()
var inertia = Vector2()
const bulletPath= preload("res://Models/bullet.tscn")
func get_input():
	if health <= 0:
		return
	look_at(get_global_mouse_position())
	target_velocity = transform.x * Input.get_axis("down", "up") * speed
	if target_velocity.length() > 0:
		inertia = target_velocity
	else:
		if inertia.length() > max_inertia:
			inertia = inertia.normalized() * max_inertia
		inertia = inertia.lerp(Vector2.ZERO, deceleration)
func shoot():
	if health <= 0:
		return
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $ShootPoint.global_position 
func _process(_delta):
	if health <= 0:
		return
	if Input.is_action_pressed("fire"):
		shoot()
func _physics_process(_delta):
	get_input()
	velocity = inertia
	move_and_slide()


