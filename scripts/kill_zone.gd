extends Area2D
var is_dead: bool = false
func _on_kill_zone_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	var player = body
	while player and not player.has_method("die"):
		player = player.get_parent()

	if player:
		player.die()
	
