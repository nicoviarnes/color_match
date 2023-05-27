extends Node

var num_players = 1  # How many AudioStreamPlayers to use
var bus = "BGM"  # Which bus to play audio on

var available = []  # The list of available players
var queue = []  # The queue of sounds to play


func _ready():
	# Create the pool of AudioStreamPlayer nodes
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(on_stream_finished.bind(p))
		p.bus = bus
		
		
func on_stream_finished(stream):
	# When a stream finishes playing a sound, make it available again
	available.append(stream)
	

func play(sound_path, volume):
	queue.append([sound_path, volume])
	

func _process(_delta):
	# Play a queued sound if any player is available
	if not queue.is_empty() and not available.is_empty():
		var track = queue.pop_front()
		available[0].stream = track[0]
		available[0].volume_db = track[1]
		available[0].play()
		available.pop_front()


func bus_volume(volume):
	var BUS = AudioServer.get_bus_index("BGM")
	AudioServer.set_bus_volume_db(BUS, volume)
