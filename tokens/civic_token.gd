extends VBoxContainer
class_name CivicToken

enum TokenType { NONE, MOOD, CULTURE }

const TEXTURE_MOOD = preload("res://assets/img/tokens/mood_token_happy_1.webp")
const TEXTURE_CULTURE = preload("res://assets/img/tokens/culture_token_1.webp")

var token_type: TokenType = TokenType.NONE:
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
	subtract.pressed.connect(_on_subtract_pressed)
	add.pressed.connect(_on_add_pressed)
	update_visuals()

func _on_subtract_pressed() -> void:
	G_EventBus.civic_token_change_requested.emit(token_type, -1)

func _on_add_pressed() -> void:
	G_EventBus.civic_token_change_requested.emit(token_type, 1)

func update_visuals() -> void:
	update_label()
	update_texture()

func update_label() -> void:
	amount_label.text = str(total_amount)

func update_texture() -> void:
	match token_type:
		TokenType.MOOD:
			texture_rect.texture = TEXTURE_MOOD
		TokenType.CULTURE:
			texture_rect.texture = TEXTURE_CULTURE
		TokenType.NONE, _:
			texture_rect.texture = null

# Main commands these directly
func add_token() -> void:
	if token_type != TokenType.NONE:
		total_amount += 1

func subtract_token() -> void:
	if token_type != TokenType.NONE:
		total_amount -= 1
