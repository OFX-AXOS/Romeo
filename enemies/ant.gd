extends Node2D
@onready var raycast_right: RayCast2D = $raycast_right
@onready var raycast_left: RayCast2D = $raycast_left
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 20
var DIRECTION = 1 

func _process(delta):
	if raycast_right.is_colliding():
		DIRECTION = 1
		animated_sprite_2d.flip_h = false
	if raycast_left.is_colliding():
		DIRECTION = -1
		animated_sprite_2d.flip_h = true
	
	position.x += DIRECTION * SPEED * delta
	
	
	
