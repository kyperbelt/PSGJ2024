class_name MonsterSpawner
extends Node

@export var _enemy_container: Node
@export var _small_monsters: Array[PackedScene]

# TODO: use a list of possible spawn layouts.
# spawn layouts should be determined by current level
# and generally associated with level of difficulty.
@export var _spawn_layout: Node


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
		# connect to its emit signal
		enemy.spawn_entered.connect(self.on_spawn_entered.bind(gm, enemy), CONNECT_ONE_SHOT)


func on_spawn_entered(gm: GameMaster, enemy: Enemy) -> void:
	gm.add_enemy(enemy)
	pass


func tick() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_spawn_markers(layout: Node) -> Array[Marker]:
	var result: Array[Marker] = []
	for child in layout.get_children():
		if child is Marker:
			result.append(child)
	return result
