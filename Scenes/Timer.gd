extends Timer
# Timer that sends a singal every timp seconds

var timp = 1.0
var called_one_second = false
var called_half_time = false

func _ready():
	# Pentru debug
	one_shot = false
	autostart = true
	wait_time = timp
	reset_timer()

func reset_timer():
	# Function for reseting the timer
	start(timp) # set wait_time to timp and restarts the timer

