extends State

var player

func Enter():
	player = get_parent().get_parent()

	if player.animation_tree: # ✅ extra safety check
		player.animation_tree.set("parameters/Move/blend_position", 0.0)

	player.move_input = 0


func Physics_Update(_delta):
	var input = Input.get_axis("ui_left", "ui_right")
	if input != 0:
		Transitioned.emit(self, "playerWalk")
	
	if Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "playerJump")
