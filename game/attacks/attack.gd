class_name Attack
extends Resource

enum AttackType { SHADOW, LIGHT, FIRE, FIGHT, WATER, ICE }

## Name of this attack
@export var name: String = "Default";
## The icon for this attack
@export var icon :Texture2D 

## The type of this attack
@export var type = AttackType.FIGHT

## The damage amount guaranteed if this attack lands
@export var base_damage := 1

## the amount of bonus damage dice to roll if attack lands
@export var bonus_damage_dice := 2

## the amount sides that the dice we roll have.
## for example, 6 means we roll a 6 sided die with values 1-6 
@export var bonus_damage_sides := 6

## Cooldown in ticks
@export var cooldown := 100
