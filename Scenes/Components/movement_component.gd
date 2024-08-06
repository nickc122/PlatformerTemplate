class_name MovementComponent
extends Node

@export_subgroup("Settings") #puts it in the growing category for my player's inspector
@export var speed: float = 100 #creates a variable for speed
@export var ground_accel_speed: float = 6.0 
@export var ground_decel_speed: float = 6.0
@export var air_accel_speed: float = 10.0
@export var air_decel_speed: float = 3.0

func handle_horizontal_movment(body: CharacterBody2D, direction: float) -> void: #creates a function to handle movement on the x axis
	var velocity_change_speed: float = 0.0 #the accel/decel speed
	if body.is_on_floor(): #checks if in the air or not
		velocity_change_speed = ground_accel_speed if direction != 0 else ground_decel_speed #sets the acc/dec speed for use below by choosing from those variables
	else:
		velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed #same for when jumping
	
	body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed) #starts at current velocity, move towards total speed, by an increment of acc/dec speed
