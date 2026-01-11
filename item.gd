extends CharacterBody2D

@export var info: ItemResource
@export var count := 1

var pickup

func _ready():
	pickup = get_tree().current_scene.get_node("Player").get_node("PickupArea")
	$Icon.texture = info.sprite
	update()

func update():
	$TooltipHandler.tooltip_text = """%d %s
%s kg
%s
%s""" % [count, info.name, str(info.weight), "Edible" if info.edible else "Not Edible", info.lore]

func _on_softcollider_area_entered(area: Area2D) -> void:
	if area.is_in_group("item") and area.get_parent().info.name:
		count += area.get_parent().count
		update()
		area.get_parent().free()
		
		pickup.update_closest()
