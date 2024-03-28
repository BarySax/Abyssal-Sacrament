class_name  button extends Button

var choice_index: int

signal choice_selected(choice_index)

func _on_pressed():
	print("choix")
	choice_selected.emit(choice_index)
