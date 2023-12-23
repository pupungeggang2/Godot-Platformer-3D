extends Node

class Pressed:
	var front = false
	var left = false
	var back = false
	var right = false
	var jump = false

var pressed = Pressed.new()
var player_jump_power = 6.0
var player_jump = 1
var player_y_speed = 0.0
var gravity = -9.8

var collision_rect = [[-5.5, -5.5, 5.5, 5.5], [-5.5, -10.5, -2.5, -7.5]]
