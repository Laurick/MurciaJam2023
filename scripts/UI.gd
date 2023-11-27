extends Control

@onready var score_label:Label = $Panel/VBoxContainer/HBoxContainer/CenterContainer/score
@onready var lives_label:Label = $Panel/VBoxContainer/HBoxContainer/CenterContainer3/lives
@onready var time_label:Label = $Panel/VBoxContainer/HBoxContainer/CenterContainer2/time
@onready var level_label:Label = $Panel/VBoxContainer/CenterContainer/Label

@onready var lemonade_progress:ProgressBar = $Panel/VBoxContainer/lemonade
@onready var exp_progress:ProgressBar = $Panel/VBoxContainer/CenterContainer/exp

var total_seconds = 0

func _ready():
	score_changed(0)
	life_changed(5)

func get_time_played():
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var hhmmss_string:String = "%02d:%05.2f" % [minutes, seconds]
	return hhmmss_string
	
func _process(delta):
	total_seconds += delta
	time_label.text = tr("TIME_LABEL") % get_time_played()

func score_changed(score):
	score_label.text = tr("SCORE_LABEL") % score

func life_changed(lives):
	lives_label.text = tr("LIFE_LABEL") % lives

func exp_changed(experience, total):
	exp_progress.value = (experience*100)/total

func level_changed(level):
	level_label.text = str(level)

func lemonade_changed(lemonade, total):
	lemonade_progress.value = (lemonade*100)/total
