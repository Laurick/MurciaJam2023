extends Node2D

class_name Lemonade

var speed = 200
var power = 1

func _physics_process(delta):
	position += transform.x * speed * delta

func setup(new_power, new_speed):
	power = new_power
	speed = new_speed

func _on_timer_timeout():
	queue_free() # Replace with function body.

func _on_lemonade_area_entered(area):
	if area.name == "people":
		$"/root/Audio".hit_sound()
		queue_free()
