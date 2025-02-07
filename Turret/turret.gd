extends Node3D
@export var projectile: PackedScene 
@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop
@export var turret_range := 10
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var enemy: PathFollow3D


var path: Path3D 

func _physics_process(delta: float) -> void:
	enemy = find_best_target()
	if enemy:
		look_at(enemy.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if enemy:
		var shot = projectile.instantiate()
		add_child(shot)
		animation_player.play("TurretRecoil")
		shot.global_position = turret_top.global_position
		shot.direction = global_transform.basis.z


func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	
	for enemy in path.get_children():
		if enemy is PathFollow3D:
			if global_position.distance_to(enemy.global_position) < turret_range:
				if enemy.progress > best_progress:
					best_target = enemy
					best_progress = enemy.progress
	
	return best_target
