Godot v4.3

I was initially just playing around with the idea of creating a metronome with Godot timer nodes, but it eventually developed into a metronome that could take in audio and queue to be played in sequence with those timers.
It's based on the idea that you can create a kind of recursion with timers where the callback resets its own timer.
This can be a nice way of doing timings instead of using % with the system/engine clock since it seems to mitigate the issue of drift (emphasis on seems).
I would later go on to use this idea in my rhythm game.
