extends "res://singletons/player_run_data.gd"

# Modで追加するEffectを登録する
static func init_effects() -> Dictionary:
	var mod_effects = {
		"expresstato_character_effect": 0,
		"add_from_weapon": 0,
		"path_effect": [],
		"trailblazer_effect": []
	}
	var effects = .init_effects()
	effects.merge(mod_effects)
	return effects

# Modで追加するステータスを追加する
static func init_stats(all_null_values: bool = false) -> Dictionary:
	var mod_stats = {
		"current_sp": 0,
		"current_shield": 0,
	}
	var stats = .init_stats(all_null_values)
	stats.merge(mod_stats)
	return stats
