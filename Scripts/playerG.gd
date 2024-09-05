extends CharacterBody2D


const SPEED: float = 300.0;
const JUMP_VELOCITY: float = -400.0;

@onready var animations = $AnimatedSprite2D

var life:int = 10;
var canAttack: bool = true;
var attacking: bool = false;
var enemyCol:bool = false;
var enemy = null
var damage:int = 3
var points:int = 0


func _ready():
	print(life)

#Esta función es una señal
func _on_area_2d_body_entered(body):
	#if body.is_in_group("spike"):
		#life -=20
		#print(life)
	if body.is_in_group("enemies"):
		enemyCol = true
		enemy = body
	print(enemyCol)
	
func _physics_process(delta):
	$CanvasLayer/PlayerLife.text = "Vida:" + str(life)
	$CanvasLayer/EnemiesDefeated.text = "Puntos:" + str(points)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

#Pillamos las direcciones
	var directionx = Input.get_axis("ui_left", "ui_right")
	var directiony = Input.get_axis("ui_up", "ui_down")

#Aplicamos fuerza
	if !attacking:
		if directionx or directiony:
			velocity.x = directionx * SPEED	
			animations.play("run")
			if directionx > 0:
				animations.flip_h = false
			else:
				animations.flip_h = true

			velocity.y = directiony * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			animations.play("default")
		if Input.is_action_just_pressed("ui_accept"):
			attacking = true
		move_and_slide()
		GameOver()
	else:
			animations.play("attack")
			await (animations.animation_finished)
			attacking = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#animations.play("attack")
		if enemy != null and enemyCol == true:
			Attack(enemy, damage)

"""Esta función se encarga de hacer desaparecer el objeto
en este caso al jugador"""
func GameOver() -> void:
	if life <= 0:
		queue_free();


func Attack(enemy, damage) -> void:
	if canAttack:
		enemy.life -= damage;
		if enemy.life <= 0:
			points += 1
		$Timer.start()
		canAttack = false


func _on_timer_timeout():
	canAttack = true;

func _on_area_2d_body_exited(body):
	if body.is_in_group("enemies"):
		enemyCol = false
	print(enemyCol)
