class_name DiceUtils


static func roll(amount: int, sides: int) -> Array[int]:
	var random = RandomNumberGenerator.new()
	random.randomize()

	var result: Array[int] = []

	for i in range(amount):
		result.append(random.randi_range(1, sides))

	return result
