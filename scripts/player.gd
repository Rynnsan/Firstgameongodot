extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Yerçekimi ekle
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Zıplama kontrolü
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Giriş yönünü al (sağ: 1, sol: -1, durma: 0)
	var direction := Input.get_axis("move_left", "move_right")
	
	# Karakterin yönünü çevirme (Flip)
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# --- ANİMASYON KONTROLÜ (DÜZELTİLEN KISIM) ---
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		# Eğer AnimatedSprite2D içinde "jump" animasyonun varsa burayı kullanabilirsin
		# Yoksa bu satırı silebilirsin.
		animated_sprite_2d.play("jump") 
	# --------------------------------------------

	# Hareket ve yavaşlama
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
