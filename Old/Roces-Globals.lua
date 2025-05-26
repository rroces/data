-- Rings = S{'Capacity Ring', 'Warp Ring', 'Trizek Ring', 'Expertise Ring', 'Emperor Band', 'Caliber Ring', 'Echad Ring', 'Facility Ring'}
sets.reive = {neck="Ygnas's Resolve +1"}
-- sets.crafting = { body="Alchemist's Apron", sub="Brewer's Scutum", head="Midras's Helm +1", main="Caduceus", neck="Alchemist's Torque", ring1="Craftmaster's ring", ring2="Orvail Ring" }

equip_lock = S{
    "Warp Ring",
    "Capacity Ring",
    "Vocation Ring",
    "Trizek Ring",
    "Endorsement Ring"
}
-- function user_handle_equipping_gear(status, eventArgs)
--     if equip_lock:contains(player.equipment.right_ring) then
--         disable('ring2')
--     else
--         enable('ring2')
--     end
-- end

function user_post_precast(spell, action, spellMap, eventArgs)
    -- reive mark
	if spell.type:lower() == 'weaponskill' then
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end
end

 function user_post_aftercast(spell, action, spellMap, eventArgs)
     if spell.type:lower() == 'weaponskill' then
         send_command('wait 1; input /echo ---------------- TP <tp> ----------------')
     end
 end

function user_customize_melee_set(meleeSet)
    if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, sets.reive)
    end
    return meleeSet
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
    return idleSet
end
-- function user_buff_change(buff, gain, eventArgs)
--     -- Sick and tired of rings being unequip when you have 10,000 buffs being gain/lost?  
--     if not gain then
--         if Rings:contains(player.equipment.ring1) or Rings:contains(player.equipment.ring2) then
--             eventArgs.handled = true
--         end
--     end
-- end
function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end

   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end

end

function define_global_sets()

   

    gear.GEO_Cure_Cape = {name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Spell interruption rate down-10%',}} --**-
    gear.GEO_FC_Cape = {name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}} --*--
    gear.GEO_Idle_Cape = {name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}} --**--
    gear.GEO_MAB_Cape = {name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}} --**
    gear.GEO_Pet_Cape = {name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}} --**--
	gear.Gada_ENF = {name="Gada", augments={'Enmity-4','MND+7','Mag. Acc.+22','"Mag.Atk.Bns."+20',}}
    gear.Gada_ENH = {name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+11',}}
    gear.Gada_GEO = {name="Gada", augments={'Indi. eff. dur. +11','DMG:+4',}}
	
end

