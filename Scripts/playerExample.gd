extends CharacterBody2D

var velocidad: int=500;
var directionx = null;
var directiony = null;

func _physics_process(delta):
	directionx = Input.get_axis("ui_left", "ui_right")
	directiony= Input.get_axis("ui_up", "ui_down")
	velocity.x = directionx * velocidad;
	velocity.y = directiony * velocidad;

#Llamamos esta función para que los valores de X e Y no se sumen al ir inclinados
	velocity.normalized();
#Esta funcion es necesaria para poder mover al personaje.
	move_and_slide();
