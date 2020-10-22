extends RichTextLabel

func next_character():
	# Makes one more character visible
	visible_characters = visible_characters + 1

func set_text(new_text):
	visible_characters = -1
	bbcode_text = new_text

