extends Node2D
# Game state manager

var time_passed = 0 # The time that has already passed this section
var section_time = 6 # The total time per section

# Bools for triggering limited time effects
var half_time_triggered = false
var one_second_triggered = false

# SIGNALS
func _on_Timer_timeout():
	# Function called when half the time is up
	time_passed += 1
	print("SEMNAL")
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
	half_time_triggered = true
	print("HALF THE TIME IS OVER")

func Timer_one_second():
	# Function called on last second
	one_second_triggered = true
	print("ONE SECOND LEFT BOAY")

func game_over():
	# Function that gets called when the game is over
	print("GAME OVER")

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
