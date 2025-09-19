extends State

var player

func Enter():
	player = get_parent().get_parent()

func Update(delta):
	var speed_ratio = owner.velocity.length() / owner.Speed
	player.animation_tree.set("parameters/Move/blend_position", clamp(speed_ratio, 0.0, 1.0))


func Physics_Update(_delta):
	var input = Input.get_axis("ui_left", "ui_right")
	if input == 0:
		player.move_input = 0
		Transitioned.emit(self, "pIdle")
	else:
		player.move_input = input
	
	if Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "playerJump")
