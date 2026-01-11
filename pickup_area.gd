extends Area2D

var closest_area : Area2D
var closest
var label

func _ready():
	label = get_tree().current_scene.get_node("UI").get_node("ActionLabel")

func _on_area_entered(area: Area2D) -> void:
	update_closest()

func _on_area_exited(area: Area2D) -> void:
	update_closest()

func update_closest():
	var min_distance := INF
	closest_area = null
	closest = null
	
	for area in get_overlapping_areas():
		if area.is_in_group("item"):
			var parent_node = area.get_parent()
			var dist = global_position.distance_to(parent_node.global_position)
			if dist < min_distance:
				min_distance = dist
				closest_area = area
				closest = parent_node
	
	if closest: 
		label.text = "Pick up %s%s%s" % [str(closest.count)+" " if closest.count!=1 else "", closest.info.name, "s" if closest.count!=1 else ""]
	else:
		label.text = ""
