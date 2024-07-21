extends TextureProgressBar

@export var _combatant: Combatant


# Called when the node enters the scene tree for the first time.
func _ready():
	self.value = (_combatant.get_current_health() / _combatant.get_max_health()) * 100
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.value = (float(_combatant.get_current_health()) / float(_combatant.get_max_health())) * 100.0
	pass
