extends VBoxContainer

@export var team_characters_number = 3
@onready var char1 = 'res://demo_characters_scenes&scripts/assassin.tscn'
@onready var char2 = 'res://demo_characters_scenes&scripts/mage.tscn'
@onready var char3 = 'res://demo_characters_scenes&scripts/maidden.tscn'
@onready var team_actions = []
@onready var on_player_max_actions = []
@onready var char_nodes = []
var player_team = []
@export var char1_available = true
@export var char2_available = true
@export var char3_available = true
@onready var selected_character=0
var char_availability = [char1_available, char2_available, char3_available]

func team_array():
	player_team = [char1, char2, char3]

func team_load():
	for i in range(team_characters_number):
		var scene_resource = load(player_team[i])
		if scene_resource:
			var scene_instance = scene_resource.instantiate()
			if scene_instance:
				call_deferred("add_child", scene_instance)
				char_nodes.append(scene_instance)
			else:
				print("Failed to create an instance of the scene:", player_team[i])
		else:
			print("Failed to load the scene resource:", player_team[i])


func _ready():
	team_array()
	team_load()

func _process(delta):
	#action_points()
	pass
