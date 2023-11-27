extends Node2D

signal on_people_refreshed 

@onready var sprite:Sprite2D = $Sprite2D
var atlas_texture_people: AtlasTexture

var need_refresh = 1
var refreshed = 0
var speed = 100
var target_to_reach:Node2D
var pos_delta:Vector2 = Vector2(0.1, 0.1)

func _ready():
	sprite.texture = atlas_texture_people
	$AnimationPlayer.play("walk")
	
func setup(target:Node2D, new_health):
	target_to_reach = target
	var sprite_name = "res://images/people/people%d.tres" % randi_range(1,8)
	atlas_texture_people = load(sprite_name)
	need_refresh = new_health

func _process(delta):
	if target_to_reach != null:
		position = position.move_toward(target_to_reach.position, delta * speed)

func _on_area_2d_area_entered(area):
	if area.name == "lemonade":
		refreshed += area.get_parent().power
		if refreshed >= need_refresh:
			$AnimationPlayer.play("RESET")
			$CPUParticles2D.emitting = false
			$people.queue_free()
			target_to_reach = null
			on_people_refreshed.emit()
			var tween:Tween = create_tween()
			tween.tween_property(self, "scale", Vector2.ZERO, 0.4)
			tween.tween_callback(destroy)
		else:
			$ProgressBar.value = (refreshed*100)/need_refresh
			$ProgressBar.show()

func destroy():
	if randf() < 0.1:
		var coin = load("res://scenes/coin.tscn").instantiate()
		coin.global_position = self.global_position
		get_parent().get_parent().add_child(coin)
	queue_free()
