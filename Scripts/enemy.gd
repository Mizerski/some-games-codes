extends CharacterBody2D

@onready var player = get_node("/root/World/Player")

func _physics_process(_delta):
	var directon = global_position.direction_to(player.global_position)
	velocity = directon * 100.0 
	move_and_slide()
