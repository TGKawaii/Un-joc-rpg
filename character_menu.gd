extends Control

signal action(action)

@onready var Attack = get_node("VBoxContainer/Attack")
@onready var Spells = get_node("VBoxContainer/Spells")
@onready var Inventory = get_node("VBoxContainer/Inventory")
var menu_instance = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func menu_activation():
	if menu_instance:
		close_menu()
	else:
		open_menu()
	menu_instance = not menu_instance  # Toggle the menu_instance value

func open_menu():
	Attack.show()
	Spells.show()
	Inventory.show()

func close_menu():
	Attack.hide()
	Spells.hide()
	Inventory.hide()

func _on_attack_pressed():
	action.emit(1)

func _on_spells_pressed():
	action.emit(2)

func _on_inventory_pressed():
	action.emit(3)

