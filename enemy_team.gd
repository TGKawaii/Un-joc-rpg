extends VBoxContainer
@export var enemy_number=3
var enemy_team:Array=[]
var enemy_team_scenes:Array=[]
@onready var enemy="res://enemy.tscn"
func team_array():
	for i in range(enemy_number):
		enemy_team.append(enemy)
	pass
func team_load():
	for i in range(enemy_number):
		var scene_resource = load(enemy_team[i])  # Load the scene as a PackedScene resource
		if scene_resource:
			var scene_instance = scene_resource.instantiate()  # Create an instance of the scene
			if scene_instance:
				call_deferred("add_child", scene_instance)  # Schedule adding the child after the current frame's processing
				enemy_team_scenes.append(scene_instance)
				scene_instance.enemy_index=i+1
			else:
				print("Failed to create an instance of the scene:", enemy_team[i])
		else:
			print("Failed to load the scene resource:", enemy_team[i])
# Called when the node enters the scene tree for the first time.
func _ready():
	
	team_array()
	team_load()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
