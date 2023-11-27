extends CharacterBody2D

@onready var invulnerability_timer = $Timer

var experience = 0
var max_experience = 10
var level = 1
var score = 0
var max_health = 5
var health = max_health

var speed = 200
var friction = 0.5
var acceleration = 0.5
var god_mode = false
var can_move = true

signal player_hitted
signal score_changed
signal fruit_picked
signal exp_gained(exp, total)
signal level_up(level)

func get_input():
	if !can_move: return Vector2.ZERO
	var input = Vector2()
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("walk")
			$CPUParticles2D.emitting = true
	else:
		if $AnimationPlayer.current_animation != "blink":
			$AnimationPlayer.play("RESET")
		$CPUParticles2D.emitting = false
		velocity = lerp(velocity, Vector2.ZERO, friction)
	move_and_slide()


func _on_hitbox_area_entered(area):
	if area.name == "people" and !god_mode:
		$"/root/Audio".hurt_sound()
		health -= 1
		player_hitted.emit(health)
		if health == 0:
			queue_free()
		else:
			start_invulnerability()
			frame_freeze(0.2)


func _on_pick_area_entered(area):
	if area.name == "coin":
		score += 200
		score_changed.emit(score)
	elif area.name == "lemon":
		score += 50
		score_changed.emit(score)
		fruit_picked.emit()

func start_invulnerability():
	god_mode = true
	invulnerability_timer.start(0.6)
	$AnimationPlayer.play("blink")
	
func frame_freeze(duration):
	can_move = false
	Engine.time_scale = 0
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1
	can_move = true

func _on_timer_timeout():
	god_mode = false

func gain_exp(points=1):
	experience += points
	score += 50
	score_changed.emit(score)
	if experience == max_experience:
		experience = 0
		level += 1
		max_experience = level*10
		level_up.emit(level)
		player_hitted.emit(health)
	exp_gained.emit(experience, max_experience)

func health_up():
	max_health = max_health+1
	health = health + 1
	player_hitted.emit(health)

func health_to_max():
	health = max_health
	player_hitted.emit(health)

func speed_up():
	speed *= 1.1
