extends Node2D
# Manager for text

onready var file1 = 'res://Resources/Texts/exemplu1.txt'

var current_text = []
var current_section = ""
var current_index = 0
var current_file = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_file(file1)
	
	
func load_file(localfile):
	# Loads text file into list, line by line
	# Input: String path to file from res://
	# Output: Assigns value to current_list
	current_text = []
	current_index = 0
	var f = File.new()
	f.open(localfile, File.READ)
	while not f.eof_reached():
		var line = f.get_line()
		line += " "
		current_text.append(line)
	f.close()

func get_current_text():
	# Returns TextManager's current_text list
	return current_text

func get_current_section():
	# Returns TextManager's current_section string
	return current_section

func assign_next_section():
	# Function assignes next 5 word section to current_section
	# If there is nothing else to assign, it gets the value "$END$"
	if current_index < len(current_text):
		current_section = current_text[current_index]
		current_index += 1
	else:
		current_section = "$END$"
