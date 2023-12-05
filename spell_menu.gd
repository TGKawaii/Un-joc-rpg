extends VBoxContainer
signal spell_menu(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_path())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	spell_menu.emit(1)
	pass # Replace with function body.


func _on_button_2_pressed():
	spell_menu.emit(2)
	pass # Replace with function body.
