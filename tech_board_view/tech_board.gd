extends Control
class_name TechBoard

const SLOT_REWARDS: Dictionary = {
	1: TechSlot.RewardType.NONE,
	2: TechSlot.RewardType.MOOD,
	3: TechSlot.RewardType.MOOD,
	4: TechSlot.RewardType.MOOD,
	5: TechSlot.RewardType.MOOD,
	6: TechSlot.RewardType.NONE,
	7: TechSlot.RewardType.NONE,
	8: TechSlot.RewardType.CULTURE,

	9: TechSlot.RewardType.NONE,
	10: TechSlot.RewardType.NONE,
	11: TechSlot.RewardType.MOOD,
	12: TechSlot.RewardType.CULTURE,
	13: TechSlot.RewardType.CULTURE,
	14: TechSlot.RewardType.MOOD,
	15: TechSlot.RewardType.CULTURE,
	16: TechSlot.RewardType.MOOD,

	17: TechSlot.RewardType.MOOD,
	18: TechSlot.RewardType.CULTURE,
	19: TechSlot.RewardType.NONE,
	20: TechSlot.RewardType.NONE,
	21: TechSlot.RewardType.CULTURE,
	22: TechSlot.RewardType.CULTURE,
	23: TechSlot.RewardType.CULTURE,
	24: TechSlot.RewardType.CULTURE,

	25: TechSlot.RewardType.CULTURE,
	26: TechSlot.RewardType.MOOD,
	27: TechSlot.RewardType.MOOD,
	28: TechSlot.RewardType.MOOD,
	29: TechSlot.RewardType.NONE,
	30: TechSlot.RewardType.NONE,
	31: TechSlot.RewardType.NONE,
	32: TechSlot.RewardType.NONE,

	33: TechSlot.RewardType.CULTURE,
	34: TechSlot.RewardType.NONE,
	35: TechSlot.RewardType.NONE,
	36: TechSlot.RewardType.CULTURE,
	37: TechSlot.RewardType.NONE,
	38: TechSlot.RewardType.NONE,
	39: TechSlot.RewardType.NONE,
	40: TechSlot.RewardType.NONE,

	41: TechSlot.RewardType.MOOD,
	42: TechSlot.RewardType.CULTURE,
	43: TechSlot.RewardType.NONE,
	44: TechSlot.RewardType.MOOD,
	45: TechSlot.RewardType.NONE,
	46: TechSlot.RewardType.NONE,
	47: TechSlot.RewardType.NONE,
	48: TechSlot.RewardType.NONE,
}

func _ready() -> void:
	_init_slots()

func _init_slots() -> void:
	for slot_idx: int in SLOT_REWARDS.keys():
		var slot_node: TechSlot = get_node_or_null("%%TextureRect/TechSlot%d" % slot_idx) as TechSlot
		if not slot_node:
			slot_node = get_node_or_null("TextureRect/TechSlot%d" % slot_idx) as TechSlot

		if not slot_node:
			push_warning("TechBoard: Could not find node TechSlot%d" % slot_idx)
			continue

		slot_node.reward_type = SLOT_REWARDS[slot_idx]
		slot_node.slot_toggled.connect(_on_slot_toggled)

func _on_slot_toggled(reward: TechSlot.RewardType, is_active: bool) -> void:
	if reward == TechSlot.RewardType.NONE:
		return

	var delta: int = 1 if is_active else -1
	var token_type: CivicToken.TokenType = (
		CivicToken.TokenType.MOOD
		if reward == TechSlot.RewardType.MOOD
		else CivicToken.TokenType.CULTURE
	)

	# Emit directly to the global event bus
	G_EventBus.civic_token_change_requested.emit(token_type, delta)
