extends Control

func load_file(fileLoc : String):
	var file = FileAccess.get_file_as_bytes(fileLoc)
	if file[0] == 82:
		#this is the first byte of the header in a wav file so do wav things here
		pass
	elif file[0] == 255:
		#this is the first byte of the header in a mp3 so do mp3 things here
		pass
	elif file[0] == 79:
		#this is the first byte of the  header in an ogg so do ogg things here
		pass
	else:
		#probably an unsupported file so wouldn't hurt to have some kind of notification here
		pass
