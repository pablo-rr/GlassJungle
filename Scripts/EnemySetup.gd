class_name EnemySetup
extends Spatial

export var trigger : NodePath = ""
export var delay : float = 0.0

onready var enemy_spawned : bool = false

func _ready() -> void:
	set_process(false)
	get_node(trigger).connect("body_entered", self, "trigger_spawn")
	
func _process(delta: float) -> void:
	setup_enemy()
	
func trigger_spawn(body : Node) -> void:
	if(body is KinematicBody and body.collision_layer == 4 and !enemy_spawned):
		enemy_spawned = true
		yield(get_tree().create_timer(delay), "timeout")
		set_process(true)
		$SpawnSound.play(0.0)
		$Enemy.setup(body)

func setup_enemy() -> void:
	$Enemy.global_transform.origin = lerp($Enemy.global_transform.origin, $EndPosition.global_transform.origin, 0.23)
	$Enemy.scale = lerp($Enemy.scale, Vector3(1, 1, 1), 0.23)