extends Node2D

@onready var bullet_scene = load("res://scenes/lemonade.tscn")
@onready var timer = $Timer
@onready var node = $"../people"

signal shooted
signal reloaded

var lemon_eficiency = 5
var max_lemonades = 10
var lemonades = 10
var power = 1
var speed = 200

func _ready():
	lemonades = max_lemonades
	timer.start()

func _on_timer_timeout():
	if (lemonades > 0):
		lemonades -= 1
		var children = node.get_children()
		if children.is_empty(): return
		var target = children[0]
		look_at(target.position)
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.transform = self.global_transform
		bullet.setup(power, speed)
		shooted.emit(lemonades, max_lemonades)
		timer.start()
		$"/root/Audio".shoot_sound()

func reload():
	lemonades = min(lemonades+lemon_eficiency,max_lemonades)
	reloaded.emit(lemonades, max_lemonades)
	
func power_up():
	power = power+1

func storage_up():
	max_lemonades += 10
	lemonades += 10
	reloaded.emit(lemonades, max_lemonades)

func lemonade_speed_up():
	speed*=1.1
	
func lemon_eficiency_up():
	lemon_eficiency += 1

func lemonade_rate_speed_up():
	$Timer.wait_time = max(0, $Timer.wait_time-0.1)
