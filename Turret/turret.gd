extends Node3D
@export var projectile: PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shot = projectile.instantiate()
	add_child(shot)

