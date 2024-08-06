class_name GravityComponent #names it for easy reference in other scripts
extends Node

@export_subgroup("Settings") #creates a collapsible header in the Inspector for filling with variables
@export var gravity: float = 1000.0 #creates an inspector spot for setting gravity in decimals

var is_falling: bool = false #sets a boolean for determining if character is currently falling

func handle_gravity(body: CharacterBody2D, delta: float) -> void: #creates a function and defines its possibl inputs
	if not body.is_on_floor(): #checks whether input body is on floor, a built in funcntion that returns a boolean
		body.velocity.y += gravity * delta #if it isn't on the floor, set it some gravity. times delta for framerate magic or something
		
	is_falling = body.velocity.y > 0 and not body.is_on_floor() #when movement is down and it still hasn't returned to the floor, var becomes true
