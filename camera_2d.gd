extends Camera2D

@export var max_offset := Vector2(20, 20)
@export var max_rotation := 0.05
@export var trauma_decay := 1.5
@export var base_frequency := 25.0
@export var constant_trauma := 0.0 

var trauma := 0.0
var time := 0.0
var bursts := []

var rng := RandomNumberGenerator.new()

class ShakeBurst:
	var strength: float
	var duration: float
	var decay: float
	var t := 0.0
	
	func _init(s, d, dec):
		strength = s
		duration = d
		decay = dec

func _ready():
	rng.randomize()

func add_burst(strength: float = 1.0, duration: float = 0.3, decay: float = 2.0):
	# strength: 0..1+
	# duration: seconds before decay starts
	bursts.append(ShakeBurst.new(strength, duration, decay))

func set_constant_shake(amount: float):
	constant_trauma = clamp(amount, 0.0, 1.0)

func _process(delta):
	time += delta

	# Decay base trauma
	trauma = max(0.0, trauma - trauma_decay * delta)
	trauma = max(trauma, constant_trauma)

	# Process bursts
	for b in bursts:
		b.t += delta
		if b.t < b.duration:
			trauma = max(trauma, b.strength)
		else:
			b.strength = max(0.0, b.strength - b.decay * delta)
			trauma = max(trauma, b.strength)

	# Remove finished bursts
	bursts = bursts.filter(func(b): return b.strength > 0.0)

	_apply_shake()

func _apply_shake():
	var amt = trauma * trauma   # nonlinear feel
	var freq = base_frequency

	var x = noise(time * freq, 0.0)
	var y = noise(0.0, time * freq)
	var r = noise(time * freq, time * freq)

	offset = Vector2(
		x * max_offset.x * amt,
		y * max_offset.y * amt
	)

	rotation = r * max_rotation * amt

func noise(x, y):
	return rng.randf_range(-1.0, 1.0)
