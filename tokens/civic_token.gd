extends VBoxContainer
class_name CivicToken

enum TokenType { MOOD, CULTURE }

const TEXTURE_MOOD = preload("res://assets/img/tokens/mood_token_happy_1.webp")
const TEXTURE_CULTURE = preload("res://assets/img/tokens/culture_token_1.webp")

var token_type: TokenType = TokenType.MOOD:
	set(value):
		token_type = value
		if is_node_ready():
			update_texture()

var total_amount := 0:
	set(value):
		total_amount = maxi(0, value)
		if is_node_ready():
			update_label()

@onready var amount_label: Label = %Amount
@onready var texture_rect: TextureRect = %TextureRect
@onready var subtract: Button = %Subtract
@onready var add: Button = %Add

func _ready() -> void:
	#update_visuals()
	subtract.pressed.connect(subtract_token)
	add.pressed.connect(add_token)

func update_visuals() -> void:
	update_label()
	update_texture()

func update_label() -> void:
	amount_label.text = str(total_amount)

func update_texture() -> void:
	texture_rect.texture = TEXTURE_MOOD if token_type == TokenType.MOOD else TEXTURE_CULTURE

func add_token() -> void:
	total_amount += 1

func subtract_token() -> void:
	total_amount -= 1
