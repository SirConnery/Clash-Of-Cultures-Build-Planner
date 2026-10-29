extends Control
class_name ResourceTrack

@onready var slots: Array[Control] = [
	%Slot0,
	%Slot1,
]

@onready var stacks: Array[GridContainer] = [
	%Slot0/Stack,
	%Slot1/Stack,
]

func _ready() -> void:
	# Ensure the track catches drops, while child slots/stacks ignore
	# the mouse so they don't intercept the drop before this script can see it
	mouse_filter = Control.MOUSE_FILTER_STOP
	for slot in slots:
		slot.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for stack in stacks:
		stack.mouse_filter = Control.MOUSE_FILTER_IGNORE

func add_token(slot_index: int, token: Control) -> void:
	if slot_index < 0 or slot_index >= stacks.size():
		push_error("ResourceTrack: Invalid slot index %d" % slot_index)
		return

	if token.get_parent():
		token.get_parent().remove_child(token)

	token.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	token.size_flags_vertical = Control.SIZE_SHRINK_CENTER

	# Ensure the token is fully visible when added to the slot
	token.modulate.a = 1.0

	stacks[slot_index].add_child(token)

func remove_token(slot_index: int, token: Control) -> void:
	if slot_index >= 0 and slot_index < stacks.size():
		if token.get_parent() == stacks[slot_index]:
			stacks[slot_index].remove_child(token)

func get_tokens(slot_index: int) -> Array[Node]:
	if slot_index >= 0 and slot_index < stacks.size():
		return stacks[slot_index].get_children()
	return []

func get_token_count(slot_index: int) -> int:
	if slot_index >= 0 and slot_index < stacks.size():
		return stacks[slot_index].get_child_count()
	return 0

func clear_slot(slot_index: int) -> void:
	if slot_index >= 0 and slot_index < stacks.size():
		for token in stacks[slot_index].get_children():
			token.queue_free()

#region Drag and Drop Target
func _get_slot_index_under_point(global_point: Vector2) -> int:
	for i in range(slots.size()):
		if slots[i].get_global_rect().has_point(global_point):
			return i
	return -1

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if not (data is Dictionary and data.get("type") == "resource_token"):
		return false
	return _get_slot_index_under_point(get_global_mouse_position()) != -1

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var target_slot: int = _get_slot_index_under_point(get_global_mouse_position())
	if target_slot != -1 and data.has("node") and data["node"] is Control:
		add_token(target_slot, data["node"])
#endregion
