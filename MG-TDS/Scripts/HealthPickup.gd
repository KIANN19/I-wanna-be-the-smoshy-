extends Area2D

signal pickup

onready var player = get_node("res://Scenes/Player.tscn")

func _on_HealthPickup_body_entered(body):
	if body.name == "Player":
		emit_signal("pickup")
		body.pick_up("HealthPickup")
		queue_free()

