extends CharacterBody2D

const Speed = 300
const JumpVelocity = -550
var move_input := 0.0
var wants_jump := false

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

func _ready() :
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if wants_jump and is_on_floor():
		velocity.y = JumpVelocity
		wants_jump = false

	if move_input != 0:
		velocity.x = move_input * Speed
		sprite.flip_h = move_input < 0  # <-- Flip when going left
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()

##func _physics_process(delta: float) -> void:
##	if not is_on_floor() : velocity += get_gravity() * delta
##	if Input.is_action_just_pressed("ui_accept") and is_on_floor() :
##		velocity.y = JumpVelocity
##	var direction = Input.get_axis("ui_left","ui_right")
##	if direction :
##		velocity.x = direction * Speed
##	else :
##		velocity.x = move_toward(velocity.x,0,Speed)
##	move_and_slide() #Esto el que desplaza los personajes
