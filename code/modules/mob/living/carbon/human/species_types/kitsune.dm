//Subtype of human
/datum/species/human/kitsune
	name = "kitsune"
	id = SPECIES_KITSUNE
	say_mod = "geckers"
	limbs_id = "human"

	mutant_bodyparts = list("tail_human" = "Fox", "ears" = "Fox", "wings" = "None")

	mutantears = /obj/item/organ/ears/fox
	mutant_organs = list(/obj/item/organ/tail/kitsune)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/felinid
	disliked_food = GROSS | RAW | CLOTH
	liked_food = FRIED
	payday_modifier = 0.80

/datum/species/human/kitsune/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/kitsune/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/human/kitsune/can_wag_tail(mob/living/carbon/human/H)
	return mutant_bodyparts["tail_human"] || mutant_bodyparts["waggingtail_human"]

/datum/species/human/kitsune/is_wagging_tail(mob/living/carbon/human/H)
	return mutant_bodyparts["waggingtail_human"]

/datum/species/human/kitsune/start_wagging_tail(mob/living/carbon/human/H)
	if(mutant_bodyparts["tail_human"])
		mutant_bodyparts["waggingtail_human"] = mutant_bodyparts["tail_human"]
		mutant_bodyparts -= "tail_human"
	H.update_body()

/datum/species/human/kitsune/stop_wagging_tail(mob/living/carbon/human/H)
	if(mutant_bodyparts["waggingtail_human"])
		mutant_bodyparts["tail_human"] = mutant_bodyparts["waggingtail_human"]
		mutant_bodyparts -= "waggingtail_human"
	H.update_body()

/datum/species/human/kitsune/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		// Damn you kitsune code, too aggressive
		H.dna.features["ears"] = "kitsune"
		var/obj/item/organ/ears/fox/ears = new
		ears.Insert(H, drop_if_replaced = FALSE)

		if(H.dna.features["tail_human"] == "kitsune")
			var/obj/item/organ/tail/kitsune/tail = new
			tail.Insert(H, special = TRUE, drop_if_replaced = FALSE)
		else
			mutant_organs = list()
	return ..()

/datum/species/human/kitsune/prepare_human_for_preview(mob/living/carbon/human/human)
	human.hairstyle = "Unkept"
	human.hair_color = "#f08e33" // rusty blonde
	human.update_hair()

/datum/species/human/kitsune/get_species_description()
	return "Kitsunes are the second most dominant species in the known galaxy. \
		Their kind extend from Meridiana XIV to the edges of known space."

/datum/species/human/kitsune/get_species_lore()
	return list(
		"Kitsunes are a species of humanoid mammalians most easily identified \
		by their external features closely related to that of Vulpines from Earth. \
		Be it fluffy tails, fuzzy ears, a tendency to gekker... Most Kitsunes exhibit \
		fox-like traits and are usually distinguishable from fox-people thanks to their \
		higher number of tails.",
	)

// kitsunes are subtypes of humans.
// This shouldn't call parent or we'll get a buncha human related perks (though it doesn't have a reason to).
/datum/species/human/kitsune/create_pref_unique_perks()
	var/list/to_add = list(SPECIES_PERK_NAME = "Chain of Command")
	return to_add
