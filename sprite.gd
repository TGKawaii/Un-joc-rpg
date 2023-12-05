extends TextureRect
@onready var sprite=self
@onready var sprite_slime=preload("res://enemies/SLIME.png")
@onready var sprite_id=1
@onready var parent=get_parent()
var pop
func set_sprite(_sprite_id):
	match(_sprite_id):
		0:
			sprite.texture=null
		1:
			sprite.texture=sprite_slime
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.05).timeout
	pop=parent.parent1
	set_sprite(sprite_id)
	pop.enemy_died.connect(death)
	#parent.enemy_died.connect(death)
	pass
	
func death():	
	self.modulate = Color(1, 0, 0, 1)  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
