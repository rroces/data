-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Kendatsuba', 'Hybrid', 'Mpaca')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'HP')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
	send_command('@wait 8;input /lockstyleset 98')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}
    sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
    sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

    sets.precast.JA['Chi Blast'] = {
        head="Melee Crown +2",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",
        back="Tuilha Cape",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}

    sets.precast.JA['Chakra'] = {ammo="Iron Gobbet",
        head="Felistris Mask",
        body="Anchorite's Cyclas +1",hands="Hesychast's Gloves +1",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Qaaxo Tights",feet="Thurandaut Boots +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Qaaxo Tights",feet="Otronif Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}


    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Thew Bomblet",
        head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Caudata Belt",legs="Quiahuiz Trousers",feet="Manibozho Boots"}
    sets.precast.WSAcc = {ammo="Honed Tathlum",body="Manibozho Jerkin",back="Letalis Mantle",feet="Qaaxo Leggings"}
    sets.precast.WSMod = {ammo="Tantra Tathlum",head="Felistris Mask",legs="Hesychast's Hose +1",feet="Daihanshi Habaki"}
    sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.
    
    -- legs={name="Quiahuiz Trousers", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8'}}}

    sets.precast.WS['Raging Fists']    =  {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet="Mpaca's Boots",
		}
		
    sets.precast.WS['Howling Fist']    =  {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		ear2="Moonshade Earring",
		back="Sacro Mantle",
		}
		
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {
        ear1="Bladeborn Earring",ear2="Moonshade Earring",ring2="Spiral Ring",back="Buquwik Cape"})
		
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",ring1="Spiral Ring",back="Buquwik Cape",feet="Qaaxo Leggings"})
		
    sets.precast.WS["Victory Smite"]   =  {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Odr earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Ilabrat Ring",
		ring2="Niqmaddu Ring",
		back="Sacro Mantle",
	}
	
    sets.precast.WS['Shijin Spiral']   =  {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Ilabrat Ring",
		ring2="Niqmaddu Ring",
	}
	
    sets.precast.WS['Dragon Kick']    = {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Ilabrat Ring",
		ring2="Niqmaddu Ring",
		}
		
    sets.precast.WS['Tornado Kick']    = {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Ilabrat Ring",
		ring2="Niqmaddu Ring",
		}
		
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
        head="Felistris Mask",ear1="Bladeborn Earring",ear2="Steelflash Earring"})

   


    sets.precast.WS['Cataclysm'] = {
        head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Wayfarer Robe",hands="Otronif Gloves",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Whirlpool Mask",ear2="Loquacious Earring",
        body="Otronif Harness +1",hands="Thaumas Gloves",
        waist="Black Belt",feet="Otronif Boots +1"}
        
    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Whirlpool Mask",ear2="Loquacious Earring",
        body="Otronif Harness +1",hands="Thaumas Gloves",
        waist="Black Belt",legs="Qaaxo Tights",feet="Otronif Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        body="Hesychast's Cyclas",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		ear1="Eabani Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back="Moonlight Cape",
	}
	
    sets.idle.Town = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		ear1="Eabani Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back="Moonlight Cape",
	}
    
    sets.idle.Weak = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Bloodgem Earring",
        body="Hesychast's Cyclas",hands="Hesychast's Gloves +1",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Iximulew Cape",waist="Black Belt",legs="Qaaxo Tights",feet="Herald's Gaiters"}
    
    -- Defense sets
    sets.defense.PDT = {
	    ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		ear1="Eabani Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back="Moonlight Cape",
	}

    sets.defense.HP = {ammo="Iron Gobbet",
        head="Uk'uxkaj Cap",neck="Lavalier +1",ear1="Brutal Earring",ear2="Bloodgem Earring",
        body="Hesychast's Cyclas",hands="Hesychast's Gloves +1",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Shadow Mantle",waist="Black Belt",legs="Hesychast's Hose +1",feet="Hesychast's Gaiters +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Uk'uxkaj Cap",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Anchorite's Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Black Belt",legs="Qaaxo Tights",feet="Daihanshi Habaki"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged.Hybrid = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Malignance Chapeau",
		body="Ken. Samue +1",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
	
    sets.engaged.Kendatsuba = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
		
    sets.engaged.Mpaca = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
	
	

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Thew Bomblet",
        head="Uk'uxkaj Cap",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Iximulew Cape",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Otronif Boots +1"}
    sets.engaged.Counter = {ammo="Thew Bomblet",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="K'ayres Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}
    sets.engaged.Mpaca.Counter = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +2"})
    sets.engaged.Mpaca.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Mpaca.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +2"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +2"})
    sets.engaged.Mpaca.Counter.HF = set_combine(sets.engaged.Mpaca.Counter)
    sets.engaged.Mpaca.Counter.HF.Impetus = set_combine(sets.engaged.Mpaca.Counter, {body="Bhikku Cyclas +2"})
	sets.engaged.Kendatsuba.Impetus = set_combine(sets.engaged.Mpaca, {
		head="Ken. Jinpachi +1",
		body="Bhikku Cyclas +2",
		feet="Malignance Boots",
		})
	sets.engaged.Hybrid.Impetus = set_combine(sets.engaged.Kendatsuba.Impetus)
	sets.engaged.Mpaca.Impetus = set_combine(sets.engaged.Kendatsuba.Impetus)


    -- Footwork combat form
    sets.engaged.Footwork = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
    sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {
		ammo="Coiste Bodhar",
		body="Bhikku Cyclas +2",
		}
    sets.footwork_kick_feet = {feet="Anchorite's Gaiters +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            equip(sets.impetus_body)
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
		-- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end

