extends ColorRect
class_name CollectPanel

signal resource_gain_requested(type: ResourceToken.ResourceType, amount: int)

const RESOURCES: Array[Dictionary] = [
	{ "type": ResourceToken.ResourceType.FOOD,  "name": "Food",  "icon": preload("res://assets/img/tokens/food_token.webp") },
	{ "type": ResourceToken.ResourceType.WOOD,  "name": "Wood",  "icon": preload("res://assets/img/tokens/wood_token.webp") },
	{ "type": ResourceToken.ResourceType.ORE,   "name": "Ore",   "icon": preload("res://assets/img/tokens/ore_token.webp") },
	{ "type": ResourceToken.ResourceType.IDEAS, "name": "Ideas", "icon": preload("res://assets/img/tokens/idea_token.webp") },
	{ "type": ResourceToken.ResourceType.GOLD,  "name": "Gold",  "icon": preload("res://assets/img/tokens/gold_token.webp") },
]

@onready var panel_container: PanelContainer = %PanelContainer
@onready var grid: GridContainer = %ResourceGrid
@onready var close_button: Button = %CloseButton

func _ready() -> void:
	visible = false
	close_button.pressed.connect(hide)
	_build_buttons()

func _build_buttons() -> void:
	for res in RESOURCES:
		var btn := Button.new()
		btn.text = "+1 " + res["name"]
		btn.icon = res["icon"]
		btn.expand_icon = true
		btn.custom_minimum_size = Vector2(140, 48)

		var res_type: ResourceToken.ResourceType = res["type"]
		btn.pressed.connect(func():
			resource_gain_requested.emit(res_type, 1)
			G_EventBus.resource_change_requested.emit(res_type, 1)
		)
		grid.add_child(btn)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not panel_container.get_global_rect().has_point(event.global_position):
			hide()

func open() -> void:
	show()
