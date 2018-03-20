note
	description: "Summary description for {MESSAGES_ACCESS}."
	author: "Andres Rojas and Victor Vavan"

expanded class
	MESSAGES_ACCESS

feature -- Constant Messages

	ok: STRING = "ok"

	in_use: STRING = "current tracker is in use"

	non_neg_phase_rad: STRING = "max phase radiation must be non-negative value"

	non_neg_container_rad: STRING = "max container radiation must be non-negative value"

	container_lt_phase: STRING = "max container must not be more than max phase radiation"

	invalid_name_id: STRING = "identifiers/names must start with A-Z, a-z or 0..9"

	phase_id_in_use: STRING = "phase identifier already exists"

	phase_cap_invalid: STRING = "phase capacity must be a positive integer"

	material_missing: STRING = "there must be at least one expected material for this phase"

	phase_id_non_existent: STRING = "phase identifier not in the system"

	cont_id_in_tracker: STRING = "this container identifier already in tracker"

	cont_exceeds_cap: STRING = "this container will exceed phase capacity"

	cont_exceeds_rad: STRING = "this container will exceed phase safe radiation"

	material_unexpected: STRING = "phase does not expect this container material"

	cont_exceeds_rad_cap: STRING = "container radiation capacity exceeded"

	cont_id_not_in_tracker: STRING = "this container identifier not in tracker"

	diff_phase_id: STRING = "source and target phase identifier must be different"

	cont_id_not_in_source: STRING = "this container identifier is not in the source phase"

end
