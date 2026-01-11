extends Label

func _ready():
	visible = false
	set_process(true)

func _process(_delta):
	if visible:
		global_position = get_global_mouse_position()
