extends Area2D

signal speed_up

@export var speed_increase = 100

func _ready():
	connect("body_entered", Callable(self, "_on_SpeedUP_body_entered"))

func _on_SpeedUP_body_entered(body):
	# Se o corpo que entrou em contato com o SpeedUP for o jogador
	if body.name == "Player":
		emit_signal("speed_up", speed_increase)
		queue_free()
