extends KinematicBody2D

signal is_colliding
signal is_not_colliding

export var BulletBlood = preload("res://Scenes/BulletBlood.tscn")
export var path_to_player := NodePath()

export(int) var hitpoints = 100
var max_hitpoints = hitpoints

onready var animPlayer = $AnimationPlayer
onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _player := get_node(path_to_player)
onready var _timer: Timer = $Timer
onready var _sprite: Sprite = $Sprite

var _velocity = Vector2.ZERO

func _ready() -> void: 
	_update_pathfinding()
	_timer.connect("timeout", self, "_update_pathfinding")
	
func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	
	var direction := global_position.direction_to(_agent.get_next_location())

	var desired_velocity := direction * 400
	var steering = (desired_velocity - _velocity) * delta * 1
	_velocity += steering

	_velocity = move_and_slide(_velocity)
	animPlayer.play("Run")
	
func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)

func damage(damage_count):
	hitpoints -= damage_count
	$HPBar.set_percent_value_int(float(hitpoints)/max_hitpoints * 100)
	if hitpoints <= 0:
		queue_free()			####


func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullet"): 
		var blood = BulletBlood.instance() as Node2D
		blood.position = get_global_position()
		get_parent().add_child(blood)
		queue_free()
		
func _exit_tree():
	get_tree().current_scene._add_point()
	

func _on_Give_dmg_body_entered(body):
	if body.get("PLAYE") == "Player":
		emit_signal("is_colliding")
	
func _on_Give_dmg_body_exited(body):
	if body.get("PLAYE") == "Player":
		emit_signal("is_not_colliding")
