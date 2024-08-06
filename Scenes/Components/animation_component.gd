class_name AnimationComponent
extends Node

@export_subgroup("Nodes") #creates a new group in the inspector for specific nodes
@export var sprite: AnimatedSprite2D #a place to choose the sprite

func handle_horizontal_flip(move_direction: float) -> void: #a function for mirroring the sprite when moving left and right
	if move_direction == 0: #if not moving, then...
		return #...just stop. Otherwise continues below.
		
	sprite.flip_h = false if move_direction > 0 else true #a single line statement that sets the flip_h of the sprite as false of x is positive and true if not
	
func handle_move_animation(move_direction: float) -> void: #a function to change the animation when moving
	handle_horizontal_flip(move_direction) #begins by checking if it should be flipped
	
	if move_direction != 0: #if currently moving
		sprite.play("run") #play the run sprite
	else: #otherwise
		sprite.play("idle") #play the idle sprite
		
func handle_jump_animation(is_jumping: bool, is_falling: bool) -> void: #a function to handle jump animations
	if is_jumping: #if currently jumping
		sprite.play("jump")
	elif is_falling: #if not jumping and currently falling
		sprite.play("fall")
