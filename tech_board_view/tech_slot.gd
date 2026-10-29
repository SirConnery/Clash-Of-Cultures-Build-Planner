extends Button
class_name TechSlot

signal slot_toggled(reward: RewardType, is_active: bool)

enum RewardType { NONE, MOOD, CULTURE }

var reward_type: RewardType = RewardType.NONE
var is_unlocked: bool = false

@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	pressed.connect(_on_slot_clicked)

func _on_slot_clicked() -> void:
	is_unlocked = not is_unlocked
	slot_toggled.emit(reward_type, is_unlocked)
	
	if is_unlocked:
		color_rect.visible = true
	else:
		color_rect.visible = false
