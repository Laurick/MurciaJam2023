extends Node2D

@onready var lemon_scene = load("res://scenes/lemon.tscn")
@onready var node = $"../fruits"

func _on_timer_timeout():
	var fruit:Node2D = lemon_scene.instantiate()
	var x = randf_range(22,490)
	var y = randf_range(22,490)
	var new_position = Vector2(x,y)
	node.add_child(fruit)
	fruit.global_position = new_position

func lemon_rate_up():
	$Timer.wait_time = max(0, $Timer.wait_time-0.1)
