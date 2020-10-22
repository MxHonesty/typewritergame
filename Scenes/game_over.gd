extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	# Function that manages input
	# Checks if the pressed key is equal to the current character waiting to be typed
	# If a character is held down, then it is read as a uppercase letter
	if end == true:
		if event is InputEventKey:
			if event.is_pressed():
				if event.scancode == KEY_SPACE:
					get_tree().reload_current_scene()

func go_screen():
	$go_screen.visible = true
	end = true
	
func gg_screen():
	$gg_screen.visible = true
	end = true
