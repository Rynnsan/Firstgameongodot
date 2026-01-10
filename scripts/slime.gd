extends Node2D

@export var speed: float = 60.0
var direction: int = 1 # 1 sağ, -1 sol

@onready var ray_right = $RayCastRight
@onready var ray_left = $RayCastLeft
@onready var sprite = $AnimatedSprite2D

func _process(delta):
	# Hareket: Her karede hızı ve yönü ekle
	position.x += speed * direction * delta
	
	# Duvar Kontrolü
	if direction == 1: # Sağa giderken
		if ray_right.is_colliding(): # Sağdaki ışın duvara çarptı mı?
			flip()
	else: # Sola giderken
		if ray_left.is_colliding(): # Soldaki ışın duvara çarptı mı?
			flip()

func flip():
	direction *= -1
	# Görseli döndür (Görselin sağa baktığını varsayıyorum)
	if direction == 1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
