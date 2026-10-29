extends CenterContainer
class_name ResourceToken

enum ResourceType { FOOD, WOOD, ORE, IDEAS, GOLD }

const RESOURCE_TEXTURES: Array[Texture2D] = [
	preload("res://assets/img/tokens/food_token.webp"),
	preload("res://assets/img/tokens/wood_token.webp"),
	preload("res://assets/img/tokens/ore_token.webp"),
	preload("res://assets/img/tokens/idea_token.webp"),
	preload("res://assets/img/tokens/gold_token.webp")
]

var resource_type: ResourceType = ResourceType.FOOD:
	set(value):
		resource_type = value
		if is_node_ready():
			_update_visuals()

@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	_update_visuals()

func _update_visuals() -> void:
	if texture_rect and resource_type >= 0 and resource_type < RESOURCE_TEXTURES.size():
		texture_rect.texture = RESOURCE_TEXTURES[resource_type]

#region Drag and Drop
func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := TextureRect.new()
	preview.texture = texture_rect.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.custom_minimum_size = custom_minimum_size
	preview.position = -custom_minimum_size * 0.5
	preview.modulate = Color(1.0, 1.0, 1.0, 0.85)

	var preview_root := Control.new()
	preview_root.add_child(preview)
	set_drag_preview(preview_root)

	# Hide original token while dragging
	modulate.a = 0.0

	return {
		"type": "resource_token",
		"node": self,
		"resource_type": resource_type
	}

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate.a = 1.0
#endregion
