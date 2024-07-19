@tool
extends MarginContainer

@export 
var progress_bars : Array[TextureProgressBar] = []:
	set(value):
		update_bars(value, self.progress)
		progress_bars = value
	get:
		return progress_bars


@export_range(0.0, 1.0)
var progress := 0.0 :
	set(value):
		for bar in progress_bars: 
			if (!bar): continue
			bar.value = progress * 100
			bar.queue_redraw()
		progress = value
	get: 
		return progress

# Called when the node enters the scene tree for the first time.
func _ready():
	for bar in progress_bars: 
		if (bar == null): continue
		print("updating bar")
		bar.value = progress * 100
		bar.queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Engine.is_editor_hint()):
		return
	pass

@warning_ignore("shadowed_variable")
static func update_bars(bars: Array[TextureProgressBar], progress: float): 
	for bar in bars: 
		if (!bar): continue
		bar.value = progress * 100

