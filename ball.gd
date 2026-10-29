extends CharacterBody2D

signal game_over

var screen_size: Vector2
var margin: Vector2 = Vector2(16,16)
@export var flick_factor: float = 0.3
@export var max_x: int = 800
@export var max_y: int = 600
@export var start_factor_y: float = 2.5
@export var speed_addition: int = -100

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		velocity += collision.get_collider_velocity() * flick_factor

		var collider = collision.get_collider()
		if collider.has_method("destroy"):
			collider.destroy()
		else:
			velocity.y += speed_addition
		
	if position.x < margin.x:
		velocity.x = -velocity.x # bounce of left wall
	elif position.x > screen_size.x - margin.x: #dont check for right wall if left
		velocity.x = -velocity.x # bounce of right
	
	if position.y < margin.y:
		velocity.y = -velocity.y # bounce of top	
	elif position.y > screen_size.y - margin.y:
		game_over.emit()
		velocity = Vector2.ZERO

func _process(delta: float) -> void:
	if velocity.x > max_x:
		velocity.x = max_x
	if velocity.y > max_y:
		velocity.y = max_y
		
func start():
	position = Vector2(screen_size.x/2, screen_size.y/start_factor_y)
	velocity = Vector2(0, -500)
	
