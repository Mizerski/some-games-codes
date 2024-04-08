extends Area2D

@export var bullet_speed = 600

func _physics_process(delta):
	global_position += transform.x * bullet_speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
