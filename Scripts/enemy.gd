# enemy.gd
extends Area2D

@export var enemy_speed = 100
@export var enemy_health = 100
@export var enemy_max_health = 100
@onready var player = get_node("/root/World/Player")

var speedup_path= preload("res://Models/speed_up.tscn")

func _ready():
	modulate.a = enemy_health / float(enemy_max_health)

func _physics_process(delta):
	if enemy_health <= 0:
		return
	var direction = (player.global_position - global_position).normalized()
	global_position += direction * enemy_speed * delta

func take_damage(damage):
	enemy_health -= damage
	modulate.a = max(0.1, enemy_health / float(enemy_max_health))
	if enemy_health <= 0:
		die()
func die():
	# Com 10% de chance, solte um SpeedUP
	if randf() < 0.5:
		call_deferred("_spawn_speedup")
	queue_free()

func _spawn_speedup():
	var speedup = speedup_path.instantiate()
	speedup.position = position
	get_parent().add_child(speedup)
