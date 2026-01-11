extends Area2D

@export var tooltip_text: String = "This is a test tooltip"   # text to show

var tooltip_ui;

func _ready():
	tooltip_ui = get_tree().current_scene.get_node("Tooltip")

func _mouse_enter():
	tooltip_ui.visible = true
	tooltip_ui.text = tooltip_text

func _mouse_exit():
	tooltip_ui.visible = false

func _process(_delta):
	if tooltip_ui and tooltip_ui.visible:
		tooltip_ui.global_position = get_global_mouse_position()
