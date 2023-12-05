extends Node2D

var label1: Label
var label2: Label
var label3: Label
var energy1: int = 0
var energy2: int = 0
@onready var player_death_meter: int = 0
@onready var enemy_death_meter: int = 1
@onready var player: bool = true
@onready var enemy: bool = true
@onready var max_turn
@onready var turn: int = 0
@onready var queue: Array = []
@onready var player_team_node = get_node("Player_team")
var char_nodes: Array = []
var enemy_team_nodes: Array = []
@onready var enemies_node = get_node("enemy_team")
@onready var temp_subnode_acces
@onready var team_actions
@onready var selected: int = 0
@onready var team_action_points: Array = []
@onready var current_attack: int = 0
@onready var player_action
signal damage(attack)
signal spell(attack, type)
signal random()
var enemies: Array = []
var player_team: Array = []
signal changed_ap(ap, player)
signal action_reset(entity: String)
signal enemy_team
signal enemy_attack(attack, enemy, char)
signal end_of_battle(type)
var char_actions: Array = []

func queue_create():
	queue.append(player)
	for i in range(len(enemy_team_nodes)):
		queue.append(enemy)
	max_turn = len(queue)

func action_resetting(entity):
	if entity == 0:
		action_reset.emit(0)
	else:
		action_reset.emit(enemy_team_nodes[entity - 1].enemy_index)

func queue_system():
	if queue[turn] == false:
		action_resetting(turn)
		queue[turn] = true
		turn += 1
		enemy_death_meter = 0
	if turn != 0:
		enemy_attacking(turn)
		random.emit()
		turn += 1
		random_energy()
	if turn >= max_turn:
		turn = 0

func enemy_attacking(enemy_index):
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	var rng = random_generator.randi_range(1, 3)
	print("rng=", rng)

	if enemy_team_nodes[enemy_index - 1] and enemy_team_nodes[enemy_index - 1].hp <= 0:
		enemy_death_meter += 1
		if enemy_death_meter == len(enemy_team_nodes):
			end_of_battle.emit(2)

	if enemy_team_nodes[enemy_index - 1]:
		enemy_attack.emit(enemy_team_nodes[enemy_index - 1].atk, enemy_team_nodes[enemy_index - 1].enemy_index, rng)

func random_energy():
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	energy1 = random_generator.randi_range(1, 3)
	random_generator.randomize()
	energy2 = random_generator.randi_range(1, 3)
	label1.text = str(energy1)
	label2.text = str(energy2)
	await self.random

func _ready():
	$Spell_Menu.spell_menu.connect(spell_use)
	label1 = $energy1/Label1
	label2 = $energy2/Label2
	label3 = $Label
	self.end_of_battle.connect(result)
	char_nodes = player_team_node.char_nodes
	enemy_team_nodes = enemies_node.enemy_team_scenes
	queue_create()
	action_connections()

func attack(atk):
	print(atk)
	damage.emit(atk)
	for i in range(1, len(queue)):
		print(queue[i])

func action_connections():
	for i in range(len(char_nodes)):
		char_nodes[i].char_action.connect(on_action)
		char_nodes[i].character_death.connect(char_death)

func result(type):
	if type == 1:
		label3.text = "YOU LOST"
	if type == 2:
		label3.text = "YOU WON"

func char_death():
	player_death_meter += 1
	if player_death_meter == 3:
		end_of_battle.emit(1)

func on_action(action, player_index, ap, attack_value):
	var atk = attack_value
	print(ap)
	if ap > 0:
		match action:
			1:
				attack(atk)
				changed_ap.emit(-1, player_index)
			2:
				pass
			3:
				pass
			_:
				print("error")

func spell_use(type):
	match type:
		1:
			if energy1 >= 2 and energy2 >= 1:
				energy1 -= 2
				energy2 -= 1
				spell.emit(15, 1)
				label1.text = str(energy1)
				label2.text = str(energy2)
		2:
			if energy1 >= 1 and energy2 >= 1:
				energy1 -= 1
				energy2 -= 1
				spell.emit(3, 1)
				label1.text = str(energy1)
				label2.text = str(energy2)


func _process(_delta):
	queue_system()

func _on_button_pressed():
	if turn == 0 and player == true:
		queue[turn] = false
