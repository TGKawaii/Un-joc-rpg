extends Control
var rng
var dead=false
@onready var battle=get_node("/root/battle")
@onready var attacked=false
@onready var enemy_id=1
@onready var sprite_patch=get_node("Control/Sprite")
var cursor_hover = false
var max_hp=0
var hp=0
var atk=0
var special_type=false
var max_ap=0
var ap=0
var enemy_name="enitty_undefined"
var player_atk
var enemy_index
signal enemy_died()
func enemy(_enemy_id):
	match _enemy_id:
		0:
			enemy_name="entitty_undefined"
			sprite_patch.set_sprite(_enemy_id)
		1:
			hp=1
			max_hp=1
			atk=6
			special_type=false
			enemy_name="slime"
			max_ap=1
			ap=1
			sprite_patch.set_sprite(_enemy_id)
# Called when the node enters the scene tree for the first time.
func _ready():
	battle.spell.connect(spell)
	battle.action_reset.connect(reset_actions)
	enemy(enemy_id)
	battle.damage.connect(dmg)
	pass # Replace with function body.
func random():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var rng=random.randi_range(1, 1000)
	return rng
func dmg(atk):
	player_atk=atk
	print("attack in progress")
	attacked=not attacked
	pass
func reset_actions(enemy):
	if enemy_index==enemy:
		ap=max_ap
	pass
func spell(atk,type):
	rng=random()
	match type:
		1:
			hp-=atk
		2:
			hp-=atk*rng
			print(rng)
	enemy_death()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
func enemy_death():
	if hp<=0 and dead==false:
		atk=0
		enemy_died.emit()
		await get_tree().create_timer(3).timeout
		dead=true

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Handle left mouse button click
			if is_character_clicked():
				if attacked==true:
					hp-=player_atk
					print("hp=",hp)
					attacked= not attacked
					enemy_death()
func is_character_clicked():
	return cursor_hover

func _on_sprite_mouse_entered():
	cursor_hover = true


func _on_sprite_mouse_exited():
	cursor_hover = false
