extends CharacterBody2D


const SPEED = 50.0
var player = null
var life:int = 5
var playerCol:bool = false
var damage:int = 3
var canMove:bool = true;
@onready var animations = $AnimatedSprite2D

#Pillamos el nodo del jugador desde que comienza el juego.
func _ready():
	player = get_node("/root/platform/Player/player")

#Personalizamos el script inicial para poder movernos en todas las direcciones.
func _physics_process(delta):
	if player != null and canMove:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		animations.play("run")
		if velocity.x > 0:
			animations.flip_h = false
		else:
			animations.flip_h = true
		move_and_slide()
		Death()
	else:
		animations.play("default")

#Le quita la vida al jugador y lo imprime en consola
func Attack(player: CharacterBody2D, damage: int) -> void:
	if player != null:
		player.life -= damage
		print(player.life)
		$Timer.start()
	else:
		return

func Death() -> void:
	if life <= 0:
		queue_free()

#LLama a la función de atacar al jugador
func _on_area_2d_body_entered(body):
	if body.name == "player":
		canMove = false
		playerCol = true;
		Attack(body, damage)
	else:
		return

func _on_timer_timeout():
	if playerCol and player != null:
		Attack(player, damage)
	else:
		return

func _on_area_2d_body_exited(body):
	if body.name == "player":
		canMove = true;
		playerCol = false;
		
