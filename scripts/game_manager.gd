extends Node

@onready var player = $Node2D/player
@onready var shooter = $Node2D/shooter
@onready var ui = $Control
@onready var spawner = $Node2D/spawner
@onready var lemon_spawner = $Node2D/lemon_spawner
@onready var game_over = $Control/gameover

func _ready():
	Engine.time_scale = 1
	player.connect("score_changed",ui.score_changed)
	player.connect("player_hitted",ui.life_changed)
	player.connect("player_hitted",game_end)
	player.connect("exp_gained",ui.exp_changed)
	player.connect("level_up",ui.level_changed)
	player.connect("level_up",level_up)
	player.connect("level_up",spawner.level_up)
	player.connect("fruit_picked",shooter.reload)
	shooter.connect("shooted", ui.lemonade_changed)
	shooter.connect("reloaded", ui.lemonade_changed)
	spawner.connect("people_spawned", people_spawned)
	$"/root/Audio".play_music("Comedy")

func game_end(lives):
	if lives == 0:
		$"/root/Audio".gameover_sound()
		Engine.time_scale = 0
		$Control/gameover/VBoxContainer/Label.text = tr("GAME_OVER") % [ui.get_time_played(), player.score, player.level]
		game_over.show()

func people_spawned(people):
	people.connect("on_people_refreshed", player.gain_exp)

func level_up(level):
	$"/root/Audio".level_sound()
	Engine.time_scale = 0
	$Control/Update/VBoxContainer/Label.text = tr("LEVEL_UP") % level
	$Control/Update.show()
	
func level_up_done():
	$Control/Update.hide()
	Engine.time_scale = 1

func _on_health_up_button_up():
	$"/root/Audio".upgrade_sound()
	player.health_up()
	level_up_done()


func _on_power_up_button_up():
	$"/root/Audio".upgrade_sound()
	shooter.power_up()
	level_up_done()


func _on_speed_up_button_up():
	$"/root/Audio".upgrade_sound()
	player.speed_up()
	level_up_done()


func _on_lemon_rate_button_up():
	$"/root/Audio".upgrade_sound()
	lemon_spawner.lemon_rate_up()
	level_up_done()


func _on_lemon_storage_button_up():
	$"/root/Audio".upgrade_sound()
	shooter.storage_up()
	level_up_done()


func _on_lemonade_speed_button_up():
	$"/root/Audio".upgrade_sound()
	shooter.lemonade_speed_up()
	level_up_done()


func _on_lemonade_rate_button_up():
	$"/root/Audio".upgrade_sound()
	shooter.lemonade_rate_speed_up()
	level_up_done()


func _on_health_to_max_button_up():
	$"/root/Audio".click_sound()
	player.health_to_max()
	level_up_done()


func _on_lemon_eficiency_button_up():
	$"/root/Audio".upgrade_sound()
	shooter.lemon_eficiency_up()
	level_up_done()


func _on_retry_button_up():
	$"/root/Audio".click_sound()
	get_tree().reload_current_scene()

func _on_exit_button_up():
	$"/root/Audio".click_sound()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
