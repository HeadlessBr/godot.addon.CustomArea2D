@tool
extends EditorPlugin

static var groups : Array [String] = ["Obstaculos", "Coletaveis"]














func _enable_plugin() -> void:
	pass
	


func _disable_plugin() -> void:
	remove_custom_type("CustomArea2D")


func _enter_tree() -> void:
	add_custom_type(
		"CustomArea2D",
		"Area2D",
		preload("res://addons/customarea2d/nodes/custom_area_2d.gd"),
		preload("uid://c48pbxxvexqs3")
	)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("CustomArea2D")
