extends Node2D


# Called when the node enters the scene tree for the first time.
enum DIRECTION {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}
@export var Direction = DIRECTION.UP

func _ready():
	add_to_group("MovePoint")


func MovePlayer():
	var player = get_tree().get_nodes_in_group("Player")
	player[0].global_position = global_position
	player[0].Direction = Direction
	player[0].UpdateAnims()


