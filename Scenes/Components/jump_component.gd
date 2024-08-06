class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -350 #a spot in the inspector for changing jump values

var is_jumping: bool = false #a var that states whether or not currently jumping

func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void: #a jump function
	if want_to_jump and body.is_on_floor(): #if on ground and wanting to jump
		body.velocity.y = jump_velocity #set jump velocity
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor() #sets var if y velocity is upward and not currently on floor
	
