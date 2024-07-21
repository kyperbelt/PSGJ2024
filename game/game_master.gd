class_name GameMaster
extends Node

const BASE_EXP_REQ: int = 100
const SCALE_FACTOR: float = 50.0
const EXP: int = 7

## The amount of ticks per second.
@export_range(1, 100) var _tick_rate := 10

@export var _player: Combatant
@export var _spawner: MonsterSpawner

var _level: int = 1
var _current_experience: int = 0
var _experience_until_next_level: int = BASE_EXP_REQ

var _elapsed_since_last_tick := 0.0

var _enemies: Array[Combatant] = []

var _bout = 0

var _tick_time := 0



# Called when the node enters the scene tree for the first time.
func _ready():
	self._tick()
	_tick_time = 0


func _initiate_spawn() -> void:
	_bout += 1
	_spawner.request_spawn(self)


func get_bout() -> int:
	return _bout


func spawn(enemy: Combatant) -> void:
	_enemies.append(enemy)


func process_enemy_defeated(enemy: Combatant) -> void:
	print("Defeated %s" % enemy.name)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tick_time := 1.0 / _tick_rate
	_elapsed_since_last_tick += delta
	if _elapsed_since_last_tick > tick_time:
		_elapsed_since_last_tick = 0.0
		_tick()
	pass


func _tick():
	_tick_time +=1
	if _enemies.size() == 0 && !_spawner.is_spawning():
		_initiate_spawn()

	for enemy: Enemy in _enemies:
		enemy.tick(self)
	_player.tick(self)

## Get the tick time of the game. 
## This is the number of ticks since combat started.
func get_tick_time()->int: 
	return _tick_time


func game_over() -> void:
	print("Game Over")
	pass


func add_enemy(enemy: Enemy) -> void:
	enemy.use_cooldowns(self)
	_enemies.append(enemy)

func remove_enemy(enemy: Enemy) -> void:
	_enemies.erase(enemy)
	enemy.queue_free()

func get_enemies()->Array[Combatant]: 
	return _enemies

func get_player()->Combatant: 
	return _player


static func calculate_level_xp(level: int) -> int:
	return floor(BASE_EXP_REQ + SCALE_FACTOR * pow(log(level), EXP))
