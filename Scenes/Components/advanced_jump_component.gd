class_name AdvancedJumpComponent #a more detailed jump for the player character
extends Node

@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer #creates an inspector box for connecting the timer
@export var coyote_timer: Timer #same

@export_subgroup("Settings") 
@export var jump_velocity: float = -350.0 #the force with which to jump

var is_going_up: bool = false #begins by assuming not currently going up
var is_jumping: bool = false
var last_frame_on_floor: bool = false

func has_just_landed(body: CharacterBody2D) -> bool: #a function called just below
	return body.is_on_floor() and not last_frame_on_floor and is_jumping #checks when just finished a jump

func is_allowed_to_jump(body: CharacterBody2D, want_to_jump: bool) -> bool: #called below
	return want_to_jump and (body.is_on_floor() or not coyote_timer.is_stopped()) #jump input received while ono floor and coyote time is running

func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void: #the function the player calls, passing the beginning and end of the jump input
	if has_just_landed(body): #differed from source here, come back and check if error
		is_jumping = false #right after landing sets this variable to false with the above function
	
	if is_allowed_to_jump(body, want_to_jump): #if jump is pressed/allowed to be pressed and body is currently on the floor and coyote time is running
		jump(body) #do the function below
		
	handle_coyote_time(body) #calls the below function to check first if in coyote time
	handle_jump_buffer(body, want_to_jump) #then checks the buffer in the below function before continuing into checking the inpu
	handle_variable_jump_height(body, jump_released) # finally checks whether jump is still being pressed via the below function
		
	is_going_up = body.velocity.y < 0 and not body.is_on_floor() #resets this bool if body is moving upwards while not on a platform
	last_frame_on_floor = body.is_on_floor() #checks if on floor at the end of the frame for the above functions on the next frame
	
func has_just_stepped_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and last_frame_on_floor and not is_jumping #checks that it isn't on floor but was recently and isn't currently jumping already

func handle_coyote_time(body: CharacterBody2D) -> void: #the coyote time function
	if has_just_stepped_off_ledge(body): #calls the above function
		coyote_timer.start() #starts if just stepped off ledge
		
	if not coyote_timer.is_stopped() and not is_jumping: #checks if the timer has stopped and still not jumping
		body.velocity.y = 0 #player remains in the air for a moment just off the ledge rather than falling and then jumping
	
func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void: #checks for jump buffering
	if want_to_jump and not body.is_on_floor(): #if jump is pushed/called while not on floor...
		jump_buffer_timer.start() #...start the timer
		
	if body.is_on_floor() and not jump_buffer_timer.is_stopped(): #if body has returned to floor before the end of the timer
		jump(body) #jump if so

func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void: #the function called above
	if jump_released and is_going_up: #if jump button is released and jump isn't over...
		body.velocity.y = 0 #...turn off the increase in the jump, gravity kicks back in
	
func jump(body: CharacterBody2D) -> void: #the actual jump function
	body.velocity.y = jump_velocity #sets velocity to the jump number
	jump_buffer_timer.stop() #stops the timer just in case
	is_jumping = true #finally
	coyote_timer.stop() #just in case
