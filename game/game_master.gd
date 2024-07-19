extends Node

class_name GameMaster
const BASE_EXP_REQ : int = 100 
const SCALE_FACTOR : float = 50.0
const EXP : int = 7 

var level: int = 1
var current_experience: int = 0 
var experience_until_next_level: int = BASE_EXP_REQ



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

@warning_ignore("shadowed_variable")
static func calculate_level_xp(level: int)-> int:
	return floor(BASE_EXP_REQ + SCALE_FACTOR * pow(log(level), EXP))

