extends CharacterBody2D

@export_subgroup("Nodes") #creates a category for use in the inspector
@export var gravity_component: GravityComponent #automatically updates if I change the component name or path...
@export var input_component: InputComponent #...and is creating all these as varaibles to use below
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent #calls the unique component created for the player

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta) #calls the gravity component and applies to self, uses it for gravity
	movement_component.handle_horizontal_movment(self, input_component.input_horizontal) #calls the function in the component and applies to self
	animation_component.handle_move_animation(input_component.input_horizontal) #calls the animation component and sends the horizontal input to be used in those functions
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released()) #calls the jump function on self, passing the jump input/release from Inputs Comp
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling) #calls the animations, passing whether or not jumping or falling
	
	move_and_slide() #finalizes movement after setting velocity
