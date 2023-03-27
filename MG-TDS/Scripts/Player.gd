extends KinematicBody2D

export var BulletBlood = preload("res://Scenes/BulletBlood.tscn")
onready var animPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var healthbar = $TextureProgress

const PLAYE = "Player"
var movespeed = 300 
var bullet_speed = 800
var fire_rate = 0.15

var hp = 500
var is_dead = false
var is_taking_damage = false
var is_colliding = false

var Attack = preload("res://Scenes/enemy.tscn")
var bullet = preload("res://Scenes/BULLET.tscn")
var HealthPickup = preload("res://Scenes/HealthPickup.tscn")
var can_fire = true

func _ready():
	$Sprite/Slice/Shunt.disabled = true

func _physics_process(delta):
	if is_colliding == true:
		hp -= 1
		emit_signal("hp_changed", hp)
		healthbar.value = hp
		is_taking_damage = true
		if is_taking_damage == true:
			pass
		if hp <= 0:
			is_dead = true
			get_tree().change_scene("res://Scenes/GameOver.tscn")
			
	healthbar.hide()
	if hp < 500:
		healthbar.show()
		
	var motion = Vector2()
	
	if Input.is_action_pressed("Skjut") and can_fire: 
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(get_angle_to(get_global_mouse_position())))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
	if Input.is_action_pressed("Upp"): 
		motion.y -= 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Ner"): 
		motion.y += 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Höger"):  
		motion.x += 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Vänster"): 
		motion.x -= 1
		animPlayer.play("Walk")
		
	if Input.is_action_pressed("Slice"):
		animPlayer.play("Slice")
	
	#else: animPlayer.play("Idle")

	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)

func _on_Slice_body_entered(body):
		if body.is_in_group("Enemy"): 
			var blood = BulletBlood.instance() as Node2D
			blood.position = get_global_position()
			get_parent().add_child(blood)
			body.queue_free()
			

func _on_Area2D_body_entered(body):
	is_colliding = true

func _on_Area2D_body_exited(body):
	is_colliding = false
	
func pick_up(item_name):
	if item_name == "HealthPickup":
			hp += 500
			if hp > 500:
				hp = 500
	elif item_name == "DoubleTap":
		fire_rate = 0.05
		
