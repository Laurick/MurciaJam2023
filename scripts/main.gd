extends MarginContainer

@onready var music = $VBoxContainer/HBoxContainer2/music
@onready var fx = $VBoxContainer/HBoxContainer2/fx

func _ready():
	TranslationServer.set_locale("es")
	if $"/root/Constants".music > -1:
		music.set_value($"/root/Constants".music)
	else:
		$"/root/Audio".change_volume_music(1)
	if $"/root/Constants".fx > -1:
		fx.set_value($"/root/Constants".fx)
	else:
		$"/root/Audio".change_volume_fsx(1)
	$"/root/Audio".play_music("Reggae")

func _on_button_button_up():
	$"/root/Audio".click_sound()
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_music_value_changed(_value):
	$"/root/Audio".change_volume_music(music.value/16)


func _on_fx_drag_ended(_value_changed):
	$"/root/Audio".change_volume_fsx(fx.value/8)
	$"/root/Audio".click_sound()


func _on_option_button_item_selected(index):
	$"/root/Audio".click_sound()
	match index:
		0:
			TranslationServer.set_locale("es")
		1:
			TranslationServer.set_locale("en")
		_:
			TranslationServer.set_locale("es")
