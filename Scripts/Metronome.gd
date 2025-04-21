class_name InteractiveAudioManager

extends Control

@export_range(40, 500, 1, "between") var bpmInput

@onready var click : AudioStreamPlayer = $beatone_click
@onready var nice : AudioStreamPlayer = $beattwo_Nice
@onready var beat : Timer = $Beat
@onready var audioCueDictMain = {}
@onready var audioCueDictFill = {}
@onready var audioArrayMain : Array[AudioStreamPlayer]
@onready var audioArrayFill : Array[AudioStreamPlayer]

enum BEATS {One, Two, Three, Four}

func _init():
	load("res://Assets/Audio/Cerb Snare.wav")
	load("res://Assets/Audio/Sucellos Nice.mp3")
		
func _ready():
	play_audio_in_time(BEATS.One, bpmInput)

#input signals
func _on_button_pressed():
	load_main_array(click)
	load_dicts('m')
	
func _on_button_2_pressed():
	load_fill_array(nice)
	load_dicts('f')
	
#load arrays to be cued
func load_main_array(player : AudioStreamPlayer):
	if audioArrayMain.has(player) == false:
		audioArrayMain.append(player)
	#print(audioArrayMain)
		
func load_fill_array(player : AudioStreamPlayer):
	if audioArrayFill.has(player) == false:
		audioArrayFill.append(player)
	#print(audioArrayFill)

#cue loaded array into dict
func load_dicts(type):
	if (click.name.contains("one") and type == 'm'):
		cue_main(BEATS.One, audioArrayMain)
	if (nice.name.contains("two") and type == 'f'):
		cue_fill(BEATS.Two, audioArrayFill)

func cue_main(beatKey : BEATS, player : Array):
	if audioCueDictMain.has(beatKey) == false:
		audioCueDictMain[beatKey] = player
	#print(audioCueDictMain)
	
func cue_fill(beatKey : BEATS, player : Array):
	if audioCueDictFill.has(beatKey) == false:
		audioCueDictFill[beatKey] = player
	#print(audioCueDictFill)
	
#play audio
func play_from_dict(type, i : int):
	if type == 'm':
		#add tween tostop and replace main audio
		for audio in audioCueDictMain.get(i):
			audio.play()
			#print(audio)
		audioCueDictMain.erase(i)
	elif type == 'f':
		#add tween to duck main during fill
		for audio in audioCueDictFill.get(i):
			audio.play()
			#print(audio)
		audioCueDictFill.erase(i)
		
#metronome state machine
func play_audio_in_time(beats : BEATS, bpm : float, loop : bool = true):
	var time : float = (1/bpm)*60
	match beats:
		0:
			print("beat one")
			if audioCueDictMain.has(0):
				play_from_dict('m', 0)
			if audioCueDictFill.has(0):
				play_from_dict('f', 0)
			await get_tree().create_timer(time).timeout
			if loop == true:
				play_audio_in_time(BEATS.Two, bpmInput)
		1:
			print("beat two")
			if audioCueDictMain.has(1):
				play_from_dict('m', 1)
			if audioCueDictFill.has(1):
				play_from_dict('f', 1)
			await get_tree().create_timer(time).timeout
			if loop == true:
				play_audio_in_time(BEATS.Three, bpmInput)
		2:
			print("beat three")
			if audioCueDictMain.has(2):
				play_from_dict('m', 2)
			if audioCueDictFill.has(2):
				play_from_dict('f', 2)
			await get_tree().create_timer(time).timeout
			if loop == true:
				play_audio_in_time(BEATS.Four, bpmInput)
		3:
			print("beat four")
			if audioCueDictMain.has(3):
				play_from_dict('m', 3)
			if audioCueDictFill.has(3):
				play_from_dict('f', 3)
			await get_tree().create_timer(time).timeout
			if loop == true:
				play_audio_in_time(BEATS.One, bpmInput)
