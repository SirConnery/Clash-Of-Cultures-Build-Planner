extends Button
class_name TechSlot

enum RewardType { NONE, MOOD, CULTURE }

signal slot_toggled(reward: RewardType, is_active: bool)

var reward_type: RewardType = RewardType.NONE
var is_unlocked: bool = false

func _ready() -> void:
	pressed.connect(_on_slot_clicked)

func _on_slot_clicked() -> void:
	is_unlocked = not is_unlocked
	slot_toggled.emit(reward_type, is_unlocked)
