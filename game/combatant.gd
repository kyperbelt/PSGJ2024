class_name Combatant
extends Node2D

## The attack interval for this combatants in ticks
## For example: if the _atack interval is set to 100 then the 
## combatant will only attack every 100 ticks
## @see GameMaster to for how to adjust _tick_rate
@export var _attack_interval := 100
@export var _attacks :Array[Attack] = []

var auto_attack : Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	if (auto_attack == null): 
		auto_attack = _attacks[0]

func tick(gm : GameMaster)->void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
