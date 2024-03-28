extends Node2D

@onready var choice_button_scn = preload("res://button.tscn")
var choice_buttons: Array[Button] = []


func _ready():
	pass

func clear_dialogue_box():
	$VBoxContainer/text.text = ""
	for choice in choice_buttons:
		$VBoxContainer.remove_child(choice)
	choice_buttons = []

func add_text(text: String):
	$VBoxContainer/text.text = text

func add_choice(choice_text: String):
	var button_obj: button = choice_button_scn.instantiate()
	button_obj.choice_index = choice_buttons.size()
	choice_buttons.push_back(button_obj)
	button_obj.text = choice_text
	button_obj.choice_selected.connect(_on_choice_selected)
	$VBoxContainer.add_child(button_obj)

func _on_choice_selected(choice_index: int):
	print(choice_index)
	($"../EzDialogue" as EzDialogue).next(choice_index)



