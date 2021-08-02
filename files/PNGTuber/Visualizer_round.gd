extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(1, 1)

var definition = 20
var total_w = 400
var total_h = 200
var min_freq = 20
var max_freq = 20000

var max_db = -15
var min_db = -45

var accel = 20
var histogram = []

func _ready():
	max_db += get_parent().volume_db
	min_db += get_parent().volume_db
	
	for i in range(definition):
		histogram.append(0)

func _process(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.01, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
		
	
	update()

func _draw():
	var angle = PI
	var angle_int = (2 * PI) / definition
	var rad = 15
	var length = 30
	
	for i in range(definition):
		var normal = Vector2(0, -1).rotated(angle)
		var start_pos = normal * rad
		var end_pos = normal * (rad + histogram[i] * length)
		draw_line(start_pos, end_pos, Color.white, 4.5, true)
		angle += angle_int
	

