extends Node

@onready var music_player:AudioStreamPlayer = $MusicAudioStreamPlayer
@onready var effects_player:AudioStreamPlayer = $FSXAudioStreamPlayer

var dictionary_step:Dictionary = {}
var dictionary_hit:Dictionary = {}
var dictionary_click:Dictionary = {}
var dictionary_music:Dictionary = {}

var coin_audio = load("res://sounds/coin2.ogg")
var lemon_audio = load("res://sounds/coin1.ogg")
var level_up_audio = load("res://sounds/upgrade1.ogg")
var hurt_audio = load("res://sounds/hurt3.ogg")
var dead_audio = load("res://sounds/jump1.ogg")
var upgrade_audio = load("res://sounds/upgrade4.ogg")
var gameover_audio = load("res://sounds/gameover2.ogg")
var step_audio = load("res://sounds/hurt2.ogg")
var shoot_audio = load("res://sounds/laser2.ogg")

func _ready():

	dictionary_click["click1"] = load("res://sounds/click1.ogg")
	dictionary_click["click2"] = load("res://sounds/click2.ogg")
	dictionary_click["click3"] = load("res://sounds/click3.ogg")
	dictionary_click["click4"] = load("res://sounds/click4.ogg")
	
	dictionary_hit["jump3"] = load("res://sounds/jump3.ogg")
	dictionary_hit["jump4"] = load("res://sounds/jump4.ogg")
	
	dictionary_music["Comedy"] = load("res://sounds/Retro Comedy.ogg")
	dictionary_music["Reggae"] = load("res://sounds/Retro Reggae.ogg")

func play_ui_sound(sound):
	effects_player.stream = sound
	effects_player.pitch_scale = 1
	effects_player.play(0)
	
func play_ui_sound_random_picth(sound):
	if !effects_player.is_playing():
		effects_player.stream = sound
		effects_player.pitch_scale = randf_range(0.9,1.4)
		effects_player.play(0)
	
func play_music(key: String):
	music_player.stream = dictionary_music[key]
	music_player.play(0)

func change_volume_fsx(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FSX"),linear_to_db(new_value))

func change_volume_music(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(new_value))

func click_sound():
	var key = "click%d" % randi_range(1,4)
	var sound = dictionary_click[key]
	play_ui_sound(sound)
	
func step_sound():
	play_ui_sound_random_picth(step_audio)

func hit_sound():
	# var key = "jump%d" % randi_range(3,4)
	var sound = dictionary_hit["jump3"]
	play_ui_sound(sound)

func coin_sound():
	play_ui_sound(coin_audio)

func lemon_sound():
	play_ui_sound(lemon_audio)

func level_sound():
	play_ui_sound(level_up_audio)

func hurt_sound():
	play_ui_sound(hurt_audio)

func dead_sound():
	play_ui_sound(dead_audio)

func upgrade_sound():
	play_ui_sound(upgrade_audio)
	
func gameover_sound():
	play_ui_sound(gameover_audio)

func shoot_sound():
	play_ui_sound(shoot_audio)
