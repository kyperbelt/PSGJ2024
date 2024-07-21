class_name Combatant
extends Node2D

enum CombatantType { Player, Enemy }

@export var _type := CombatantType.Enemy
@export var _level := 1
@export var _attacks: Array[Attack] = []
@export var _base_health: int = 10

@export_group("stats")
@export var _stamina: int = 10
@export var _intelligence: int = 10
@export var _strength: int = 10
@export var _agility: int = 10

var _stats: Dictionary = {}

var _current_health: int

var _auto_attack: Attack


# Called when the node enters the scene tree for the first time.
func _ready():
	self._initiate()


func _initiate() -> void:
	_stats = {"str": _strength, "int": _intelligence, "stm": _stamina, "agi": _agility}
	for i in range(_attacks.size()):
		_attacks[i] = _attacks[i].duplicate()

	if _auto_attack == null:
		_auto_attack = _attacks[0] as Attack

	_current_health = get_max_health()

	print("Combatant %s initiated" % name)


func get_current_health() -> int:
	return _current_health


## get the max health for this combatant
func get_max_health() -> int:
	return _base_health + (_level * max(_stamina / 2.0, 1.0))


func use_cooldowns(gm: GameMaster) -> void:
	print("Using cooldowns %s" % name)
	# auto attack
	_auto_attack.last_used_tick_time = gm.get_tick_time()

	# other attacks
	for attack in _attacks:
		attack.last_used_tick_time = gm.get_tick_time()


func tick(gm: GameMaster) -> void:
	var auto_attack_elapsed: int = gm.get_tick_time() - _auto_attack.last_used_tick_time

	# auto attack
	if auto_attack_elapsed >= _auto_attack.cooldown:
		if _type == CombatantType.Player:
			print("Player is attacking")
		var target := get_target(gm)
		make_attack(gm, target, _auto_attack)


func make_attack(
	gm: GameMaster, target: Combatant, attack: Attack, stats: Dictionary = _stats
) -> void:
	# play an animation and await until its over
	print("Attack %s->%s" % [self.name, target.name])
	target.take_damage(gm, self, attack, _stats)
	attack.last_used_tick_time = gm.get_tick_time()


func get_target(gm: GameMaster) -> Combatant:
	if _type == CombatantType.Player:
		# gets the first enemy on the list
		# TODO: add some variance? maybe let players choose?
		return gm.get_enemies()[0]
	else:
		return gm.get_player()


func take_damage(
	gm: GameMaster, attacker: Combatant, attack: Attack, attacker_stats: Dictionary
) -> void:
	var damage = (
		attack.base_damage
		+ DiceUtils.roll(attack.bonus_damage_dice, attack.bonus_damage_sides).reduce(
			func(accum, number): return accum + number, 0
		)
	)
	var before_damage = _current_health
	_current_health -= damage

	if _type == CombatantType.Player:
		print("Damage: %s from %s to %s " % [damage, attacker.name, self.name])
		print("Health: %s -> %s" % [before_damage, _current_health])
	pass

	if (_current_health <= 0):
		# die
		if _type == CombatantType.Player:
			print("Player died")
			gm.game_over()
		else:
			print("Enemy died")
			gm.remove_enemy(self)


func get_attacks() -> Array[Attack]:
	return _attacks


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
