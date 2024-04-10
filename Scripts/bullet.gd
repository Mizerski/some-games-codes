# Bullet.gd
extends Area2D

@export var speed = 600
@export var damage = 10



func _physics_process(delta):
	global_position += transform.x * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()


func _on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
	queue_free()
