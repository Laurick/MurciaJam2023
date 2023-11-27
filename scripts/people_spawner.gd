extends Node2D

@onready var people_scene = load("res://scenes/people.tscn")
@onready var player = $"../player"
@onready var node = $"../people"

var spawn_rate = 1
var health = 1

signal people_spawned(people)

func _on_timer_timeout():
	for spwan in range(spawn_rate):
		var people:Node2D = people_scene.instantiate()
		people.setup(player, health)
		var x
		var y
		if randf()> 0.5:
			x = 0 if randf() > 0.5 else 512
			y = randf_range(0,512)
		else:
			x = randf_range(0,512)
			y = 0 if randf() > 0.5 else 512
			
		var new_position = Vector2(x,y)
		node.add_child(people)
		people.global_position = new_position
		people_spawned.emit(people)

func level_up(level):
	health += 1
	if fmod(level, 5) == 0:
		spawn_rate += 1
	else:
		$Timer.wait_time = max(0, $Timer.wait_time-0.1)
