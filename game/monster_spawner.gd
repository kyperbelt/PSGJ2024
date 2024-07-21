class_name MonsterSpawner
extends Node

@export var _enemy_container: Node
@export var _small_monsters: Array[PackedScene]

# TODO: use a list of possible spawn layouts.
# spawn layouts should be determined by current level
# and generally associated with level of difficulty.
@export var _spawn_layout: Node

var _spawning_enemies: Array[Enemy] = []


func _ready():
	pass


func request_spawn(gm: GameMaster) -> void:
	# TODO:
	# get next spawn layout.
	# spawn a enemy for each spawn marker.
	var spawn_markers = get_spawn_markers(_spawn_layout)

	for marker: Marker in spawn_markers:
		# create enemy
		var enemy := _small_monsters[0].instantiate() as Enemy
		# add enemy to container
		_enemy_container.add_child(enemy)
		# give enemy spawn(position command)
		enemy.spawn(marker.position)
		# add enemy to local spawning enemies list
		_spawning_enemies.append(enemy)
		# connect to its emit signal
		enemy.spawn_entered.connect(self.on_spawn_entered.bind(gm, enemy), CONNECT_ONE_SHOT)


func on_spawn_entered(gm: GameMaster, enemy: Enemy) -> void:
	_spawning_enemies.erase(enemy)
	enemy.use_cooldowns(gm)
	gm.add_enemy(enemy)


func is_spawning() -> bool:
	return _spawning_enemies.size() != 0


func get_spawn_markers(layout: Node) -> Array[Marker]:
	var result: Array[Marker] = []
	for child in layout.get_children():
		if child is Marker:
			result.append(child)
	return result
