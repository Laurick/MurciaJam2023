extends Node2D

var blink_counter:int = 0

func _on_timer_timeout():
	blink()

func blink():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0, 0.3)
	tween.chain().tween_property($Sprite2D, "modulate:a", 1, 0.1)
	tween.tween_callback(on_tween_finished)

func on_tween_finished():
	if blink_counter == 5:
		queue_free()
		return
	blink_counter+=1
	blink()
	
func _on_coin_area_entered(area):
	if area.name == "pick":
		$"/root/Audio".coin_sound()
		queue_free()
