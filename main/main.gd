extends Control

var zoom_level: float = 1.5
var loupe_screen_ratio: float = 0.40

const INSPECT_MODE_CARD_SCENE : PackedScene = preload("res://civilizations/CivCard.tscn")

@onready var mood_tokens: Token = %MoodTokens
@onready var culture_tokens: Token = %CultureTokens

# Zoom references (Layer 100)
@onready var magnifier_container: SubViewportContainer = $ZoomLayer/MagnifierContainer
@onready var magnifier_viewport: SubViewport = $ZoomLayer/MagnifierContainer/MagnifierViewport
@onready var magnifier_camera: Camera2D = $ZoomLayer/MagnifierContainer/MagnifierViewport/MagnifierCamera

# Inspect Modal references (Layer 50)
@onready var inspect_modal: Control = %InspectModal
@onready var inspect_leaders_row: HBoxContainer = %LeadersRow
@onready var inspect_dimmer: ColorRect = %Dimmer

func _ready() -> void:
	init_tokens()
	init_magnifier()
	init_inspect_modal()
	get_viewport().size_changed.connect(_update_magnifier_size)

func init_tokens() -> void:
	mood_tokens.token_type = mood_tokens.TokenType.MOOD
	culture_tokens.token_type = culture_tokens.TokenType.CULTURE

func init_magnifier() -> void:
	magnifier_container.visible = false
	magnifier_camera.zoom = Vector2(zoom_level, zoom_level)
	magnifier_viewport.world_2d = get_viewport().find_world_2d()
	_update_magnifier_size()

func init_inspect_modal() -> void:
	inspect_modal.visible = false
	inspect_dimmer.gui_input.connect(func(event: InputEvent) -> void:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			close_inspect_modal()
	)

func open_inspect_modal(civ_key: String) -> void:
	var civ_data: Dictionary = CivData.get_civ_tech_board_and_leaders(civ_key)
	if civ_data.is_empty():
		return

	for child in inspect_leaders_row.get_children():
		child.queue_free()
		

	var civ_board : TextureRect = INSPECT_MODE_CARD_SCENE.instantiate()
	civ_board.texture = civ_data.get("tech_board", null)
	inspect_leaders_row.add_child(civ_board)
	
	for leader_tex: Texture2D in civ_data.get("leaders", []):
		var card : TextureRect = INSPECT_MODE_CARD_SCENE.instantiate()
		card.texture = leader_tex
		inspect_leaders_row.add_child(card)

	
	inspect_modal.visible = true

func close_inspect_modal() -> void:
	inspect_modal.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		magnifier_container.visible = event.pressed
		
	if inspect_modal.visible and event.is_action_pressed("ui_cancel"):
		print("Nein")
		close_inspect_modal()
		get_viewport().set_input_as_handled()

func _update_magnifier_size() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	var base_dimension: float = minf(viewport_size.x, viewport_size.y)
	var diameter: float = round(base_dimension * loupe_screen_ratio)
	var new_size := Vector2(diameter, diameter)

	magnifier_viewport.size = Vector2i(new_size)
	magnifier_container.custom_minimum_size = new_size
	magnifier_container.size = new_size

func _process(_delta: float) -> void:
	if not magnifier_container.visible:
		return

	var viewport_rect: Rect2 = get_viewport_rect()
	var mouse_screen_pos: Vector2 = get_viewport().get_mouse_position()
	
	var target_pos: Vector2 = mouse_screen_pos - (magnifier_container.size * 0.5)
	var max_pos: Vector2 = viewport_rect.size - magnifier_container.size
	target_pos.x = clampf(target_pos.x, 0.0, max_pos.x)
	target_pos.y = clampf(target_pos.y, 0.0, max_pos.y)

	magnifier_container.global_position = target_pos
	magnifier_camera.global_position = get_global_mouse_position()
