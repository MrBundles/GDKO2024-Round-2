#@tool
#class_name name_of_class
extends CharacterBody2D

# purpose: 

# signals ----------------------------------------------------------------------------------------------------------------

# enums ------------------------------------------------------------------------------------------------------------------

# constants --------------------------------------------------------------------------------------------------------------

# variables --------------------------------------------------------------------------------------------------------------
@export_group("movement values")
@export var h_accel = 10.0
@export var h_decel = 10.0
@export var gravity = 10.0
@export var jump = 10.0
@export var h_vel_max = 100.0
@export var v_vel_max = 100.0
var jump_cancel_flag = true

@export_group("color values")
@export var color : Color = Color.WHITE

@export_group("draw values")
var height : float = 64
var delta_height : float = 1
var target_height : float = 64
var width : float = 64
var rest_undulation_mult = 1


# main functions ---------------------------------------------------------------------------------------------------------
func _ready():
	# connect signals
	
	# initialize variables
	
	# call functions
	pass


func _process(delta):
	get_input(delta)
	move_and_slide()
	
	update_squish(delta)
	queue_redraw()

func _draw():
	if not v_vel_max or not h_vel_max: return
	
	# draw head
	var start_angle = deg_to_rad(5)
	var end_angle = deg_to_rad(-185.0)
	draw_arc(Vector2(0, -height * 1.5 + 96), width / 4.0, start_angle, end_angle, 32, color, (width - 4) / 2, true)
	
	# draw body
	draw_rect(Rect2(Vector2(-width / 2, -height * 1.5 + 96), Vector2(width, height * 1.5 - 64)), color, true)
	
	# draw eye
	#var eye_position = Vector2(velocity.x / h_vel_max * 16, 16 - width*.5)
	var eye_position = Vector2(velocity.x / h_vel_max * 16, 64 - height*1.25)
	#draw_circle(eye_position, 16, color)
	draw_circle(eye_position, 8, color.lightened(.6))
	draw_circle(eye_position, 4, color.darkened(.5))


# helper functions --------------------------------------------------------------------------------------------------------
func get_input(delta):
	# process horizontal inputs
	if Input.is_action_pressed("move_left"):
		velocity.x = clamp(velocity.x - h_accel * delta, -h_vel_max, h_vel_max)
	elif Input.is_action_pressed("move_right"):
		velocity.x = clamp(velocity.x + h_accel * delta, -h_vel_max, h_vel_max)
	elif velocity.x < -h_decel * delta:
		velocity.x = clamp(velocity.x + h_decel * delta, -h_vel_max, h_vel_max)
	elif velocity.x > h_decel * delta:
		velocity.x = clamp(velocity.x - h_decel * delta, -h_vel_max, h_vel_max)
	else:
		velocity.x = 0
	
	# process bumps on ceiling
	if is_on_ceiling():
		velocity.y += 1 * delta
	
	# process coyote timer
	if is_on_floor():
		$CoyoteTimer.start()
		velocity.y = 0
		jump_cancel_flag = true
	
	# process jump inputs
	if Input.is_action_pressed("move_up") and not $CoyoteTimer.is_stopped():
		velocity.y = clamp(velocity.y - jump * delta, -v_vel_max, v_vel_max)
		$CoyoteTimer.stop()
	elif Input.is_action_just_released("move_up") and velocity.y < 0 and jump_cancel_flag:
		velocity.y = velocity.y / 2.0
		jump_cancel_flag = false
	else:
		velocity.y = clamp(velocity.y + gravity * delta, -v_vel_max, v_vel_max)


func update_squish(delta):
	# update width and height values
	if is_on_floor():
		if velocity.x == 0:
			rest_undulation_mult = clamp(rest_undulation_mult + 200 * delta, 0, 400)
			target_height = 64 + sin(Time.get_ticks_msec() / 173.0) * rest_undulation_mult * delta
		else:
			target_height = 64 - 12 * abs(velocity.x) / h_vel_max
			rest_undulation_mult = 0
	else:
		target_height = 64 - 24 * velocity.y / v_vel_max
		rest_undulation_mult = 0
	
	delta_height = lerpf(delta_height, (height - target_height) * 0.5, 8 * delta)
	height -= delta_height
	width = 4096 / height


# set/get functions -------------------------------------------------------------------------------------------------------


# signal functions --------------------------------------------------------------------------------------------------------
