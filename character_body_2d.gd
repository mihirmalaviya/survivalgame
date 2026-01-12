extends CharacterBody2D

@export var max_speed := 200.0
@export var sprint_multiplier := 1.8
@export var acceleration := 2000.0
@export var friction := 300.0

@onready var postprocessing := $"../UI/CanvasLayer/Postprocessing"
@onready var hunger := $"../UI/HungerBar"
@onready var camera := $Camera2D

func _physics_process(delta):
	var input_dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	var speed := max_speed
	if Input.is_action_pressed("sprint") and hunger.get_hunger()>0.0 and input_dir != Vector2.ZERO:
		speed *= sprint_multiplier
		hunger.add_hunger(-3.*delta)
		
	if hunger.get_hunger() <= 1.0:
		speed *= .3
		camera.constant_trauma = .3
	elif hunger.get_hunger() <= 5.0:
		speed *= .8
		
	if hunger.get_hunger() == 0:
		camera.constant_trauma = .6

	#if input_dir != Vector2.ZERO:
	input_dir = input_dir.normalized()
	velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
	#else:
	
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	look_at(get_global_mouse_position())
	move_and_slide()

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#for body in $Area2D.get_overlapping_bodies():
			#body.damage()
