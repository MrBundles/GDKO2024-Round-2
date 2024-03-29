#@tool
#class_name NameOfClass
extends RigidBody2D

## purpose: 

# signals ----------------------------------------------------------------------------------------------------------------

# enums ------------------------------------------------------------------------------------------------------------------

# constants --------------------------------------------------------------------------------------------------------------

# variables --------------------------------------------------------------------------------------------------------------
@onready var sampler_instrument: SamplerInstrument = $SamplerInstrument

# built-in functions ---------------------------------------------------------------------------------------------------------
func _ready():
	# connect signals
	
	# initialize setgets
	
	# initialize variables
	
	# call functions
	pass


func _process(delta):
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, 32, Color.WHITE)


# helper functions --------------------------------------------------------------------------------------------------------


# set/get functions -------------------------------------------------------------------------------------------------------


# signal functions --------------------------------------------------------------------------------------------------------
func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("block"):
		print("block detected")
		sampler_instrument.play_note("C", 5, 5)
