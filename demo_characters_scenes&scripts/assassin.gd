extends VBoxContainer
var dead=false
var cursor_hover = false
@onready var battle=get_node("/root/battle")
@onready var player_index=1
@export var hp = 40
@export var max_hp = 40
@export var ap = 1
@export var max_ap = 1
@onready var parent_node = get_parent()
@onready var usage = false
@onready var char_used = false
var action
@export var attack = 5
@onready var Character_Menu = get_node("HBoxContainer/Character_Menu")
var queue_entities
var current_hp
var health_bar: ProgressBar  # Declare a ProgressBar variable
var label: Label
signal char_action(action,player_index)
signal no_more_actions(char)
signal character_death()
@onready var menu=get_node("HBoxContainer/Character_Menu")
# Called when the node enters the scene tree for the first time.
func _ready():
	Character_Menu.action.connect(on_character_menu_action)
	battle.changed_ap.connect(update_ap)
	battle.action_reset.connect(reset_ap)
	battle.enemy_attack.connect(update_health)
	var team_nodes = parent_node.char_nodes
	# Access the ProgressBar node in your scene using $ProgressBar
	ap = max_ap
	health_bar = $ProgressBar
	label = $ProgressBar/Label
	# Set the value of the health_bar based on hp
	health_bar.value = hp
	health_bar.max_value = max_hp
	current_hp = health_bar.value
	label.text = "HP: " + str(current_hp) + " / " + str(max_hp)
func update_health(atk,enemy_index,rng):
	print("skill issue")
	print(atk)
	if player_index==rng:
		hp-=atk
		health_bar.value = hp
		health_bar.max_value = max_hp
		label.text = "HP: " + str(hp) + " / " + str(max_hp)
		if hp<=0:
			char_death()
	pass
func reset_ap(entity):
	if entity==0:
		ap=max_ap
	pass
func update_ap(action_points,player):
	if player==player_index:
		ap+=action_points
	pass
func on_character_menu_action(action: int):
	# Handle the signal
	print("Received action:", action,"from:",player_index)
	char_action.emit(action,player_index,ap,attack)
	# Add your logic here

func _on_texture_rect_mouse_entered():
	cursor_hover = true

func is_character_clicked():
	return cursor_hover

func _on_texture_rect_mouse_exited():
	cursor_hover = false

func char_death():
	attack=0
	$HBoxContainer/TextureRect.modulate= Color(1, 0, 0, 1) 
	if dead==false:
		character_death.emit()
		dead=true
	pass
#func character_menu():
#	Character_Menu.menu_activation()

func _process(delta):
	action = Character_Menu.action
	pass
