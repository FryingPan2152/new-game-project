extends Area2D
const crates: Array[PackedScene] = [preload("res://crate1.tscn"),preload("res://longcare.tscn")]


func _on_timer_timeout() -> void:
	if not has_overlapping_bodies():
		var new_crate: Node2D = crates.pick_random().instantiate()
		get_parent().add_child(new_crate)
		new_crate.global_position = global_position
