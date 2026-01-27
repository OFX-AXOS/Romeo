extends CharacterBody2D

const JUMP_VELOCITY = -300.0

@onready var stand: CollisionShape2D = $stand
@onready var crouch: CollisionShape2D = $crouch
@onready var animated_sprite_2d = $AnimatedSprite2D

var is_dead := false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_crouching := false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	is_crouching = Input.is_action_pressed("crouch") and is_on_floor()

	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y = JUMP_VELOCITY

	var current_speed = 55.0 if is_crouching else 110.0
	var input_axis = Input.get_axis("left", "right")

	if input_axis != 0:
		velocity.x = input_axis * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()

	update_collision()
	update_animations(input_axis)

func update_collision():
	stand.disabled = is_crouching
	crouch.disabled = not is_crouching

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = input_axis < 0
	if not is_on_floor() and velocity.y < 0:
		animated_sprite_2d.play("jump")
		return
	if not is_on_floor() and velocity.y >= 150:
		animated_sprite_2d.play("fall")
		return
	if is_crouching:
		animated_sprite_2d.play("crouch")
		return
	if input_axis != 0:
		animated_sprite_2d.play("run")
		return
	animated_sprite_2d.play("idle")


func die():
	if is_dead:
		return
	is_dead = true
	get_tree().call_deferred("reload_current_scene")
