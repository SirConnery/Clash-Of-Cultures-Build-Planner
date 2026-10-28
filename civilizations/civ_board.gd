extends Control
class_name CivBoard

signal civ_inspected(civ_key: String)

@onready var texture_rect: TextureRect = $TextureRect
@onready var highlight: CardHighlightComponent = $TextureRect/CardHighlightComponent

var civ_name: String = "":
	set(value):
		civ_name = value
		if is_node_ready():
			update_visuals()

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	if texture_rect:
		texture_rect.mouse_filter = Control.MOUSE_FILTER_PASS

	gui_input.connect(_on_gui_input)
	update_visuals()

func update_visuals() -> void:
	if civ_name.is_empty() or not texture_rect:
		return

	var civ_data: Dictionary = CivData.get_civ_tech_board_and_leaders(civ_name)
	if civ_data.has("tech_board"):
		texture_rect.texture = civ_data["tech_board"]

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		civ_inspected.emit(civ_name)

#region Highlight component
func _has_point(point: Vector2) -> bool:
	if highlight:
		return highlight.get_display_rect().has_point(point)
	return Rect2(Vector2.ZERO, size).has_point(point)
