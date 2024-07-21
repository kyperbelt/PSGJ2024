@tool
class_name Marker
extends Area2D

@export var _name: String = "Marker":
	set(value):
		_name = value
		if _markerLabel:
			_markerLabel.text = _name
	get:
		return _name

@export var _markerColor: Color = Color(0.0, 0.0, 0.0, 0.5):
	set(value):
		_markerColor = value
		if _markerShape:
			_markerShape.debug_color = _markerColor
	get:
		return _markerColor

@export_range(10, 300) var _markerWidth: int = 64:
	set(value):
		_markerWidth = value
		if !_markerShape:
			return
		var rect := _markerShape.shape as RectangleShape2D
		rect.size.x = _markerWidth
	get:
		return _markerWidth

@export_range(10, 300) var _markerHeight: int = 64:
	set(value):
		_markerHeight = value
		if !_markerShape:
			return
		var rect := _markerShape.shape as RectangleShape2D
		rect.size.y = _markerHeight
		_markerLabel.position = Vector2(0, -_markerHeight / 2.0)
	get:
		return _markerHeight

var _markerShape: CollisionShape2D
var _markerLabel: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	if _markerShape == null:
		_markerShape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.size.x = _markerWidth
		shape.size.y = _markerHeight
		_markerShape.shape = shape
		_markerShape.debug_color = _markerColor
		add_child(_markerShape, false, INTERNAL_MODE_FRONT)

	if _markerLabel == null:
		_markerLabel = RichTextLabel.new()
		_markerLabel.size = Vector2(300, 80)
		_markerLabel.text = _name
		_markerLabel.set("theme_override_colors/font_outline_color", Color.BLACK)
		_markerLabel.set("theme_override_constants/outline_size", 4)
		_markerLabel.position = Vector2(0, -_markerHeight / 2.0)
		if !Engine.is_editor_hint():
			_markerLabel.visible = get_tree().debug_collisions_hint
		add_child(_markerLabel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
