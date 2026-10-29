extends CharacterBody2D


@export var player_speed: int = 600
var screen_size: Vector2
var margin: Vector2 = Vector2(32*scale.x,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		velocity = Vector2(-1*player_speed, 0)
	if Input.is_action_pressed("right"):
		velocity = Vector2(1*player_speed, 0)
	var collision = move_and_collide(velocity*delta)
	velocity = Vector2.ZERO

func _process(delta: float) -> void:
	position = position.clamp(margin, screen_size - margin)

func _unhandled_key_input(event: InputEvent) -> void:
	pass

func start():
	position = Vector2(screen_size.x/2, screen_size.y/1.15)
	velocity = Vector2.ZERO
