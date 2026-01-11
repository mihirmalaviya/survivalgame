extends Area2D

@export var push_strength = 60.0
@export var immovable = false


func _process(delta: float) -> void:
	for body in get_overlapping_areas():
		if body.is_in_group("soft"):
			var dir = (body.global_position - global_position).normalized()

			if not immovable:
				get_parent().global_position -= dir * body.push_strength * delta
			
			#body.get_parent().global_position += dir * push_strength * delta
