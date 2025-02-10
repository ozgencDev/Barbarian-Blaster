extends PathFollow3D


@export var speed: float = 1
@export var max_health := 50
@export var coin := 15
@onready var base = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group("bank")

var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		print(current_health)
		if(current_health < 1):
			queue_free()
			bank.gold += coin
		

func _ready() -> void:
	current_health = max_health
	

func take_damage() -> void:
	current_health -= 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	print(progress)
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)

