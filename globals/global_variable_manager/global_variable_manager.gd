@tool
#class_name NameOfClass
extends Node

## purpose: This Autoload script will manage all global game enums, constants, and variables

# enums ------------------------------------------------------------------------------------------------------------------
enum Menus {empty, main, levels, settings, credits, controls, feedback, leaderboard}

# constants --------------------------------------------------------------------------------------------------------------

# level variables --------------------------------------------------------------------------------------------------------------
var current_level_id: int = 0: set = _set_current_level_id
var min_valid_level_id: int = 0
var max_valid_level_id: int = 1
var max_completed_level_id: int = 0

# menu variables --------------------------------------------------------------------------------------------------------------
var current_menu_id: int = Menus.empty: set = _set_current_menu_id

# version variables --------------------------------------------------------------------------------------------------------------
var version_label:= ""

# set/get functions --------------------------------------------------------------------------------------------------------
func _set_current_level_id(new_val):
	current_level_id = clamp(new_val, min_valid_level_id, max_valid_level_id)
	Signals.current_level_id_changed.emit(current_level_id)


func _set_current_menu_id(new_val):
	current_menu_id = clamp(new_val, 0, Menus.size() - 1)
	Signals.current_menu_id_changed.emit(current_menu_id)
