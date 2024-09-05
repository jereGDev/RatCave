extends Control

#Aquí accedemos al nodo hijo, en este caso un label;
@onready var label: Label = $Label

func _ready() -> void:
	#label.text = "Hola mi amigo" Aquí cambiamos el valor del label;
	pass

func _input(event) -> void:
	label.text = str(event);
