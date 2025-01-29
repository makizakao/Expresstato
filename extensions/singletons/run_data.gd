extends "res://singletons/run_data.gd"

var mod_tracked_items = {
}

func _ready() -> void :
	if DebugService.unlock_all_challenges:
		for chal in ChallengeService.challenges:
			ChallengeService.complete_challenge(chal.my_id)
	if DebugService.reinitialize_store_data:
		Platform.reinitialize_store_data()
	init_tracked_items.merge(mod_tracked_items)
	dummy_player_effects = PlayerRunData.init_effects()
	dummy_player_remove_speed_data = init_remove_speed_data(DUMMY_PLAYER_INDEX)
