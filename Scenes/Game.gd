extends Node2D
# Game state manager

var time_passed = 0 # The time that has already passed this section
export var section_time = 12 # The total time per section

# Bools for triggering limited time effects
var half_time_triggered = false
var one_second_triggered = false

var sound1
var sound2
var sound3 
var sound4

var rng = RandomNumberGenerator.new()

func _ready():
	sound1 = AudioStreamPlayer.new()
	self.add_child(sound1)
	sound2 = AudioStreamPlayer.new()
	self.add_child(sound2)
	sound3 = AudioStreamPlayer.new()
	self.add_child(sound3)
	sound4 = AudioStreamPlayer.new()
	self.add_child(sound4 )
	
	sound1.stream = load("res://Resources/Art/warpedradio.wav")
	sound2.stream = load("res://Resources/Art/randomLFO.wav")
	sound3.stream = load("res://Resources/Art/heartbeat.wav")
	sound4.stream = load("res://Resources/Art/horror ambient.wav")

# SIGNALS
func _on_Timer_timeout():
	# Function called when half the time is up
	time_passed += 1
	if game_over_condition():
		# Time is up Condition for game over
		game_over()
	elif one_second_condition():
		# One second effect
		Timer_one_second()
	elif half_time_condition():
		# Half time effect
		Timer_half_time()

# EFFECTS
func Timer_half_time():
	# Function called on last second
	var val = rng.randi_range(0, 3)
	if val == 0:
		sound1.play()
	elif val == 1:
		sound2.play()
	elif val == 2:
		sound3.play()
	half_time_triggered = true
	

func Timer_one_second():
	# Function called on last second
	one_second_triggered = true
	sound4.play()

	
	
# CONDITIONS
func one_second_condition():
	# Function for one second trigger
	# Output: Returns True if the condition is met
	# IF It's last second and it hasnt been triggered before
	return time_passed == section_time - 1 and  not one_second_triggered
	
func half_time_condition():
	# Function for half time trigger
	# Output: Returns True if the condition is met
	return time_passed >= section_time/2 and not half_time_triggered

func game_over_condition():
	# Function for game over trigger
	# Output: Returns true if the condition is met
	return time_passed == section_time

# UTILS
func reset_section():
	# Called when a  new section is started
	# Resets to default section status
	time_passed = 0
	half_time_triggered = false
	one_second_triggered = false


func _on_InputManager_section_over():
	# Function called everytime the current section is done.
	if not game_done:
		$VisualController/Ref.set_text($TextManager/InputManager.get_local_section())
		$VisualController/Ref2.set_text($TextManager/InputManager.get_local_section())
		reset_section()


func _on_TextManager_game_done():
	stop()
	$VisualController/game_over.gg_screen()
	
	
var game_done = false

func game_over():
	# Function that gets called when the game is over
	stop()
	$VisualController/game_over.go_screen()


func stop():
	game_done = true
	
