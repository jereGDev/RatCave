extends Node

#Esto permite cargar una escena
@onready var enemy = preload("res://Scenes/EnemyTest.tscn")

@onready var spawn1 = $Spawn1
@onready var spawn2 = $Spawn2
@onready var spawn3 = $Spawn3

func _on_timer_timeout():
	
	#Permite crear un nuevo objeto de tipo enemigo
	var enemyInstance = enemy.instantiate()
	
	#Esto funciona como la funcion Switch de java
	match randi_range(1,3):
		1:
			spawn1.add_child(enemyInstance)
		2:
			spawn2.add_child(enemyInstance)
		3:
			spawn3.add_child(enemyInstance)
	
	
	#Hacemos que aparezca un nuevo enemigo
	spawn1.add_child(enemyInstance)
	#enemyInstance = null;
