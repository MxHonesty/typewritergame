extends Node2D

func on_ready():
	test_get_current_text()
	
func test_get_current_text():
	assert(typeof($TextManager.get_current_text()) == TYPE_ARRAY)
