#@tool
#class_name NameOfClass
extends Node2D

## purpose: This script will control the loading/unloading of game scenes

# signals ----------------------------------------------------------------------------------------------------------------

# enums ------------------------------------------------------------------------------------------------------------------

# constants --------------------------------------------------------------------------------------------------------------

# variables --------------------------------------------------------------------------------------------------------------
@onready var level_layer = $LevelLayer
@onready var ui_layer = $UILayer
@onready var menu_layer = $MenuLayer

@export_group("Revision Values")
## This revision number indicates a major milestone (ie beta -> release)
@export var version_major: int = 0: set = _set_version_major
## This revision number indicates small feature updates, large bug fixes etc.
@export var version_minor: int = 0: set = _set_version_minor
## This revision number indicates minor alterations to existing features, small bug fixes, etc.
@export var version_revision: int = 0: set = _set_version_revision

@export_group("Scenes")
@export var level_scenes: Array[PackedScene] = []: set = _set_level_scenes
@export var menu_scenes: Array[PackedScene] = []



# built-in functions ---------------------------------------------------------------------------------------------------------
func _ready():
	# connect signals
	Signals.current_level_id_changed.connect(_on_current_level_id_changed)
	Signals.current_menu_id_changed.connect(_on_current_menu_id_changed)
	
	# initialize setgets
	
	# initialize variables
	
	# call functions
	pass


func _process(delta):
	pass


# helper functions --------------------------------------------------------------------------------------------------------
func update_version_label():
	Variables.version_label = "v%s.%s.%s" % [version_major, version_minor, version_revision]


# set/get functions -------------------------------------------------------------------------------------------------------
func _set_version_major(new_val):
	version_major = new_val
	update_version_label()


func _set_version_minor(new_val):
	version_minor = new_val
	update_version_label()


func _set_version_revision(new_val):
	version_revision = new_val
	update_version_label()


func _set_level_scenes(new_val):
	level_scenes = new_val
	Variables.max_valid_level_id = level_scenes.size() - 1


# signal functions --------------------------------------------------------------------------------------------------------
func _on_current_level_id_changed(new_level_id):
	var level_scene_instance = level_scenes[new_level_id].instantiate()
	level_layer.add_child(level_scene_instance)


func _on_current_menu_id_changed(new_menu_id):
	var menu_scene_instance = menu_scenes[new_menu_id].instantiate()
	menu_layer.add_child(menu_scene_instance)
