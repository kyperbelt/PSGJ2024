class_name Enemy
extends Combatant

signal spawn_entered

var _spawn_position: Vector2
var _spawn_speed: float
var _spawn_entered: bool = false


func _ready():
	_spawn_speed = randf_range(100, 200)
	_spawn_entered = false
	pass


func spawn(spawn_position: Vector2):
	_spawn_position = spawn_position
	var viewport_rect := get_viewport().get_visible_rect()
	global_position.x = viewport_rect.size.x 
	global_position.y = spawn_position.y
	_spawn_entered = false 

func tick(gm : GameMaster)->void:
	print("enemy ticking")
	super.tick(gm)


func _process(delta):
	if !_spawn_entered:
		if global_position.x <= _spawn_position.x:
			_spawn_entered = true
			global_position = _spawn_position
			spawn_entered.emit()
		else:
			global_position.x = global_position.x - _spawn_speed * delta
