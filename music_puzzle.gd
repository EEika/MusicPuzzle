extends Control

var puzzle_solution : Array
var puzzle_attempt : Array

@onready var solution_container = $OuterContainer/SolutionPannel/SolutionContainer
@onready var attempt_container = $OuterContainer/AttemtPannel/AttemptContainer
@onready var validation_indicator = $OuterContainer/MenuContainer/ValidationIndicator

# Called when the node enters the scene tree for the first time.
func _ready():

	randomize()
	_create_new_puzzle()
	

func _create_new_puzzle():
	puzzle_solution.clear()
	
	for i in range(5):
		puzzle_solution.append(randi() % 5 + 1)
		
	print(puzzle_solution)
	_update_solution_display()
	
	validation_indicator.color = Color("Yellow")


func _restart_attempt():
	puzzle_attempt.clear()	


func _on_new_button_pressed():
	_create_new_puzzle()
	_restart_attempt()
	_update_attempt_display()
	
	for button in %ButtonContainer.get_children():
		button.disabled = false


func _update_solution_display():
	var _solution = puzzle_solution.duplicate()
	
	for child in solution_container.get_children():
		child.text = str( _solution.pop_front() )


func _update_attempt_display():
	var _attempt = puzzle_attempt.duplicate()
	
	for child in attempt_container.get_children():
		if _attempt:
			child.text = str( _attempt.pop_front() )
		else:
			child.text = "_"


func _add_to_attempt(input : int):
	puzzle_attempt.append(input)
	_update_attempt_display()
	
	if puzzle_attempt.size() == puzzle_solution.size():
		validate_attempt()
	else:
		validation_indicator.color = Color("Yellow")


func validate_attempt():
	if puzzle_attempt == puzzle_solution:
		validation_indicator.color = Color("Green")
		$attempt_group
		for button in %ButtonContainer.get_children():
			button.disabled = true
	else:
		validation_indicator.color = Color("Red")
	
	_restart_attempt()


func _on_button_1_pressed():
	_add_to_attempt(1)


func _on_button_2_pressed():
	_add_to_attempt(2)


func _on_button_3_pressed():
	_add_to_attempt(3)


func _on_button_4_pressed():
	_add_to_attempt(4)


func _on_button_5_pressed():
	_add_to_attempt(5)


func _on_quit_button_pressed():
	get_tree().quit()

