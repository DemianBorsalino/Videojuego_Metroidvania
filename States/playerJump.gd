extends State

var player

func Enter():
	player = get_parent().get_parent()
	player.velocity.y = player.JumpVelocity
	
	player.animation_tree.set("parameters/Jump/request",0.0)


func Physics_Update(_delta):
	var input = Input.get_axis("ui_left", "ui_right")
	player.move_input = input

	if player.is_on_floor():
		if input == 0:
			Transitioned.emit(self, "playerIdle")
		else:
			Transitioned.emit(self, "playerWalk")
