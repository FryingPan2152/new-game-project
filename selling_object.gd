extends Node2D

@onready var SellArea := $SellArea
@onready var SellComputer := $SellComputer
var money_in_computer: float = 0.0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Interaction"):
		var found_player = false
		for body in SellComputer.get_overlapping_bodies():
			if body is Player:
				found_player = true
		if found_player:
			sell()



func sell():
	var added_money: float = 0.0;
	for body in SellArea.get_overlapping_bodies():
		if body is Crate:
			added_money += body.price
			body.queue_free()
	money_in_computer += added_money
	print(money_in_computer)
