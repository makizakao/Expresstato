extends "res://singletons/player_run_data.gd"

static func init_effects()->Dictionary:
	var mod_effects = {
	}
	var effects = .init_effects()
	effects.merge(mod_effects)
	return effects
