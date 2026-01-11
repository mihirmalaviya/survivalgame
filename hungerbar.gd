extends ColorRect

@export var max := 10.
@export var target := 10.
var lerped := target
@export var speed := .05

#signal hunger0
#signal hunger1
#signal hunger2
#signal hunger3
#signal hunger5

@export var vignette_curve : Curve

func _process(_delta: float) -> void:
	var currlevel = int(target)
	
	material.set_shader_parameter("current_value", target/max)
	lerped = lerp(lerped, target, speed)
	material.set_shader_parameter("lerp_value", lerped/max)
	
	$"../CanvasLayer/Postprocessing".material.set_shader_parameter("outerRadius", 2-2.*vignette_curve.sample(1-lerped/max))
	$"../CanvasLayer/Postprocessing".material.set_shader_parameter("MainAlpha", 1.*vignette_curve.sample(1-lerped/max))
	
	#if int(target) != currlevel:
		#match int(target):
			#5:
				#hunger5.emit()
			#3:
				#hunger3.emit()
			#2:
				#hunger2.emit()
			#1:
				#hunger1.emit()
			#0:
				#hunger0.emit()

func set_hunger(val):
	target = val

func add_hunger(val):
	set_hunger(target + val)

func get_hunger():
	return target
