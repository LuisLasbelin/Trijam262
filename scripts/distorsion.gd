extends Sprite2D

# Que yo sepa el ready sirve para cuando crees el nodo, si necesitas inicializarlo de otro modo, eso debe de ir a parte de el process
# El process es para que se anime, dejalo como esta

# La amplitud es la cantidad de ondas que hay
@export var aMin = 3.0 # Amplitud minima
@export var aMax = 0.6 # Amplitud maxima

var long = 2.5 # No tocar, es cuanto tarda en disiparse
@export var velocidad = 1.0 # Velocidad del shader

var momento = 0.0 # Momento de la animacion

# Called when the node enters the scene tree for the first time.
func _ready():
	var amplitud = lerp(aMin, aMax, momento)
	material.set_shader_parameter("amplitud", amplitud)
	material.set_shader_parameter("momento", momento)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var amplitud = lerp(aMin, aMax, momento / long)
	material.set_shader_parameter("amplitud", amplitud)
	material.set_shader_parameter("momento", momento)
	momento += delta * long * velocidad
	if momento >= 2.5:
		self.queue_free()
