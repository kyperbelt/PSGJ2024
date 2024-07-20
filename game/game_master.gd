extends Node

class_name GameMaster
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


# Called when the node enters the scene tree for the first time.
func _ready():
	self._tick()


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
	_spawner.tick()
	if _enemies.size() == 0:
		_initiate_spawn()
	_player.tick(self)


static func calculate_level_xp(level: int) -> int:
	return floor(BASE_EXP_REQ + SCALE_FACTOR * pow(log(level), EXP))
