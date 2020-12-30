extends "res://actors/player-states/Move.gd"

func _state_enter(info: Dictionary) -> void:
	host.play_animation("Jump")
	host.sounds.play("Jump")
	host.vector.y = -host.jump_speed
	
	if info.has('input_vector'):
		do_move(info['input_vector'])

func _state_physics_process(delta: float) -> void:
	_check_pickup_or_throw_or_use()
	_check_blop()
	
	if host.is_on_floor():
		get_parent().change_state("Idle")
		return
	
	var input_vector = _get_player_input_vector()
	do_move(input_vector)
	
	# If the player releases the jump key, then interrupt the jump.
	if host.vector.y < 0.0 and host.input_buffer.is_action_just_released("jump"):
		host.vector.y = 0.0
