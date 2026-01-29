extends Area2D

@export_file("*.tscn") var target_scene: String

func _on_body_entered(body):
	if body.name == "Player":
		call_deferred("_change_level")

func _change_level():
	get_tree().change_scene_to_file(target_scene)
