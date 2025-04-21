extends AudioStreamPlayer

var playback
@onready var sample_hz = 11025

func _ready():
	playback = $".".get_stream_playback()
	fill_buffer()
	
func fill_buffer():
	var rng = RandomNumberGenerator.new()
	var frames_available = playback.get_frames_available()
	
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(rng.randf_range(100, 10000)))
		
		
