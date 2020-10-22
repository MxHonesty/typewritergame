extends Node2D
# Script responsable for validating the pressed keys

#==============================================================================
# TODO CAZUL $END$ PENTRU load_new_section()
#==============================================================================

var local_section = " "
var local_char = 0

var type
var clunk
var finish
var sprite

# Semnal transmis cand sectiunea curenta a fost terminata
signal section_over

func _ready():
	type = AudioStreamPlayer.new()
	self.add_child(type)
	clunk = AudioStreamPlayer.new()
	self.add_child(clunk)
	finish = AudioStreamPlayer.new()
	self.add_child(finish)
	
	sprite = get_parent().get_parent().get_node("VisualController/Sprite")
	
	type.stream = load("res://Resources/Art/typewriter.wav")
	clunk.stream = load("res://Resources/Art/lightclunk1.wav")
	finish.stream = load("res://Resources/Art/clank1.wav")

func _input(event):
	# Function that manages input
	# Checks if the pressed key is equal to the current character waiting to be typed
	# If a character is held down, then it is read as a uppercase letter
	if event is InputEventKey:
		if event.is_pressed():
			var pressed_character = parse_character(OS.get_scancode_string(event.scancode))
			if event.echo == true:
				pressed_character = key_held(pressed_character)
			if(pressed_character == local_section[local_char]):
				print(pressed_character)
				if(local_char == len(local_section) - 1):
					finish.play()
				else: 
					type.play()
				increment_char()
			
func increment_char():
	# Function increments local_char counter
	# If it increments in it's last position, it resets 
	local_char += 1
	if local_char == len(local_section): # Daca charul depaseste stringul, atunci aduce urmatorul
		local_char = 0
		load_new_section()
	sprite.position.x = calculate_sprite_position()
	get_parent().get_parent().get_node("VisualController/Ref2").next_character()


func calculate_sprite_position():
	# Function calculates the position in whitch the slider must be 
	# on every increment
	var procent = float(local_char) / float(len(local_section))
	var pozitie_x = 200 * procent - 100
	return pozitie_x
	
	
func load_new_section():
	# Incarca o noua sectiune de text din TextManager
	get_parent().assign_next_section() 
	local_section = get_parent().get_current_section()
	emit_signal("section_over")
	print(local_section)

func parse_character(chr):
	# Turns Unicode into actual char representation Ex: "Space" -> " "
	if chr == "Space":
		chr = " "
	elif chr == "Comma":
		chr = ","
	elif chr == "Period":
		chr = "."
	elif chr == "Slash":
		chr = "/"
	elif chr == "Apostrophe":
		chr = "'"
	elif chr == "Semicolon":
		chr = ";"
	elif chr == "Minus":
		chr = "-"
	else:
		chr = chr.to_lower()
	return chr

func key_held(key):
	# This function is called when the key has been held down
	# Inout: The original character that is held down
	# Output: Returns the modified character acording to the rules
		# For all alphabetic characters, it makes them uppercase
		# For 1 and /, it returns the shift version of the key !, ?
	if(key == "1"):
		return "!"
	elif(key == "/"):
		return "?"
	return key.to_upper()

func get_local_section():
	# Returns local_section on call
	# Output the string of the current section
	return local_section
	
func get_local_char():
	# Returns local_char on call
	# Output: int indicatind the index of the current char we are listening for
	return local_char
