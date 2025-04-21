extends Node
#Autoload as AudioManager

const MAX_INSTANCE = 3 # number of time one audio can be played on top of eachother
var loaded_audio = {}
var audio_instances = {}

#example { "Violin_A" : "res://sounds/Violin_A.mp3" }
func load_audio_files(paths : Dictionary):
	for audio_name in paths :
		loaded_audio[audio_name] = load(paths[audio_name] as String)


func cue(audio_name):
	var instances : Array[AudioStreamPlayer] = audio_instances[audio_name]
	var player : AudioStreamPlayer

	if instances.size() < MAX_INSTANCE :
		player = loaded_audio[audio_name].instantiate()
		add_child(player)
	else :
		player = instances.pop_front()

	player.stop()
	player.play()

	instances.append(player)

	
func unload_audio_files(audio_name : Array):
	for player in audio_instances[audio_name] :
		player.queue_free()

	audio_instances.erase(audio_name)

	loaded_audio[audio_name].queue_free()
	loaded_audio.erase(audio_name)

