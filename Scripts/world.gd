#World.gd
extends Node2D

@export var enemy_path = preload("res://Models/enemy.tscn")
@export var spawn_interval = 1.0

var time_since_last_spawn = 0.0

func _ready():
	randomize()  # Inicializa o gerador de números aleatórios

func _process(delta):
	time_since_last_spawn += delta
	if time_since_last_spawn >= spawn_interval:
		spawn_enemy()
		time_since_last_spawn = 0.0

func spawn_enemy():
	var enemy = enemy_path.instantiate()
	var edge = randi() % 4
	var pos = Vector2()

	if edge == 0:  # Borda superior
		pos.x = randf_range(0, 1920)
		pos.y = 0
	elif edge == 1:  # Borda direita
		pos.x = 1920
		pos.y = randf_range(0, 1080)
	elif edge == 2:  # Borda inferior
		pos.x = randf_range(0, 1920)
		pos.y = 1080
	else:  # Borda esquerda
		pos.x = 0
		pos.y = randf_range(0, 1080)

	enemy.position = pos # Define a posição do inimigo
	add_child(enemy)
