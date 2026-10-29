extends Node2D

@export var level_scene: PackedScene
signal game_over
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_ESCAPE:
				get_tree().quit()


func _on_ball_game_over() -> void:
	$Ball.start()
	$board.start()
	for node in get_tree().get_nodes_in_group("level"):
		node.queue_free()
	game_over.emit()
	
	
func start():
	var level: Node2D = level_scene.instantiate()
	level.add_to_group("level")
	add_child(level)
	$Ball.start()
	$board.start()


func _on_hud_start_game() -> void:
	start()
