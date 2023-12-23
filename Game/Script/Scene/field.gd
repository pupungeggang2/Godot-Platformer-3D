extends Node3D

@onready var camera_node = get_node("Camera3D")
@onready var player = get_node("Player")

func _ready():
	camera_node.rotation = Vector3(-1.0/6.0 * PI, 0, 0)
	pass

func _process(delta):
	input_handle()
	player_move(delta)
	camera_adjust()
	
func camera_adjust():
	camera_node.position = Vector3(player.position.x, player.position.y + 3, player.position.z + 3)

func input_handle():
	if Input.is_action_just_pressed('front'):
		Var.pressed.front = true
	if Input.is_action_just_pressed('left'):
		Var.pressed.left = true
	if Input.is_action_just_pressed('back'):
		Var.pressed.back = true
	if Input.is_action_just_pressed('right'):
		Var.pressed.right = true
	if Input.is_action_just_pressed('jump'):
		if Var.player_jump > 0:
			Var.player_jump -= 1
			Var.player_y_speed = Var.player_jump_power
		
	if Input.is_action_just_released('front'):
		Var.pressed.front = false
	if Input.is_action_just_released('left'):
		Var.pressed.left = false
	if Input.is_action_just_released('back'):
		Var.pressed.back = false
	if Input.is_action_just_released('right'):
		Var.pressed.right = false
		
func player_move(delta):
	var temp_position = Vector3(player.position.x, player.position.y, player.position.z)
	
	if Var.pressed.front == true:
		temp_position.z -= 2.5 * delta
	if Var.pressed.left == true:
		temp_position.x -= 2.5 * delta
	if Var.pressed.back == true:
		temp_position.z += 2.5 * delta
	if Var.pressed.right == true:
		temp_position.x += 2.5 * delta
		
	temp_position.y += Var.player_y_speed * delta
	Var.player_y_speed += Var.gravity * delta
	
	for i in range(len(Var.collision_rect)):
		if temp_position.x > Var.collision_rect[i][0] and temp_position.x < Var.collision_rect[i][2] and temp_position.z > Var.collision_rect[i][1] and temp_position.z < Var.collision_rect[i][3] and temp_position.y < 0.0:
			Var.player_jump = 1
			temp_position.y = 0.0
			Var.player_y_speed = 0.0
			break

	# Fall Check
	if temp_position.y < -5:
		temp_position = Vector3(0.0, 0.0, 0.0)
		
	player.position = Vector3(temp_position.x, temp_position.y, temp_position.z)
