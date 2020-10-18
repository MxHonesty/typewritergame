extends Node2D
# Game state manager

func _ready():
	pass # Replace with function body.

# SIGNALS
func _on_Timer_timeout():
	# Function called when half the time is up
	game_over()

func _on_Timer_half_time():
	# Function called on last second
	print("HALF THE TIME IS OVER")

func _on_Timer_one_second():
	print("ONE SECOND LEFT BOAY")

func game_over():
	# Function that gets called when the game is over
	print("GAME OVER")
