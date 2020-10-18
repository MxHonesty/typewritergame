extends Timer

signal half_time
signal one_second

var timp = 10.0
var called_one_second = false
var called_half_time = false

func _ready():
	# Pentru debug
	autostart = true
	wait_time = timp
	reset_timer()

func half_time_left():
	# Function that gets called when the timer reaches the half point
	# Emits the half_time signal
	called_half_time = true
	emit_signal("half_time")

func one_second_left():
	# Function that gets called when the timer reaches the last second
	# Emits the one_second signal
	called_one_second = true
	emit_signal("one_second")
	
func half_time_condition():
	# Returns true if half of the time is over
	return time_left <= wait_time/2

func one_second_condition():
	# Returns true if there is one more second left
	return time_left <= 1.0

func _process(delta):
	# Gets called every frame
	if not called_half_time and half_time_condition():
		half_time_left()
	elif not called_one_second and one_second_condition():
		one_second_left()
	pass

func reset_timer():
	# Function for reseting the timer
	called_half_time = 0
	called_one_second = 0
	start(timp) # set wait_time to timp and restarts the timer
