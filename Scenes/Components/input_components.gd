class_name  InputComponent #gives it a class for easy reference elsewhere
extends Node

var input_horizontal: float = 0.0 #creates a horizontal movement variable and sets it to 0

func _process(_delta: float) -> void: #checks for horizontal movement on every "frame"
	input_horizontal = Input.get_axis("move_left", "move_right") #get_axis means that the first one provides a negative number and the second a positive, so here it creates a value for x
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump") #simply checks if jump has been pushed/called

func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump") #checks for the release of the jump button/call
