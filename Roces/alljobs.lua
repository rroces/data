	-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+D ]           Toggle Death Casting Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+P ]           Shock Spikes
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


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

    -- state.CP = M(false, "Capacity Points Mode")

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
        }

    lockstyleset = 10

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal', 'Resistant', 'Spaekona')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line
    include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind !p input /ma "Shock Spikes" <me>')
    send_command('bind @d gs c toggle DeathMode')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ^numpad0 input /Myrkr')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @d')
    -- send_command('unbind @c')
    send_command('unbind @w')
    send_command('unbind ^numpad0')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +3",
        back=gear.BLM_Death_Cape,
        }

    sets.precast.JA.Manafont = {body="Arch. Coat +1"}

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
        ammo="Sapience Orb", --2
        head="Amalric Coif +1", --11
        body="Shango Robe", --13
        hands="Merlinic Dastanas", --6
        legs="Agwu's Slops", --8
        feet="Amalric Nails +1", --6
        neck="Orunmila's Torque", --5
        ear1="Malignance Earring", --4
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Weather. Ring", --5
        back=gear.BLM_FC_Cape, --10
        waist="Embla Sash",
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        back="Perimede Cape",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2={name="Stikini Ring +1", bag="wardrobe4"},})

    sets.precast.FC.DeathMode = {
        ammo="Ghastly Tathlum +1",
        head="Amalric Coif +1", --11
        body="Amalric Doublet +1",
        hands="Merlinic Dastanas", --6
        legs="Volte Brais", --8
        feet="Volte Gaiters", --6
        neck="Orunmila's Torque", --5
        ear1="Etiolation Earring", --1
        ear2="Loquacious Earring", --2
        ring1="Mephitas's Ring +1",
        ring2="Weather. Ring", --5
        back="Bane Cape", --4
        waist="Embla Sash",
        }

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Floestone",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs=gear.Telchine_ENH_legs,
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Epaminondas's Ring",
        ring2="Shukuyu Ring",
        back="Relucent Cape",
        waist="Fotia Belt",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Merlinic Shalwar",
        feet="Merlinic Crackows",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Archon Ring",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
        } -- INT

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands=gear.Telchine_ENH_hands,
        legs="Amalric Slops +1",
        feet="Medium's Sabots",
        neck="Orunmila's Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Mephitas's Ring +1",
        ring2="",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",
        } -- Max MP


    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Sors Shield", --3/(-5)
        ammo="Esper Stone +1", --0/(-5)
        body="Vanya Robe",
        hands=gear.Telchine_ENH_hands, --10
        feet="Medium's Sabots", --12
        neck="Nodens Gorget", --5
        ear1="Mendi. Earring", --5
        ear2="Roundel Earring", --5
        ring1="Lebeche Ring", --3/(-5)
        ring2="Haoma's Ring",
        back="Oretan. Cape +1", --6
        waist="Bishop's Sash",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','VIT+1','Mag. Acc.+17','"Mag.Atk.Bns."+16','DMG:+7',}},
        sub="Genmei Shield",
        head="Vanya Hood",
        body="Vanya Robe",
        hands="Hieros Mittens",
        feet="Vanya Clogs",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        })

    sets.midcast['Enhancing Magic'] = {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','VIT+1','Mag. Acc.+17','"Mag.Atk.Bns."+16','DMG:+7',}},
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +7',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
       hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +7',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','VIT+1','Mag. Acc.+17','"Mag.Atk.Bns."+16','DMG:+7',}},
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +7',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +7',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +7',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +7',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        --feet="Inspirited Boots",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head="Amalric Coif +1",
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Ea Slops +1",
        feet="Skaoi Boots",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Aurist's Cape +1",
        waist="Luminary Sash",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub="Ammurapi Shield",
        waist="Acuity Belt +1",
        }) -- INT/Magic accuracy

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Ea Houppe. +1",
        hands="Raetic Bangles +1",
        legs="Ea Slops +1",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Mani Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        feet="Merlinic Crackows",
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        feet="Volte Gaiters",
        })

    sets.midcast.Death = {
        main=gear.Grioavolr_MB, --5
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Merl_MB_body, --10
        hands="Amalric Gages +1", --(5)
        legs="Amalric Slops +1",
        feet="Merlinic Crackows", --11
        neck="Mizu. Kubikazari", --10
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        ring2="Metamor. Ring +1",
        back=gear.BLM_Death_Cape, --5
        waist="Sacro Cord",
        }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        main=gear.Grioavolr_MB,
        sub="Enki Strap",
        head="Amalric Coif +1",
        waist="Acuity Belt +1",
        })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Merlinic Hood",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.BLM_MAB_Cape,
        waist="Refoccilation Stone",
        }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        main=gear.Grioavolr_MB,
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        legs="Amalric Slops +1",
        feet="Merlinic Crackows",
        back=gear.BLM_Death_Cape,
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        sub="Khonsu",
        ammo="Pemphredo Tathlum",
        legs="Merlinic Shalwar",
        neck="Sanctity Necklace",
        waist="Sacro Cord",
        })

    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        sub="Khonsu",
        ammo="Pemphredo Tathlum",
        body="Spaekona's Coat +2",
        legs="Merlinic Shalwar",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
        ring2="Archon Ring",
        })

    sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        sub="Khonsu",
        head=empty,
        body="Twilight Cloak",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
        }

    -- Idle sets

    sets.idle = {
        main="Daybreak",
        sub="Genmei Shield",
        ammo="Ghastly Tathlum +1",
        head="Volte Beret",
        body="Jhakri Robe +2",
        hands="Raetic Bangles +1",
        legs="Assid. Pants +1",
        feet="Herald's Gaiters",
        neck="Bathy Choker +1",
        ear1="Sanare Earring",
        ear2="Lugalbanda Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Moonlight Cape",
        waist="Carrier's Sash",
        }

    sets.idle.DT = set_combine(sets.idle, {
        main="Daybreak",
        sub="Genmei Shield", --10/0
        ammo="Staunch Tathlum +1", --3/3
        head="Volte Beret",
        body="Mallquis Saio +2", --8/8
        hands="Raetic Bangles +1",
        legs="Assid. Pants +1",
		feet="Herald's Gaiters",
        neck="Loricate Torque +1", --6/6
        ear1="Sanare Earring",
        ear2="Lugalbanda Earring",
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
        })

    sets.idle.ManaWall = {
        feet="Wicce Sabots +3",
        back=gear.BLM_Death_Cape,
        }

    sets.idle.DeathMode = {
        main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        ring2="",
        back=gear.BLM_Death_Cape,
        waist="Shinjutsu-no-Obi +1",
        }

    sets.idle.Town = set_combine(sets.idle, {
        main="Grioavolr", --gear.Grioavolr_MB
        sub="Khonsu",
        head="Wicce Petasos +3",
        body="Wicce Coat +3",
        legs="Wicce Chausses +3",
		hands="Wicce Gloves +3",
        feet="Herald's Gaiters",
        neck="Incanter's Torque",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
        })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.latent_dt = {ear2=""} --Sorcerer's Earring

    sets.magic_burst = {
        head="Ea Hat +1", --7/(7)
        body="Ea Houppe. +1", --9/(9)
        hands="Amalric Gages +1", --(6)
        legs="Ea Slops +1", --8/(8)
        feet="Ea Pigaches +1", --5/(5)
        neck="Mizu. Kubikazari", --10
        ring2="Mujin Band", --(5)
        back=gear.BLM_MAB_Cape, --5
        }

    sets.magic_burst.Resistant = {
        feet="Merlinic Crackows", --11
        neck="Sanctity Necklace",
        }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        main="Maxentius",
        sub="Ammurapi Shield",
        head="Blistering Sallet +1",
        body="Jhakri Robe +2",
        hands="Gazu Bracelets +1",
        legs=gear.Telchine_ENH_legs,
        feet="Battlecast Gaiters",
        neck="Combatant's Torque",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Hetairoi Ring",
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back="Relucent Cape",
        }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

--Luthien

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "11"
MacroBook = "16"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDL','SB','MEVA') -- ACC effects WS and TP modes

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set default mode (TP,ACC,DT)
state.OffenseMode:set('DT')

--Command to Lock Style and Set the correct macros
jobsetup (LockStylePallet,MacroBook,MacroSet)

BlueNuke = S{'Spectral Floe','Entomb', 'Magic Hammer', 'Tenebral Crush','Embalming Earth'}
BlueACC = S{'Cruel Joke','Dream Flower'}
BlueHealing = S{'Magic Fruit','Healing Breeze','Wild Carrot','Plenilune Embrace'}
BlueSkill = S{'Occultation','Erratic Flutter','Nature\'s Meditation','Cocoon','Barrier Tusk','Matellic Body','Mighty Guard'}
BlueTank = S{}

--Weapons specific to Blue Mage
state.WeaponMode:options('Tizona','Almace','Naegling','Black Halo','Cleave','Learning')
state.WeaponMode:set('Tizona')

--Enable JobMode for UI
UI_Name = 'Mode'

--Modes for specific to Blue Mage
state.JobMode:options('AoE','Melee')
state.JobMode:set('Melee')

function get_sets()

	--Set the weapon options.  This is set below in job customization section

	-- Weapon setup
	sets.Weapons = {}
	
	sets.Weapons['Tizona'] = {
		main="Tizona",
		sub="Thibron",
	}
	sets.Weapons['Almace'] = {
		main="Almace",
		sub="Zantetsuken",
	}
		sets.Weapons['Naegling'] = {
		main="Naegling",
		sub="Thibron",
		--sub={ name="Machaera +2", augments={'TP Bonus +1000',}},
	}

	sets.Weapons['Black Halo'] = {
	    main="Maxentius",
		sub="Bunzi's Rod",
	}

	sets.Weapons['Cleave'] = {
		main={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
		sub={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
	}
	
	sets.Weapons['Learning'] = {
		main="Apkallu Scepter",
		sub="Tengu War Fan",
		--sub={ name="Machaera +2", augments={'TP Bonus +1000',}},
	}
	sets.Weapons.Shield = {
		sub="Genmei Shield",
	}

	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	-- Standard Idle set with -DT,Refresh,Regen and movement gear
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Hashishin Mintan +3",
		hands="Hashi. Bazu. +3",
		legs="Hashishin Tayt +3",
		feet="Hashi. Basmak +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.SB = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})

	sets.Movement = {
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}, priority=1},
    }

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	sets.OffenseMode.TP = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Gleti's Mask", augments={'Path: A',}},
		body={ name="Gleti's Cuirass", augments={'Path: A',}},
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Mirage Stole +2",
		waist="Windbuffet Belt +1",
		left_ear="Crep. Earring",
		right_ear={name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Epona's Ring",
		right_ring="Chirich Ring +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.OffenseMode.DT = set_combine ( sets.OffenseMode.TP, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		left_ring="Defending Ring",
		right_ear={name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
	})

	sets.OffenseMode.ACC = set_combine ( sets.OffenseMode.DT,{
	
	})

	sets.OffenseMode.PDL = set_combine ( sets.OffenseMode.DT,{
	
	})

	sets.OffenseMode.MEVA = set_combine ( sets.OffenseMode.DT,{
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Gleti's Mask", augments={'Path: A',}},
		body={ name="Gleti's Cuirass", augments={'Path: A',}},
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Warder's Charm +1",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Eabani Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

	sets.OffenseMode.SB = set_combine ( sets.OffenseMode.TP,{
		left_ring={ name="Chirich Ring +1", bag="wardrobe1", priority=2},
		right_ring={ name="Chirich Ring +1", bag="wardrobe2", priority=1},
	})

	sets.DualWield = {
		left_ear="Eabani Earring",
		waist="Reiki Yotai",
	}


	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
		body="Luhlaza Jubbah +3", -- 9
		hands="Leyline Gloves", -- 8
		legs="Aya. Cosciales +2", --6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, --8
		neck="Orunmila's torque", -- 5
		waist="Witful Belt", --3
		left_ear="Etiolation Earring", --1
		right_ear="Loquac. Earring", --2
		left_ring="Kishar Ring", --4
		right_ring="Weather. Ring +1", --5
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
	} -- 76

	sets.Precast.Blue_Magic = set_combine (sets.Precast.FastCast, {
		body="Hashishin Mintan +3", -- 16
		right_ear="Tuisto Earring",
		back="Perimede Cape",
	})

	-- Job Abilities
	sets.JA = {}
	sets.JA["Azure Lore"] = {hands="Luh. Bazubands +3"}
	sets.JA["Chain Affinity"] = {head="Hashishin Kavuk +3", feet="Assim. Charuqs +3"}
	sets.JA["Burst Affinity"] = {legs="Assimilator's Shalwar +3", feet="Hashishin Basmak +3"}
	sets.JA["Diffusion"] = {feet="Luhlaza Charuqs +3"}
	sets.JA["Efflux"] = {legs="Hashishin Tayt +3"}
	sets.JA["Unbridled Learning"] = {}
	sets.JA["Unbridled Wisdom"] = {}
	
	-- Dancer JA Section

	sets.Flourish = set_combine(sets.Idle.DT, {})
	sets.Jig = set_combine(sets.Idle.DT, { })
	sets.Step = set_combine(sets.OffenseMode.DT, {})
	sets.Samba = set_combine(sets.Idle.DT, {})
	sets.Waltz = set_combine(sets.OffenseMode.DT, {
		ammo="Yamarang", -- 5
		body="Passion Jacket", -- 10
		hands="", -- 5 Slither Gloves +1
		legs="", -- 10 Dashing Subligar
	}) -- 30% Potency


	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})

	sets.Midcast.ACC = set_combine(sets.Idle, {
		ammo="Pemphredo Tathlum",
		head="Hashishin Kavuk +3",
		body="Hashishin Mintan +3",
		hands="Hashi. Bazu. +3",
		legs="Hashishin Tayt +3",
		feet="Hashi. Basmak +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Telos Earring",
		right_ear={ name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Null Shawl",
	})

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = { --Total = 15 merits + 84 gear = 99 - Cap is 105
		ammo="Staunch Tathlum +1", -- 11
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --11
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',},}, -- 20
		feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --16
		waist="Rumination Sash", --10
	}

	-- Cure Set
	sets.Midcast.Cure = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Hashishin Mintan +3",
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +7',}},
		legs="Hashishin Tayt +3",
		feet="",
		neck="Incanter's Torque",
		waist="Gishdubar Sash",
		left_ear="Mendi. Earring",
		right_ear={ name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Lebeche Ring",
		right_ring="Menelaus's Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
    } --35 %

	-- Enhancing Skill
	sets.Midcast.Enhancing = {
	    ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +7',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +7',}},
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=1},
		left_ring={ name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={ name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}

	sets.Midcast.Skill = set_combine(sets.Midcast.Enhancing, { })

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = set_combine(sets.Midcast.Enhancing, {
		left_ring={ name="Stikini Ring +1", bag="wardrobe2"},
		right_ring={ name="Stikini Ring +1", bag="wardrobe3"},
		waist="Siegel Sash",
		neck="Nodens Gorget",
	})

    sets.Midcast["Refresh"] = set_combine(sets.Midcast.Enhancing, {
		waist="Gishdubar Sash"
	})

    sets.Midcast["Aquaveil"] = set_combine(sets.Midcast.Enhancing, {
	})

	sets.Midcast["Feather Tickle"] = set_combine(sets.Midcast.Enhancing, {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Hashishin Mintan +3",
		hands="Hashi. Bazu. +3",
		legs="Hashishin Tayt +3",
		feet="Hashi. Basmak +3",
		neck="Null Loop",
		waist="Witful Belt",
		left_ear="Crep. Earring",
		right_ear={ name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Stikini Ring +1",
		right_ring="Weather. Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})

	sets.Midcast["Reaving Wind"] = set_combine(sets.Midcast.Enhancing, {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Hashishin Mintan +3",
		hands="Hashi. Bazu. +3",
		legs="Hashishin Tayt +3",
		feet="Hashi. Basmak +3",
		neck="Null Loop",
		waist="Witful Belt",
		left_ear="Crep. Earring",
		right_ear={ name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Stikini Ring +1",
		right_ring="Weather. Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})

	sets.Midcast["Cruel Joke"] = set_combine(sets.Midcast.Enhancing, {
	    ammo="Pemphredo Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Crep. Earring",
		right_ear="Hermetic Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})

	sets.Midcast.Nuke = {
		ammo="Pemphredo Tathlum",
		head="Hashishin Kavuk +3",
		body="Hashishin Mintan +3",
		hands="Hashi. Bazu. +3",
		legs="Hashishin Tayt +3",
		feet="Hashi. Basmak +3",
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}

	sets.Blue_MACC = {


	}

	sets.Midcast['Entomb'] = set_combine(sets.Midcast.Nuke, {
		neck="Quanpur Necklace",
	})

	sets.WS = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hashishin Kavuk +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}

	sets.WS['Black Halo'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hashishin Kavuk +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.WS['Expiacion'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hashishin Kavuk +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.WS['Chant du Cygne'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Gleti's Cuirass", augments={'Path: A',}},
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Hashi. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','"Dbl.Atk."+6','STR+7 INT+7',}},
		left_ring="Chirich Ring +1",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	-- Note that the Mote library will unlock these gear spots when used.
	sets.TreasureHunter = {
		waist="Chaac Belt",
		body="Volte Jupon",
		ammo="Per. Lucky Egg",
	}

	sets.Diffusion = {
	    feet={ name="Luhlaza Charuqs +3", augments={'Enhances "Diffusion" effect',}},
	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}
	if spell.type == 'WeaponSkill' then
		if state.OffenseMode.value == "MEVA" then
			equipSet = set_combine(equipSet, { neck="Warder's Charm +1", })
		end
	end
	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)
	if command == 'jobmode' then
		if state.JobMode.value == 'AoE' then
			send_command('input //aset spellset magic;input /macro book 8;wait .1; input /macro set 2')
		else
			send_command('input //aset spellset tp;input /macro book 8;wait .1; input /macro set 1')
		end
	end
end

-- Function is called when the job lua is unloaded
function user_file_unload()

end

function check_buff_JA()
	buff = 'None'
	--local ja_recasts = windower.ffxi.get_ability_recasts()
	return buff
end

function check_buff_SP()
	buff = 'None'
	local sp_recasts = windower.ffxi.get_spell_recasts()
	if not buffactive['Phalanx'] and sp_recasts[517] == 0 and player.mp >= 19 then
		buff = "Metallic Body"
	elseif not buffactive['Aquaveil'] and sp_recasts[55] == 0 and player.mp > 12 then
		buff = "Aquaveil"
	elseif not buffactive['Defense Boost'] and sp_recasts[547] == 0 and player.mp > 10 then
		buff = "Cocoon"
	end
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    SongMode may take one of three values: None, Placeholder, FullLength

    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder

    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.


    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>

    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{"Aeolian Edge"}


    lockstyleset = 11
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponSet = M{['description']='Weapon Set', 'Carnwenhan', 'Twashtar', 'Tauret', 'Naegling'}
    state.WeaponLock = M(false, 'Weapon Lock')
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line
    include('Global-GEO-Binds.lua') -- OK to remove this line

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Blurred Harp +1'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1

    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')

    send_command('bind ^insert gs c cycleback Etude')
    send_command('bind ^delete gs c cycle Etude')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    --send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad7 input /ws "Mordant Rime" <t>')
    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    -- send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        main="Kali", --7
        head="Volte Beret", --6
        body="Inyanga Jubbah +2", --14
        hands="Gende. Gages +1", --7
        legs="Volte Brais", --8
        feet="Volte Gaiters", --6
        neck="Orunmila's Torque", --5
        ear1="Loquac. Earring", --2
        ear2="Etiolation Earring", --1
        ring1="Weather. Ring +1", --5
        ring2="Kishar Ring", --4
        back=gear.BRD_Song_Cape, --10
        waist="Embla Sash", --5
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet="Kaykaus Boots +1", --0/7
        ear2="Mendi. Earring", --0/5
        })

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head="Fili Calot", --14
        body="Brioso Justau. +3", --15
        feet="Bihu Slippers +3", --9
        neck="Loricate Torque +1",
        ear1="Odnowa Earring +1",
        ring2="Defending Ring",
        })

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range=gear.Linos_WS,
        head=gear.Chironic_WSD_head,
        body="Bihu Jstcorps. +3",
        hands=gear.Chironic_WSD_hands,
        legs="Bihu Cannions +3",
        feet="Bihu Slippers +3",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BRD_WS1_Cape,
        waist="Fotia Belt",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        range=gear.Linos_TP,
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Bihu Cuffs +3",
        legs="Zoar Subligar +1",
        feet="Lustra. Leggings +1",
        ear1="Brutal Earring",
        ring1="Begrudging Ring",
        back=gear.BRD_WS2_Cape,
        })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        range=gear.Linos_TP,
        body="Bihu Roundlet +3",
        hands="Bihu Cuffs +3",
        ear1="Brutal Earring",
        ring1="Shukuyu Ring",
        back=gear.BRD_WS2_Cape,
        })

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
        neck="Bard's Charm +2",
        ear2="Regal Earring",
        ring2="Metamor. Ring +1",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        legs="Lustr. Subligar +1",
        feet="Lustra. Leggings +1",
        neck="Bard's Charm +2",
        waist="Grunfeld Rope",
        back=gear.BRD_WS2_Cape,
        })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head=empty;
        body="Cohort Cloak +1",
        legs="Kaykaus Tights +1",
        feet="Volte Gaiters",
        neck="Baetyl Pendant",
        ring2="Shiva Ring +1",
        ear1="Friomisi Earring",
        back="Argocham. Mantle",
        waist="Orpheus's Sash",
        })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        feet="Lustra. Leggings +1",
        neck="Caro Necklace",
        ring1="Shukuyu Ring",
        waist="Sailfi Belt +1",
        back=gear.BRD_WS2_Cape,
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        --body="Ros. Jaseran +1", --25
        hands=gear.Chironic_WSD_hands, --20
        --legs="Querkening Brais" --15
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Carol = {hands="Mousai Gages"}
    sets.midcast.Etude = {head="Mousai Turban"}
    sets.midcast.HonorMarch = {range="Marsyas", hands="Fili Manchettes"}
    sets.midcast.Lullaby = {body="Fili Hongreline +1", hands="Brioso Cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot"}
    sets.midcast.Mambo = {feet="Mousai Crackows"}
    sets.midcast.March = {hands="Fili s"}
    sets.midcast.Minne = {legs="Mou. Seraweels"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Threnody = {body="Mousai Manteel"}
    sets.midcast['Adventurer\'s Dirge'] = {range="Marsyas", hands="Bihu Cuffs +3"}
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes"}
    sets.midcast["Chocobo Mazurka"] = {range="Marsyas"}
	sets.midcast["Knight's Minne"] = { range="Blurred Harp +1"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
        main="Carnwenhan",
        range="Gjallarhorn",
        head="Fili Calot",
        body="Fili Hongreline +1",
        hands="Fili Manchettes",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Odnowa Earring +1",
        ear2="Etiolation Earring",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        waist="Flume Belt +1",
        back=gear.BRD_Song_Cape,
        }

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
        }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {legs="Brioso Cannions +3"})

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = {
        ear1="Gersemi Earring",
        ear2="Darkside Earring",
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        }

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Ammurapi Shield",
        head="Kaykaus Mitra +1", --11
        body="Kaykaus Bliaut +1", --(+4)/(-6)
        hands="Kaykaus Cuffs +1", --11(+2)/(-6)
        legs="Kaykaus Tights +1", --11/(+2)/(-6)
        feet="Kaykaus Boots +1", --11(+2)/(-12)
        neck="Incanter's Torque",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back="Solemnity Cape", --7
        waist="Bishop's Sash",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
        legs="Aya. Cosciales +2",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back=gear.BRD_Song_Cape,
        waist="Bishop's Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        hands="Hieros Mittens",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Fi Follet Cape +1",
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Digni. Earring",
        ear2="Vor Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
        }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        range="Gjallarhorn",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        legs="Nyame Sollerets",
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Moonlight Cape",
        waist="Flume Belt +1",
        }

    sets.idle.DT = {
        range="Gjallarhorn",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        legs="Nyame Sollerets",
        neck="Loricate Torque +1", --6/6
        ear1="Odnowa Earring +1", --3/5
        ear2="Etiolation Earring", --0/3
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring",  --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
        }

    sets.idle.MEva = {
        head="Inyanga Tiara +2", --0/5
        body="Inyanga Jubbah +2", --0/8
        hands="Raetic Bangles +1",
        legs="Inyanga Shalwar +2", --0/6
        feet="Inyan. Crackows +2", --0/3
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1="Purity Ring",
        ring2="Inyanga Ring",
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
        }

    sets.idle.Town = set_combine(sets.idle, {
        range="Gjallarhorn",
        head="Mousai Turban",
        body="Ashera Harness",
        legs="Mou. Seraweels",
        feet="Mousai Crackows",
        neck="Bard's Charm +2",
        ear1="Enchntr. Earring +1",
        ear2="Regal Earring",
        back=gear.BRD_Song_Cape,
        waist="Acuity Belt +1",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        range=gear.Linos_TP,
        head="Volte Tiara",
        body="Ayanmo Corazza +2",
        hands="Raetic Bangles +1",
        legs="Zoar Subligar +1",
        feet=gear.Chironic_QA_feet,
        neck="Bard's Charm +2",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back=gear.BRD_STP_Cape,
        waist="Windbuffet Belt +1",
        }

    sets.engaged.Acc = set_combine(sets.engaged, {
        head="Aya. Zucchetto +2",
        hands="Gazu Bracelet +1",
        feet="Bihu Slippers +3",
        waist="Kentarch Belt +1",
        })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        range=gear.Linos_TP,
        head="Volte Tiara",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelet +1",
        legs="Zoar Subligar +1",
        feet=gear.Chironic_QA_feet,
        neck="Bard's Charm +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back=gear.BRD_DW_Cape, --10
        waist="Reiki Yotai", --7
        } -- 26%

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        head="Aya. Zucchetto +2",
        feet="Bihu Slippers +3",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        range=gear.Linos_TP,
        head="Volte Tiara",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelet +1",
        legs="Zoar Subligar +1",
        feet=gear.Chironic_QA_feet,
        neck="Bard's Charm +2",
        ear1="Eabani Earring", --4
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back=gear.BRD_STP_Cape,
        waist="Reiki Yotai", --7
        }

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW.MaxHaste, {
        head="Aya. Zucchetto +2",
        feet="Bihu Slippers +3",
        ear1="Cessance Earring",
        back=gear.BRD_DW_Cape,
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})
    sets.engaged.DW.Acc.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})

    sets.engaged.Aftermath = {
        head="Volte Tiara",
        body="Ashera Harness",
        hands=gear.Telchine_STP_hands,
        legs="Aya. Cosciales +2",
        feet="Volte Spats",
        neck="Bard's Charm +2",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back=gear.BRD_STP_Cape,
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.Carnwenhan = {main="Carnwenhan", sub="Ternion Dagger +1"}
    sets.Twashtar = {main="Twashtar", sub="Taming Sari"}
    sets.Tauret = {main="Tauret", sub="Ternion Dagger +1"}
    sets.Naegling = {main="Naegling", sub="Centovente"}

    sets.DefaultShield = {sub="Genmei Shield"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        --[[ Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then

            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end]]
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
                equip(sets.midcast.SongStringSkill)
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false and (player.sub_job == 'DNC' or player.sub_job == 'NIN') then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end


-- Maedhros

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "19"
MacroBook = "19"
MacroSet = "1"

--Uses Items Automatically
AutoItem = false

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDL','SB','MEVA') -- ACC effects WS and TP modes

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

-- Set to true to run organizer on job changes
Organizer = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set Mode to Damage Taken as Default
state.OffenseMode:set('DT')

--Modes for specific to Ninja
state.WeaponMode:options('Decimation','Pangu','Unlocked', 'Locked')
state.WeaponMode:set('Decimation')

--Enable JobMode for UI.
UI_Name = 'Pet'

--Modes for specific Pets
state.JobMode:options('None','FatsoFargann','ScissorlegXerin','GenerousArthur','BlackbeardRandy','AcuexFamiliar')
state.JobMode:set('FatsoFargann')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	-- This uses a set Jug based off the Pet selected in the "JobMode"
	sets.Jugs = {}
	sets.Jugs['FatsoFargann'] = {ammo="C. Plasma Broth" }
	sets.Jugs['AcuexFamiliar'] = {ammo="Venomous Broth"}
	sets.Jugs['GenerousArthur'] = {ammo="Dire Broth"}
	sets.Jugs['BlackbeardRandy'] = {ammo="Meaty Broth"}
	sets.Jugs['ScissorlegXerin'] = {ammo="Spicy Broth"}

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Decimation'] = {
		main="Dolichenus",
		sub="Ikenga's Axe",
	}

	--sets.Weapons['Pangu'] = {
	--	main="Pangu",
	--	sub="Ikenga's Axe",
	--}

	sets.Weapons.Shield = {
		sub="Sacro Bulwark"
	}
	sets.Weapons.Sleep = {}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Moonlight Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Moonlight Ring", bag="wardrobe4", priority=1},
		back={ name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
    }

	sets.Idle.Pet = set_combine(sets.Idle,{
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
	    right_ear="Nukumi Earring +1",
		right_ring="C. Palug Ring",
		back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	})

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})

	--Used to swap into movement gear when the player is detected movement when not engaged
	sets.Movement = {
		--feet="Hermes' Sandals",
	}

    -- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe2", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Malignance Chapeau",
		body={ name="Gleti's Cuirass", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Crep. Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}

	--Base TP set to build off
	sets.OffenseMode.TP = set_combine (sets.OffenseMode, {})

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine(sets.OffenseMode, {
		body="Malignance Tabard",
		legs="Malignance Tights",
		left_ring={ name="Moonlight Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Moonlight Ring", bag="wardrobe4", priority=1},
		back={ name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode, {})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode,{})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode, {
		neck="Warder's Charm +1",
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	-- Cap is 75% - 50% limit in I or II
	sets.OffenseMode.SB = {}

	sets.DualWield = {
		left_ear="Eabani Earring",
		waist="Reiki Yotai",
	}

	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {}

	sets.Precast.Enmity = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {})

	-- Pet Moves

	-- Default
	sets.Pet_Midcast = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Ferine Earring",
		right_ear="Nukumi Earring +1",
		right_ring="C. Palug Ring",
		back={ name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

	-- TP based Ready moves
	sets.Pet_Midcast.TP = set_combine(sets.Pet_Midcast, {})

	-- Magic Attack Bonus Ready moves
	sets.Pet_Midcast.MAB = set_combine(sets.Pet_Midcast, {})

	-- Debuff moves that need MACC
	sets.Pet_Midcast.MACC = set_combine(sets.Pet_Midcast, {
		ammo={ name="Hesperiidae", augments={'Path: A',}},
		left_ear="Crep. Earring",
		back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	})

	sets.Pet_Midcast.Multi = set_combine(sets.Pet_Midcast, {

	})

	-- Example for a specific move overwrite
	sets.Pet_Midcast['TP Drainkiss'] = set_combine(sets.Pet_Midcast.MACC, { })

	-- Ready JA command
	sets.Ready = {
		hands="Nukumi Manoplas +1",
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
	}

	-- Job Abilities
	sets.JA = {}
	sets.JA['Familiar'] = set_combine(sets.Idle, 
	{
		legs={ name="Ankusa Trousers +3", augments={'Enhances "Familiar" effect',}},
	})
	sets.JA['Charm'] = set_combine(sets.Idle, 
	{
		legs={ name="Ankusa Trousers +3", augments={'Enhances "Familiar" effect',}},
	})
	sets.JA['Gauge'] = set_combine(sets.Idle, {})
	sets.JA['Tame'] = set_combine(sets.Idle, 
	{
		head="Totemic Helm +3",
	})
	sets.JA['Reward'] = set_combine(sets.Idle, 
	{ 
		head="Bison Warbonnet",
		body="Tot. Jackcoat +3",
		legs={ name="Ankusa Trousers +3", augments={'Enhances "Familiar" effect',}},
		feet={ name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}},
		left_ear="Ferine Earring",
		ammo="Pet Food Theta",
	})
	sets.JA['Call Beast'] = set_combine(sets.Idle, 
	{
	    hands={ name="Ankusa Gloves +3", augments={'Enhances "Beast Affinity" effect',}},
	})
	sets.JA['Feral Howl'] = set_combine(sets.Idle, 
	{
	    body={ name="An. Jackcoat +3", augments={'Enhances "Feral Howl" effect',}},
	})
	sets.JA['Unleash'] = set_combine(sets.Idle, {})
	sets.JA['Bestial Loyalty'] = set_combine(sets.Idle, 
	{
		hands={ name="Ankusa Gloves +3", augments={'Enhances "Beast Affinity" effect',}},
	})
	sets.JA['Killer Instinct'] = set_combine(sets.Idle, 
	{
		head={ name="Ankusa Helm +3", augments={'Enhances "Killer Instinct" effect',}},
	})

	-- Pet Commands
	sets.JA['Fight'] = set_combine(sets.Idle, {})
	sets.JA['Heel'] = set_combine(sets.Idle, {})
	sets.JA['Leave'] = set_combine(sets.Idle, {})
	sets.JA['Stay'] = set_combine(sets.Idle, {})
	sets.JA['Snarl'] = set_combine(sets.Idle, {})
	sets.JA['Ready'] = set_combine(sets.Idle, {}) -- This is not called for a Ready Move
	sets.JA['Spur'] = set_combine(sets.Idle, 
	{
		feet="Nukumi Ocreae +1"
	})
	sets.JA['Run Wild'] = set_combine(sets.Idle, {})	

	--Default WS set base
	sets.WS = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Gleti's Mask", augments={'Path: A',}},
		body={ name="Gleti's Cuirass", augments={'Path: A',}},
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Bst. Collar +2",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Nukumi Earring +1",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.WS.SB = set_combine( sets.WS, { -- This maximize SB

	})

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine(sets.WS,{})

	sets.WS.PDL = set_combine(sets.WS,{})

	--WS Sets
	sets.WS["Ragin Axe"] = set_combine(sets.WS,{})
	sets.WS["Smash Axe"] = set_combine(sets.WS,{})
	sets.WS["Gale Axe"] = set_combine(sets.WS,{})
	sets.WS["Avalanche Axe"] = set_combine(sets.WS,{})
	sets.WS["Spinning Axe"] = set_combine(sets.WS,{})
	sets.WS["Rampage"] = set_combine(sets.WS,{})
	sets.WS["Calamity"] = set_combine(sets.WS,{})
	sets.WS["Mistral Axe"] = set_combine(sets.WS,{})
	sets.WS["Decimation"] = set_combine(sets.WS,{})
	sets.WS["Bora Axe"] = set_combine(sets.WS,{})

	sets.TreasureHunter = {

	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}
	if spell.name:contains('Maneuver') then
		equipSet = sets.JA.Maneuver
	elseif spell.type == 'WeaponSkill' then
		if state.OffenseMode.value == "MEVA" then
			equipSet = { neck="Warder's Charm +1", }
		end
	end
	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return choose_gear()
end

-- Called when the pet dies or is summoned
function pet_change_custom(pet,gain)
	equipSet = {}

	return equipSet
end

-- Called during a pet midcast
function pet_midcast_custom(spell)
	equipSet = {}
		local message = 'Pet Not Set'
		if Ready_Standard[spell.name] then
			equipSet = set_combine(equipSet, sets.Pet_Midcast)
			message = 'Pet Standard Set'
		end
		if Ready_TP[spell.name] then
			equipSet = set_combine(equipSet, sets.Pet_Midcast.TP)
			message = 'Pet TP Set'
		end
		if Ready_Magic[spell.name] then
			equipSet = set_combine(equipSet, sets.Pet_Midcast.MAB)
			message = 'Pet Magic Set'
		end
		if Ready_Debuff[spell.name] then
			equipSet = set_combine(equipSet, sets.Pet_Midcast.MACC)
			message = 'Pet Magic Accuracy Set'
		end
		if Ready_Multi[spell.name] then
			equipSet = set_combine(equipSet, sets.Pet_Midcast.Multi)
			message = 'Pet Multi-Attack Set'
		end
		info(message)
	return equipSet
end

-- Called after the performs an action
function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return choose_gear()
end

--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return choose_gear()
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return choose_gear()
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Custom Function
function choose_gear()
	equipSet = {}

	return equipSet
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	-- Sub job has least priority
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

-- This function is called when the job file is unloaded
function user_file_unload()

end

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--[[
    gs c toggle luzaf -- Toggles use of Luzaf Ring on and off
    gs c toggle compensator -- Toggles use of Compensator for rolls on and off. helpful when you don't want to lose TP
    
    This lua assumes you have 3 macros or keybinds to cycle GunMode, ShootingMode, and FightingModes. You may not like this, but
    i find it very convenient to easily switch between weapons / modes while playing COR

    NOTE: GunMode is automatically set to whichever weapon is equipped when this lua is loaded. You can also hit F12 to update it. 

    NOTE: Cycling through Fighting Mode resets Shooting mode, and cycling through Shooting Mode resets Fighting Mode. These two modes 
    do not combine. Only one can be used at a time.  They were broken into two because I got tired of cycling through so many groups.
    NOTE: if you don't like cycles, you can do macro's for specific modes. i.e. - /console gs c set FightingMode Melee  
   
    Fighting Modes
    sets.engaged.Melee applies when Melee or DualSword fighting modes are selected 
    sets.engaged.Sword is a single handed melee mode

    Shooting Modes
    sets.engaged  is used for all these sets.  

    Note: if you want to prevent losing TP when doing rolls, you can toggle compensator mode to off, and set your shooting mode to 'Single'
    this should put your Rollstam in your main hand and keep it there. 

    Aftermath 
    the 'AME' set is used when empyrean aftermath is up 

    Haste modes 
    You are welcome to use Haste_15, and Haste_30 sets, but it's too much hassle so I'm only using the MaxHaste set to take what little few 
    pieces of dual weild gear COR wears off in favor of better pieces
--]]
---------------------------- SET ORDER OF PRECEDENCE ----------------------------------
-- sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]
-- Initialization function for this job file.

send_command('wait 2; input /lockstyleset 25')

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    state.Compensator = M(true, "Compensator")
    state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    state.FlurryMode = M{['description']='Flurry Mode', 'Normal', 'Hi'}
    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Low'}
    
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    
    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
    state.GunSelector = M{['description']='Gun Selector', 'Death Penalty', 'Fomalhaut', 'Armageddon', 'Ataktos', 'Earp'}--, '
    state.FightingMode = M{['description']='Fighting Mode', 'Default', 'Melee', 'Sword', 'DualSword', 'DualDagger','SwordDagger'}
    state.ShootingMode = M{['description']='Shooting Mode', 'Default', 'Shooting', 'Magic', 'Single'}

    cor_sub_weapons = S{"Nusku Shield"}
    auto_gun_ws = "Leaden Salute"
    
    define_roll_values()
    determine_haste_group()
    get_combat_form()
    initialize_weapons()
    get_custom_ranged_groups()
	--no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
      --        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
        --      "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
	
end



-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.RangedMode:options('Normal', 'Mid', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT' )
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')

    
	gear.RAbullet = "Chrono Bullet"
    gear.Accbullet = "Devastating Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet" --Hauksbok Bullet
    options.ammo_warning_limit = 15
	 
	--gear.RAbullet = "Eminent Bullet"
    --gear.Accbullet = "Eminent Bullet"
    --gear.WSbullet = "Eminent Bullet"
    --gear.MAbullet = "Eminent Bullet"
    --gear.QDbullet = "Eminent Bullet" 
    --
	--options.ammo_warning_limit = 15
	
	
	
	
    -- Additional local binds
    -- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
    send_command('bind @f9 gs c cycle OffenseMode')
    send_command('bind !f9 gs c toggle FightingMode')
    send_command('bind f9 gs c cycle GunSelector')
    send_command('bind PAGEDOWN input /ja "Double-up" <me>')
    send_command('bind PAGEUP input /ja "Bolter\'s Roll" <me>')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @= gs c cycle FlurryMode')
    send_command('bind ^PAGEUP gs c cycle AutoRA')
	send_command('bind ^PAGEDOWN input /ja "Tactician\'s Roll" <me>')
	send_command('bind HOME input /equip ring1 "Warp Ring"; input /echo Warping; /input /wait 11 ; input /item "Warp Ring" <me>;')
	send_command('bind ^HOME input /equip ring2 "Dim. Ring (Dem)"; /echo Reisenjima; input /wait 11; input /item "Dim. Ring (Dem)" <me>;')
    select_default_macro_book()
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind !`')
    send_command('unbind ^-')
	send_command('unbind PAGEUP')
	send_command('unbind HOME')
	send_command('unbind ^PAGEUP')
	send_command('unbind ^HOME')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    sets.Obi = { waist="Hachirin-no-Obi" }
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +4"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +4"}
    sets.precast.JA['Fold'] = {hands="Lanun Gants +3"} 
    sets.CapacityMantle = {back="Mecisto. Mantle"}
    
    TaeonHead = {}
    TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}

    Camulus = {}
    Camulus.STP  =  { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Camulus.WSD  =  { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    Camulus.Snap =  { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
    Camulus.MAB  =  { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    Camulus.DA  =  { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}

    --HercFeet = {}
    --HercHead = {}
    --HercLegs = {}
    --HercHands = {}
    --HercBody = {}
    --HercHands.R = { name="Herculean Gloves", augments={'AGI+9','Accuracy+3','"Refresh"+1',}}
    --HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
    --HercBody.MAB = { name="Herculean Vest", augments={'Haste+1','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
    --HercBody.WSD = { name="Herculean Vest", augments={'"Blood Pact" ability delay -4','AGI+3','Weapon skill damage +9%','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
    --HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+30','"Mag.Atk.Bns."+25','Accuracy+3 Attack+3','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
    --HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    --HercHead.MAB = {name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','INT+1','Mag. Acc.+3','"Mag.Atk.Bns."+8',}}
    --HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    --HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}
    --HercLegs.MAB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
	--HercLegs.TH = { name="Herculean Trousers", augments={'Phys. dmg. taken -1%','VIT+10','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}} 
   
    AdhemarLegs = {}
    AdhemarLegs.Snap = { name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    AdhemarLegs.TP = { name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}}

    sets.roll = { 
        head="Lanun Tricorne +3",
        hands="Chasseur's Gants +3",
        ear2="Etiolation Earring",
        neck="Regal Necklace",
        body="Nyame Mail",
        ring1="Dark Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        feet="Lanun Bottes +4",
		legs="Desultor Tassets",
		range="Compensator"
		
    }

    sets.precast.CorsairRoll = set_combine(sets.roll, {
        main={name="Rostam", bag="Wardrobe 4", priority=1},
        sub={name="Tauret", priority=2},
		legs="Desultor Tassets",
    })
    sets.precast.CorsairRoll.Single = set_combine(sets.roll, {
        main={name="Rostam", bag="Wardrobe 4", priority=1},
    })
    
    sets.Nyame = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    }
    
    sets.TreasureHunter = {waist="Chaac Belt"}
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"].Single = set_combine(sets.precast.CorsairRoll.Single, {feet="Chass. Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Tactician's Roll"].Single = set_combine(sets.precast.CorsairRoll.Single, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
    sets.precast.CorsairRoll["Allies' Roll"].Single = set_combine(sets.precast.CorsairRoll.Single, {hands="Chasseur's Gants +3"})
    
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.Compensator = {range="Compensator"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.Melee = {
        --main={name="Rostam", bag="Wardrobe 4", priority=2},
        main={name="Rostam", bag="Inventory", priority=1},
        sub={name="Crepuscular Knife", bag="Inventory", priority=2},
        
    }
    -- sets.Melee.engaged = set_combine(sets.Melee, {
    --     head="Adhemar Bonnet +1",
    --     ear1="Telos Earring",
    --     ear2="Suppanomimi",
    --     neck="Iskur gorget",
    --     hands="Adhemar Wristbands +1",
    --     body="Adhemar Jacket +1",
    --     legs="Meghanada Chausses +2",
    --     ring1="Petrov Ring",
    --     ring2="Epona's Ring",
    --     waist="Shetal Stone",
    --     back=Camulus.DA,
    --     feet=HercFeet.TP
    -- })
    -- sets.Melee.engaged.PDT = set_combine(sets.Melee.engaged, sets.Nyame)
    
    sets.Sword = { 
        main={name="Rostam", bag="Wardrobe8", priority=1},
        sub={name="Nusku Shield", priority=2},
        --ranged=state.GunSelector.current
    }
    -- sets.Sword.engaged = set_combine(sets.Melee, sets.Sword, {
    --     ear2="Cessance Earring",
    --     hands="Adhemar Wristbands +1",
    --     waist="Windbuffet Belt +1",
    -- })
    -- sets.Sword.engaged.PDT = set_combine(sets.Sword.engaged, sets.Nyame)
    sets.DualDagger = { 
        main={name="Rostam", bag="Wardrobe8", priority=1},
        sub={name="Kustawi +1", priority=2},
        --ranged=state.GunSelector.current
    }
	sets.SwordDagger = { 
        main={name="Naegling", bag="Inventory", priority=1},
        sub={name="Tauret", bag="Inventory", priority=2},
        --ranged=state.GunSelector.current
    }
	
	
    sets.DualSword = { 
        main={name="Naegling", bag="Inventory", priority=1},
        sub={name="Crepuscular Knife", bag="Inventory", priority=2},
        --ranged=state.GunSelector.current
    }
    -- sets.DualSword.engaged = set_combine(sets.Melee, sets.DualSword)
    -- sets.DualSword.engaged.PDT = set_combine(sets.DualSword.engaged, sets.Nyame)
    
    sets.Magic = {
        --main={name="Rostam", bag="Wardrobe 4", priority=2},
        main={name="Rostam", bag="Inventory", priority=1},
        sub={name="Tauret", bag="Inventory", priority=2},
        --ranged=state.GunSelector.current
    }
    -- sets.Magic.engaged = sets.Magic
    -- sets.Magic.engaged.PDT = sets.Magic

    sets.DeathPenalty = {
        range="Death Penalty"
    }
    sets.Armageddon = {
        range="Armageddon"
    }
    sets.Fomalhaut = {
        range="Fomalhaut"
    }
    sets.Ataktos = {
        range="Ataktos"
    }
	sets.Earp = {
        range="Earp"
    }
    sets.Shooting = {
        main={name="Rostam", bag="Inventory", priority=2},
        sub={name="Rostam", bag="Wardrobe 4", priority=1},
        ranged=state.GunSelector.current
    }
    -- sets.Shooting.engaged = sets.Shooting
    -- sets.Shooting.engaged.PDT = sets.Shooting

    sets.Single = {
        main={name="Rostam", bag="Wardrobe 4", priority=1},
        sub={name="Nusku Shield", priority=2},
        --ranged=state.GunSelector.current
    }
    -- sets.Single.engaged = sets.Single
    -- sets.Single.engaged.PDT = sets.Single
    -- this allows you to equip any weapon in main + sub without this code forcing other weapons
    sets.Default = {
        --ranged=state.GunSelector.current
    } -- do nothing. useful for equipping whateveer you want
    -- sets.Default.engaged = sets.Default
    -- sets.Default.engaged.PDT = sets.Default

    sets.precast.CorsairShot = { head="Laksa. Tricorne +4" }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Mummu Bonnet +2",
        hands="Meghanada Gloves +2",
        legs=AdhemarLegs.TP,
        body="Passion Jacket",
    }

    sets.Organizer = {
        main="Tauret",
        sub="Fomalhaut",
        range="Death Penalty",
        ear1="Nusku Shield",
        ear2="Armageddon",
        hands="Compensator",
        ammo="Nusku Shield",
        back="",
        waist="Rostam",
        ring1="Naegling", 
        ring2="Ataktos",
        legs="Blurred Knife +1"
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        --ammo="Impatiens",
        head="Carmine Mask +1", --12
        ear1="Loquacious Earring",
        ear2="Enchntr. Earring +1",
		neck="Orunmila's Torque",	
        body="Dread Jupon",
        hands="Leyline Gloves",
		feet="Carmine Greaves +1",
        ring1="Weatherspoon Ring +1",
        ring2="Kishar Ring",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.precast.RA = {
       
        head="Chasseur's Tricorne +3",
        neck="Commodore Charm +2", -- 4
        hands="Lanun Gants +3", -- 13
        back=Camulus.Snap, -- 10 
        body="Oshosi Vest +1", -- 14
        ring1="Crepuscular Ring", -- 3
        waist="Impulse Belt", -- 0 / 5 rapid
        legs=AdhemarLegs.Snap, -- 9  / 10 rapid
        feet="Meghanada Jambeaux +2" -- 10 
    }
    sets.precast.RA.F1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +4",
    })
    sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
        body="Laksa. Frac +4",
        hands="Carmine Finger Gauntlets +1", -- 8 / 11 rapid
        waist="Yemaya Belt",
        -- feet="Pursuer's Gaiters"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",
        --neck="Iskur Gorget",
        neck="Commodore Charm +2",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksa. Frac +4",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back=Camulus.WSD,
        waist="K. Kachina Belt +1",
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +4"
    }
	sets.precast.WS['Terminus'] = set_combine(sets.precast.WS, {
        head="Nyame helm",
        neck={ name="Comm. Charm +2", augments={'Path: A',}},
        body="Ikenga's Vest",
        hands="Chasseur's Gants +3",
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",
        waist="Kentarch Belt +1",
        feet="Lanun Bottes +4",
	    legs="Nyame Flanchard",
		back=Camulus.WSD
		
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Bayeux Bullet",
        head="Nyame helm",
        neck="Rep. Plat. Medal",
        body="Nyame Mail",
        hands="Chasseur's Gants +3",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        waist="Sailfi Belt +1",
        feet="Nyame Sollerets",
	    legs="Nyame Flanchard",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, { 
        head="Adhemar Bonnet +1",
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        body="Adhemar Jacket +1",
        neck="Fotia Gorget",
        hands="Mummu Wrists +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Fotia Belt",
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +4"
    })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		neck="Lissome Necklace",
        ear1="Telos Earring",
        ear2="Crep. Earring",
        ring1="Cacoethic Ring +1",
        ring2="Ilabrat Ring",
        back="Null Shawl",
        waist="Null Belt",
		head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3"})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Telos Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Rufescent Ring",
        waist="Fotia Belt",
    })

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksa. Frac +4",
        ring1="Epaminondas's Ring",
        ring2="Dingir Ring",
        waist="Fotia Belt",
        feet="Lanun Bottes +4",
		legs="Nyame Flanchard",
		hands="Chasseur's Gants +3"
    })
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
        ear1="Beyla Earring",
        ear2="Moonshade Earring",
        back=Camulus.WSD,
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +4"
    })

    sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head="Nyame Helm",
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +4",
        hands="Nyame Gauntlets",
        ring1="Epaminondas's Ring",
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Skrymir Cord +1",
        legs="Nyame Flanchard",
        feet="Lanun Bottes +4"
    }
    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {
        head="Nyame Helm",
        body="Lanun Frac +4",
        hands="Nyame Gauntlets"
    })

    sets.precast.WS['Leaden Salute'] = { 
        ammo=gear.MAbullet,
        head="Pixie Hairpin +1", 
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body="Lanun Frac +4",
        hands="Nyame Gauntlets",
        ring1="Archon Ring",
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Orpheus's Sash",
        legs="Nyame Flanchard",
        feet="Lanun Bottes +4"
    }
    sets.precast.WS['Leaden Salute'].Mid = set_combine(sets.precast.WS['Leaden Salute'], { 
        body="Lanun Frac +4",
        hands="Nyame Gauntlets",
        feet="Lanun Bottes +4"
    })
    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], { 
        body="Lanun Frac +4",
        ear1="Crepuscular Earring",
        hands="Nyame Gauntlets",
        feet="Lanun Bottes +4"
    })
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {
        ear2="Moonshade Earring"
    })
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
        ear2="Moonshade Earring",
		waist="Orpheus's Sash",
		
    })
    
    -- Midcast Sets
    --sets.midcast.FastRecast = {
      --  head="Malignance Chapeau",
        --hands="Malignance Gloves",
        --body="Malignance Tabard",
        --back=Camulus.STP,
        --ring1="Weatherspoon Ring +1",
        --ring2="Kishar Ring",
        --legs="Malignance Tights",
        --feet="Malignance Boots"
    --}
    -- Midcast Sets Sortie
	sets.midcast.FastRecast = {
		ammo="Devastating Bullet",
        neck="Null Loop",
        ear1="Gwati Earring",
        ear2="Chas. Earring +1",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back="Null Shawl",
        waist="Null Belt",
		head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3"
	}
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head="Nyame Helm", --Ikenga's Hat
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +4",
        hands="Carmine Finger Gauntlets +1",
        ring1="Fenrir Ring +1", 
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Skrymir Cord +1",
        legs="Nyame Flanchard",
        feet="Chasseur's Bottes +3"
    }

    sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        body="Lanun Frac +4",
        head="Laksa. Tricorne +4",
        ear1="Crepuscular Earring",
        feet="Malignance Boots"
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,--gear.RAbullet
        neck="Iskur Gorget",
        ear1="Telos Earring",
        ear2="Crep. Earring",
        ring1="Crepuscular Ring",
        ring2="Ilabrat Ring",
        back=Camulus.STP,
        waist="Yemaya Belt",
		head="Ikenga's Hat",
		body="Ikenga's Vest",
		hands="Ikenga's Gloves",
		legs="Chas. Culottes +3",
		feet="Ikenga's Clogs"
        
    }
		sets.midcast.DARK={
        ammo=gear.RAbullet,
        neck="Commodore Charm +2",
        ear1="Telos Earring",
        ear2="Crep. Earring",
        ring1="Crepuscular Ring",
        ring2="Ilabrat Ring",
        back=Camulus.STP,
        waist="Yemaya Belt",
		head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3"
       
    }
    sets.midcast.RA.AME = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
        body="Nisroch Jerkin",
        hands="Chasseur's Gants +3",
        waist="K. Kachina Belt +1",
		legs="Darraigner's Brais",
		ear1="Chas. Earring +1",
        ear2="Odr Earring",
		
    })
    sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
        ear2="Crepuscular Earring",
        body="Malignance Tabard",
    })
    sets.midcast.RA.Mid.AME = set_combine(sets.midcast.RA.Mid, {
        head="Meghanada Visor +2",
        body="Nisroch Jerkin",
        waist="K. Kachina Belt +1",
    })

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, {
        --ring1="Hajduk Ring",
		ammo=gear.Accbullet,
        neck="Iskur Gorget",
        ear1="Telos Earring",
        ear2="Crep. Earring",
        ring1="Crepuscular Ring",
        ring2="Ilabrat Ring",
        back=Camulus.STP,
        waist="Yemaya Belt",
		head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3"
    })
    sets.midcast.RA.Acc.AME = set_combine(sets.midcast.RA.Acc, {
        head="Meghanada Visor +2",
        waist="K. Kachina Belt +1",
    })

    sets.midcast.RA.TripleShot = set_combine(sets.midcast.RA, {
        
    })
    sets.midcast.RA.TripleShot.Mid = set_combine(sets.midcast.RA.Mid, {
        head="Oshosi Mask",
        body="Oshosi Vest +1",
        hands="Lanun Gants +3",
        ring1="Regal Ring",
        legs="Oshosi Trousers",
        feet="Oshosi Leggings"
    })
    sets.midcast.RA.TripleShot.Acc = set_combine(sets.midcast.RA.Acc, {
        ammo=gear.Accbullet,
        head="Malignance Chapeau",
        body="Oshosi Vest +1",
        hands="Lanun Gants +3",
        ring1="Regal Ring",
        feet="Malignance Boots"
    })
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ring2="Paguroidea Ring"}

    -- Idle sets
    sets.idle = {
        --range="Fomalhaut",
        head="Null Masque",
        neck="Rep. Plat. Medal",
        ear1="Genmei Earring",
        ear2="Etiolation Earring",
        --body="Mekosuchinae Harness",
        body="Adamantite Armor",
        hands="Nyame Gauntlets", --Nyame Gauntlets --Regal Gloves
        ring1="Roller's Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Nyame Sollerets"
    }
    sets.idle.Regen = set_combine(sets.idle, {
        head="Null Masque",
        neck="Rep. Plat. Medal",
        ear1="Infused Earring",
        neck="Commodore Charm +2",
        body="Adamantite Armor",
        hands="Regal Gloves", --Nyame Gauntlets
        ring1="Meghanada Ring",
        ring2="Paguroidea Ring"
    })

    sets.idle.Town = {
        ammo=gear.MAbullet,
        head="Lanun Tricorne +3",
        neck="Commodore Charm +2",
        ear1="Telos Earring",
        ear2="Crepuscular Earring",
        body="Laksa. Frac +4",
        hands="Lanun Gants +3",
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        back=Camulus.STP,
        waist="Sailfi Belt +1",
        legs="Carmine Cuisses +1",
        feet="Lanun Bottes +4"
    }
    sets.idle.PDT = set_combine(sets.idle.Town, sets.Nyame)
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, sets.Nyame, {
        neck="Twilight Torque",
        ring2="Patricius Ring",
        ring1="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
    })

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets
    sets.engaged = {
        ammo=gear.RAbullet,
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        ear1="Telos Earring",
    --    ear2="Crepuscular Earring",
		ear2="Suppanomimi",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Epona's Ring",
        ring2="Rajas Ring",
        back=Camulus.STP,
        waist="Sailfi Belt +1",
        legs="Chas. Culottes +3", 
        feet="Malignance Boots",
		
    }
    sets.engaged.PDT = set_combine(sets.engaged, sets.defense.PDT)
   -- TODO: Get rid of haste sets 
    sets.engaged.Melee = set_combine(sets.engaged, {
       ammo=gear.RAbullet,
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        ear1="Telos Earring",
    --    ear2="Crepuscular Earring",
		ear2="Suppanomimi",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Epona's Ring",
        ring2="Rajas Ring",
        back=Camulus.STP,
        waist="Sailfi Belt +1",
        legs="Chas. Culottes +3", 
        feet="Malignance Boots",
    })
    sets.engaged.Melee.Haste_30 = set_combine(sets.engaged.Melee, {
        
        
    })
    sets.engaged.Melee.MaxHaste = set_combine(sets.engaged.Melee.Haste_30, {
        ear1="Telos Earring",
        ear2="Cessance Earring",
        waist="Sailfi Belt +1",
    })
    sets.engaged.Melee.PDT = set_combine(sets.engaged.Melee, {
        head="Nyame Helm",
        body="Nyame Mail",
        legs="Chas. Culottes +3",
        feet="Nyame Sollerets"

    })
    sets.engaged.Melee.PDT.Haste_30 = set_combine(sets.engaged.Melee.Haste_30, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })
    sets.engaged.Melee.PDT.MaxHaste = set_combine(sets.engaged.Melee.MaxHaste, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Chas. Culottes +3",
        feet="Nyame Sollerets"
    })

    sets.engaged.Mid = sets.engaged -- just for shooting
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.defense.PDT)
   
    sets.engaged.Melee.Mid = set_combine(sets.engaged.Melee, {
        neck="Lissome Necklace",
        ring2="Ilabrat Ring"
    })
    sets.engaged.Melee.Mid.Haste_30 = set_combine(sets.engaged.Melee.Mid, {
        
    })
    sets.engaged.Melee.Mid.MaxHaste = set_combine(sets.engaged.Melee.Mid, {
        ear1="Telos Earring",
        ear2="Odr Earring",
        hands="Adhemar Wristbands +1",
    })
    sets.engaged.Melee.Mid.PDT = set_combine(sets.engaged.Melee.Mid, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })
    sets.engaged.Melee.Mid.PDT.Haste_30 = set_combine(sets.engaged.Melee.Mid.Haste_30, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })
    sets.engaged.Melee.Mid.PDT.MaxHaste = set_combine(sets.engaged.Melee.Mid.MaxHaste, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })

    sets.engaged.Acc = {	
	head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Lissome Necklace",
		ear2="Mache Earring +1",
		ear1="Odr Earring",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		waist="Kentarch Belt +1",
		back=Camulus.DA
	}	
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.defense.PDT)

    sets.engaged.Melee.Acc = set_combine(sets.engaged.Melee.Mid, {
        head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Lissome Necklace",
		ear2="Mache Earring +1",
		ring1="Patricius Ring",
		back=Camulus.DA
    })
    sets.engaged.Melee.Acc.Haste_30 = set_combine(sets.engaged.Melee.Acc, {
        waist="Shetal Stone",
		head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Lissome Necklace",
		ear2="Mache Earring +1",
		back=Camulus.DA
    })
    sets.engaged.Melee.Acc.MaxHaste = set_combine(sets.engaged.Melee.Acc, {
        head="Chasseur's Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		legs="Chas. Culottes +3",
		feet="Chass. Bottes +3",
		neck="Lissome Necklace",
		ear2="Mache Earring +1",
		back=Camulus.DA
    })
    sets.engaged.Melee.Acc.PDT = set_combine(sets.engaged.Melee.Acc, sets.Nyame)
    sets.engaged.Melee.Acc.PDT.Haste_30 = set_combine(sets.engaged.Melee.Acc.Haste_30, sets.Nyame)
    sets.engaged.Melee.Acc.PDT.MaxHaste = set_combine(sets.engaged.Melee.Acc.MaxHaste, sets.Nyame)
    
    sets.engaged.Sword = set_combine(sets.engaged, {
		ammo=gear.RAbullet,
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        ear1="Telos Earring",
    --    ear2="Crepuscular Earring",
		ear2="Suppanomimi",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Epona's Ring",
        ring2="Rajas Ring",
        back=Camulus.STP,
        waist="Sailfi Belt +1",
        legs="Chas. Culottes +3", 
        feet="Malignance Boots",
    })
    sets.engaged.Sword.Haste_30 = sets.engaged.Sword
    sets.engaged.Sword.MaxHaste = sets.engaged.Sword
    sets.engaged.Sword.PDT = set_combine(sets.engaged.Sword, sets.Nyame)
    sets.engaged.Sword.PDT.Haste_30 = set_combine(sets.engaged.Sword, sets.Nyame)
    sets.engaged.Sword.PDT.MaxHaste = set_combine(sets.engaged.Sword, sets.Nyame)
    
    sets.engaged.Sword.Mid = set_combine(sets.engaged.Sword, {
        neck="Lissome Necklace",
        ring2="Ilabrat Ring"
    })
    sets.engaged.Sword.Mid.Haste_30 = sets.engaged.Sword.Mid
    sets.engaged.Sword.Mid.MaxHaste = sets.engaged.Sword.Mid
    
    sets.engaged.Sword.Mid.PDT = set_combine(sets.engaged.Sword.Mid, sets.Nyame)
    sets.engaged.Sword.Mid.PDT.Haste_30 = set_combine(sets.engaged.Sword.Mid, sets.Nyame)
    sets.engaged.Sword.Mid.PDT.MaxHaste = set_combine(sets.engaged.Sword.Mid, sets.Nyame)

    sets.engaged.Sword.Acc = set_combine(sets.engaged.Sword.Mid, {
        ear2="Odr Earring",
        feet="Malignance Boots"
    })
    sets.engaged.Sword.Acc.Haste_30 = sets.engaged.Sword.Acc
    sets.engaged.Sword.Acc.MaxHaste = sets.engaged.Sword.Acc
    sets.engaged.Sword.Acc.PDT = set_combine(sets.engaged.Sword.Acc, sets.Nyame)
    sets.engaged.Sword.Acc.PDT.Haste_30 = set_combine(sets.engaged.Sword.Acc, sets.Nyame)
    sets.engaged.Sword.Acc.PDT.MaxHaste = set_combine(sets.engaged.Sword.Acc, sets.Nyame)
end

function get_cor_gearset()
    local set = {}
    if state.FightingMode.current ~= 'Default' then 
       ---------------------------------------
       set = set_combine(sets[state.FightingMode.current], sets[state.GunSelector.current])
       ---------------------------------------
    elseif state.ShootingMode.current ~= 'Default' then 
       ---------------------------------------
       set = set_combine(sets[state.ShootingMode.current], sets[state.GunSelector.current])
       ---------------------------------------
    end
    return set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' then
        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)

        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
    end

    if spell.type:lower() == 'weaponskill' then
        if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return
        
        elseif state.DefenseMode.value ~= 'None' then
            -- Don't gearswap for weaponskills when Defense is on.
            eventArgs.handled = true
        end
    end
    if (spell.type == 'CorsairRoll') then 
        if state.ShootingMode.current == 'Single' then
            classes.CustomClass = 'Single'
        end
    end
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.Compensator.value then
        equip(sets.precast.Compensator)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    local gearset = get_cor_gearset()
    equip(gearset)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
        end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, default_wsmode)
    --if buffactive['Transcendancy'] then
    --	return 'Brew'
    --end
end

function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    local gearset = get_cor_gearset()
    return set_combine(idleSet, gearset)
end

function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    local gearset = get_cor_gearset()
    return set_combine(meleeSet, gearset)
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        get_combat_form()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if not gain and player.equipment.ring1 == 'Warp Ring' then
        equip({ring1="Warp Ring"})
    end

    -- DoubleShot CombatForm
    if (buff == 'Triple Shot' and gain or buffactive['Triple Shot']) then
        windower.send_command('wait 90;input /echo **TRIPLE SHOT OFF**;wait 210;input /echo **TRIPLE SHOT READY**')
        state.CombatForm:set('TripleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        if state.CombatForm.current ~= 'Melee' then 
            state.CombatForm:reset()
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if (( string.find(buff:lower(), 'flurry') and gain ) or buff:startswith('Aftermath')) then
        get_custom_ranged_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        if player.equipment.range == 'Armageddon' then
            classes.CustomRangedGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM3 UP-------------')
            end
            if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM2 UP-------------')
            end
            if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM1 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomRangedGroups:clear()

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
	if buff:startswith('Aftermath') then
        if player.equipment.range == 'Earp' then
            classes.CustomRangedGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Earp AM3 UP-------------')
            end
            if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Earp AM2 UP-------------')
            end
            if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Earp AM1 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomRangedGroups:clear()

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
	
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
end

function get_custom_ranged_groups()
    classes.CustomRangedGroups:clear()
    -- Flurry I = 265, Flurry II = 581
    if buffactive['Flurry'] then
        if state.FlurryMode.value == 'Hi' then
            classes.CustomRangedGroups:append('F2')
        else
            classes.CustomRangedGroups:append('F1')
        end
    end

    if player.equipment.range == 'Armageddon'  then
        if buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath Lv.3'] then
            classes.CustomRangedGroups:append('AME')
        end
    else
    -- relic aftermath is just "Aftermath", while empy + mythic are numbered
    -- cor has no relic, so we ignore that one
        if buffactive['Aftermath: Lv.1'] then
            classes.CustomRangedGroups:append('AM1')
        elseif buffactive['Aftermath: Lv.2'] then
            classes.CustomRangedGroups:append('AM2')
        elseif buffactive['Aftermath: Lv.3'] then
            classes.CustomRangedGroups:append('AM2')
        end
    end
end
-- Job-specific toggles.
function job_toggle_state(field)
    if field:lower() == 'luzaf' then
        state.LuzafRing:toggle()
        return "Use of Luzaf Ring", state.LuzafRing.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'RA: '..state.RangedMode.current
    if state.FightingMode.current ~= 'Default' then 
        msg = msg .. ', Fighting: '..state.FightingMode.current
    end
    if state.ShootingMode.current ~= 'Default' then 
        msg = msg .. ', Shooting: '..state.ShootingMode.current
    end
    msg = msg .. ', Gun: '..state.GunSelector.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end

    msg = msg .. ', Roll Sz: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    state.CombatForm:reset()
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('TripleShot')
    end
    if state.FightingMode.current == 'Melee' or state.FightingMode.current == 'DualSword' then 
        state.CombatForm:set('Melee')
    elseif state.FightingMode.current == 'Sword' then 
        state.CombatForm:set('Sword')
    end
end

function initialize_weapons()
    if player.equipment.range == 'Death Penalty' then
        state.GunSelector:set('Death Penalty')
    elseif player.equipment.range == 'Fomalhaut' then
        state.GunSelector:set('Fomalhaut')
    elseif player.equipment.range == 'Ataktos' then
        state.GunSelector:set('Ataktos')
    elseif player.equipment.range == 'Armageddon' then
        state.GunSelector:set('Armageddon')
	elseif player.equipment.range == 'Earp' then
         state.GunSelector:set('Earp')
    end
    -- SJ
    --if player.sub_job ~= 'DNC' and player.sub_job ~= 'NIN' then
    --    if state.FightingMode.current == 'Sword' then 
    --        state.FightingMode:set('Sword')
    --    else 
    --        state.ShootingMode:set('Single')
    --    end
    --end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
            ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
            ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
            ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = 'Small'
    if state.LuzafRing then
        rollsize = 'Large'
    end
    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    -- cateogry == 2  -- any ranged attack
    if (category == 2) or 
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end
-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and not state.warned
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '**** LOW AMMO WARNING: '..bullet_name..' ****'
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
        state.warned = true
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned = false
    end
end

function use_weaponskill()
    send_command('input /ws "'..auto_gun_ws..'" <t>')
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    -- reset these when toggled
    elseif stateField == 'Shooting Mode' then
        state.FightingMode:set('Default')
    elseif stateField == 'Fighting Mode' then
        state.ShootingMode:set('Default')
    elseif stateField == 'Gun Selector' then
        equip({range=state.GunSelector.current})
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '0.7' -- MAKE ADJUSTMENT HERE
        elseif buffactive['Flurry II'] then
            delay = '0.5'
        else
            delay = '1.05' -- MAKE ADJUSTMENT HERE
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function select_default_macro_book()
    set_macro_page(6, 20)
end

-- Salidar

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "16"
MacroBook = "6"
MacroSet = "1"

--Uses Items Automatically
AutoItem = true

--Upon Job change will use a random lockstyleset
Random_Lockstyle = true

--Lockstyle sets to randomly equip
Lockstyle_List = {16,17,18}

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them
state.OffenseMode:options('DT','TP','SB','Farm') -- ACC effects WS and TP modes
state.OffenseMode:set('DT')

state.WeaponMode:options('Aeneas','Karambit')
state.WeaponMode:set('Aeneas')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	sets.Weapons = {}
	sets.Weapons['Terpsichore'] = {}
	sets.Weapons['Twashtar'] = {}
	sets.Weapons['Aeneas'] = {main="Aeneas", sub="Gleti's Knife",}
	sets.Weapons['Karambit'] = {main="Karambit",}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {}

	sets.Idle.DT = {
		ammo="Staunch Tathlum +1",
    	head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
    	neck={ name="Loricate Torque +1", augments={'Path: A',}},
    	waist="Flume Belt +1",
    	left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    	right_ear="Infused Earring",
    	left_ring="Chirich Ring +1",
    	right_ring="Chirich Ring +1",
    	back="Sacro Mantle",}

	sets.Idle.TP = {
		ammo="Staunch Tathlum +1",
    	head="Gleti's Mask",
    	body="Gleti's Cuirass",
    	hands="Gleti's Gauntlets",
    	legs="Gleti's Breeches",
    	feet="Gleti's Boots",
    	neck={ name="Loricate Torque +1", augments={'Path: A',}},
    	waist="Flume Belt +1",
    	left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    	right_ear="Infused Earring",
    	left_ring="Chirich Ring +1",
    	right_ring="Chirich Ring +1",
    	back="Sacro Mantle",}
	
	sets.Idle.SB = sets.Idle.DT

	sets.Idle.Farm = {
		ammo="Staunch Tathlum +1",
    	head="Nyame Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    	waist="Silver Mog. Belt",
    	left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    	right_ear="Tuisto Earring",
    	left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    	right_ring="Moonlight Ring",
    	back="Moonlight Cape",}

	sets.Movement = {right_ring="Shneddick Ring",}

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode = {}

	sets.OffenseMode.DT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring", --Moonlight Ring
		right_ring="Epona's Ring", --Moonlight Ring
		back="Sacro Mantle",
	}
	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Sherida Earring",
    	right_ear="Telos Earring",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back="Sacro Mantle",
	}
	-- Subtle Blow Cap at 50 and II at 25 for a Total of 75.
	-- DNC Subtle Blow = 20/50 w/ Traits. Need +30 in Gear for SBI Cap.
	-- Subtle Blow I: 50/50 | Subtle Blow II:05/25 | DT:50/50 | ACC: High
	sets.OffenseMode.SB = {
		ammo="Yamarang",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Malignance Tights",
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring", -- SBII+5
    	right_ear="Telos Earring",
    	left_ring="Chirich Ring +1", -- SB+10
    	right_ring="Chirich Ring +1", -- SB+10
    	back="Sacro Mantle", -- Ambu Cape has SB+10
	}
	sets.OffenseMode.Farm = {
		ammo="Staunch Tathlum +1",
    	head="Nyame Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    	waist="Silver Mog. Belt",
    	left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    	right_ear="Tuisto Earring",
    	left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    	right_ring="Moonlight Ring",
    	back="Moonlight Cape",
	}

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = {}
	--Dual Wield
	sets.OffenseMode.DW = {}

	sets.Precast = {}
	sets.Precast.FastCast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Subtle Blow"+1','STR+3','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    	neck="Baetyl Pendant",
    	waist="Hachirin-no-Obi",
    	left_ear="Etiolation Earring",
    	right_ear="Enchntr. Earring +1",
    	right_ring="Rahab Ring",
	}
	sets.Enmity = {}
	sets.Midcast = {}
	sets.Midcast.SIRD = {}
	sets.Midcast.Cure = {}
	sets.Midcast.Enhancing = {}
	sets.Midcast.Enfeebling = {}
	sets.Midcast["Stoneskin"] = {}
	-------------------------------------------------------------------------------
	---------------------------------  JA Sets  -----------------------------------
	-- When you combine with idle during JA's you'll get ~2 sec of high defense --- 
	-------------------- if not overwritten by specified gear ---------------------
	-------------------------------------------------------------------------------
	sets.JA = {}

	sets.JA["Trance"] = {}
	sets.JA["Contradance"] = {}
	sets.JA["Saber Dance"] = {}
	sets.JA["Fan Dance"] = {}
	sets.JA["No Foot Rise"] = {}
	sets.JA["Presto"] = {}
	sets.JA["Grand Pas"] = {}
	-------------------------------------------------------------------------------
	-- Flourishes provide buffs to the Dancer and debuffs to the target monster. --
	-------------------------------------------------------------------------------
	sets.Flourish = set_combine(sets.Idle.DT, {head="Nyame Helm",})
																					-- Flourishes I : Monster Control
	sets.Flourish["Animated Flourish"] = set_combine(sets.Flourish, sets.Enmity) 	-- Volatile Enmity spike like Provoke
	sets.Flourish["Desperate Flourish"] = {} 										-- Gravity effect 
	sets.Flourish["Violent Flourish"] = {} 											-- Stun effect 
																					-- Flourishes II : Skillchain Enhancers
	sets.Flourish["Reverse Flourish"] = {} 											-- Returns TP in exchange for Finishing Moves
	sets.Flourish["Building Flourish"] = {head="Nyame Helm",}						-- Increases the strength of the next Weapon Skill
	sets.Flourish["Wild Flourish"] = {}												-- Readies target for Skillchain
																					-- Flourishes III : Weapon Skill Buffs
	sets.Flourish["Climactic Flourish"] = {}										-- Forces Critical Hit(s) on the next attack(s) 
	sets.Flourish["Striking Flourish"] = {head="Nyame Helm",}						-- Forces a Double Attack on the next swing 
	sets.Flourish["Ternary Flourish"] = {}											-- Forces a Triple Attack on the next swing
	-------------------------------------------------------------------------------
	-- Waltz Potency gear caps at 50%, while Waltz received potency caps at 30%. -- 
	-------------------------------------------------------------------------------
	sets.Waltz = {    
		ammo="Yamarang",
    	head={ name="Horos Tiara +1", augments={'Enhances "Trance" effect',}},
    	body="Maxixi Casaque",
    	hands={ name="Horos Bangles +1", augments={'Enhances "Fan Dance" effect',}},
    	legs="Dashing Subligar",
    	feet="Maxixi Toe Shoes",
    	neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    	waist="Chaac Belt",
    	left_ear="Enchntr. Earring +1",
    	right_ear="Cryptic Earring",
    	left_ring="Metamorph Ring",
    	right_ring="Carb. Ring +1",
    	back="Moonlight Cape",
	}
	sets.Waltz["Curing Waltz"] = sets.Waltz
	sets.Waltz["Curing Waltz II"] = sets.Waltz
	sets.Waltz["Curing Waltz III"] = sets.Waltz
	sets.Waltz["Curing Waltz IV"] = sets.Waltz
	sets.Waltz["Curing Waltz V"] = sets.Waltz
	sets.Waltz["Divine Waltz"] = sets.Waltz
	sets.Waltz["Divine Waltz II"] = sets.Waltz
	sets.Waltz["Healing Waltz"] = sets.Waltz
	-------------------------------------------------------------------------------
	---------- Samba duration can be increased using various equipment. -----------
	-------------------------------------------------------------------------------
	sets.Samba = set_combine(sets.Idle.DT, {head="Maxixi Tiara",}) --  Missing Ambu Cape for +15
	
	sets.Samba["Haste Samba"] = {}
	sets.Samba["Aspir Samba"] = {}
	sets.Samba["Aspir Samba II"] = {}
	sets.Samba["Drain Samba"] = {}
	sets.Samba["Drain Samba II"] = {}
	sets.Samba["Drain Samba III"] = {}
	-------------------------------------------------------------------------------
	----------- Jigs duration can be increased using various equipment. ----------- 
	-------------------------------------------------------------------------------
	sets.Jig = set_combine(sets.Idle.DT, {feet="Maxixi Toe Shoes",}) -- Horos Tights +3 and Maxixi Toe Shoes +3

	sets.Jig["Spectral Jig"] = sets.Jig
	sets.Jig["Chocobo Jig"] = sets.Jig
	sets.Jig["Chocobo Jig II"] = sets.Jig
	-------------------------------------------------------------------------------
	----- Step Accuracy depends on your melee hit rate (including your normal -----
	---- Accuracy equipment). All Steps tested have shown an innate 10 Accuracy --- 
	-- bonus, which can be further enhanced through various pieces of equipment, -- 
	----------------------------- merits, and Presto. -----------------------------
	-------------------------------------------------------------------------------
	sets.Step = {
		ammo="Yamarang",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Malignance Tights",
    	feet="Malignance Boots",
    	neck="Etoile Gorget +1",
    	waist="Reiki Yotai",
    	left_ear="Odr Earring",
    	right_ear="Telos Earring",
    	left_ring="Chirich Ring +1",
    	right_ring="Chirich Ring +1",
    	back="Sacro Mantle",
	}
	
	sets.JA["Quickstep"] = sets.Step
	sets.JA["Box Step"] = sets.Step
	sets.JA["Stutter Step"] = sets.Step
	sets.JA["Feather Step"] = set_combine(sets.Idle.DT, {})

	--Default WS set base
	sets.WS = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
    	neck="Anu Torque",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Sherida Earring",
    	right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    	left_ring="Ilabrat Ring",
    	right_ring="Epona's Ring",
    	back="Sacro Mantle",
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}
	--WS Sets
	-- Dagger WS
	sets.WS["Wasp Sting"] = {}
	sets.WS["Viper Bite"] = {}
	sets.WS["Shadowstich"] = {}
	sets.WS["Gust Slash"] = {}
	sets.WS["Cyclone"] = {}
	sets.WS["Energy Steal"] = {}
	sets.WS["Energy Drain"] = {}
	sets.WS["Dancing Edge"] = {}
	sets.WS["Shark Bite"] = {}
	sets.WS["Evisceration"] = {
		ammo="Ginsen",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
    	body="Gleti's Cuirass",
    	hands="Gleti's Gauntlets",
    	legs="Gleti's Breeches",
    	feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Regal Ring",
		right_ring="Epona's Ring",}
	sets.WS["Aeolian Edge"] = {
		ammo="Yamarang",
    	head="Nyame Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck="Baetyl Pendant",
    	waist="Fotia Belt",
   		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    	right_ear="Friomisi Earring",
    	left_ring="Regal Ring",
    	right_ring="Ilabrat Ring",
    	back="Sacro Mantle",}
	sets.WS["Rudra's Storm"] = {}

	-- Hand to Hand WS
	sets.WS["Combo"] = {}
	sets.WS["Shoulder Tackle"] = {}
	sets.WS["Backhand Blow"] = {}
	sets.WS["Asuran Fists"] = {} 	-- Only if Karambit Weapon Equipt
	sets.WS["Dragon Kick"] = {} 	-- Only if Hepatizon Baghnakhs NQ/+1 Weapon Equipt
	sets.WS["One Inch Punch"] = {} 	-- Must Sub MNK
	sets.WS["Raging Fists"] = {} 	-- Must Sub MNK
	sets.WS["Tornado Kick"] = {} 	-- Must Sub MNK

	sets.TreasureHunter = {
		head={ name="Herculean Helm", augments={'"Subtle Blow"+1','STR+3','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}, 
		legs={ name="Herculean Trousers", augments={'Enmity-2','Pet: Haste+3','"Treasure Hunter"+1','Accuracy+9 Attack+9',}},
		waist="Chaac Belt",}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end
--Adjust custom precast actions
function pretarget_custom(spell,action)
	
end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Function is called when a lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' and player.sub_job_level > 8 then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		elseif not buffactive['Meditate'] and ja_recasts[134] == 0 then
			buff = "Meditate"
		end
	end

	if player.sub_job == 'WAR' and player.sub_job_level > 8 then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

function Weapon_Check(equipSet)
	equipSet = set_combine(equipSet,sets.Weapons[state.JobMode.value])

	return equipSet
end

--Hurin

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "15"
MacroBook = "2"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

-- Set to true to run organizer on job changes
Organizer = true

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assign equipsets for them
state.OffenseMode:options('DT','TP','PDL','ACC','SB') -- ACC effects WS and TP modes
state.OffenseMode:set('TP')

--Weapon Modes
state.WeaponMode:options('Scythe','Great Sword','Sword','Club','Axe')
state.WeaponMode:set('Scythe')

-- Initialize Player
jobsetup(LockStylePallet,MacroBook,MacroSet)

function get_sets()

	sets.Weapons = {}

	sets.Weapons['Scythe'] = {
		main="Foenaria",
		sub="Utu Grip",
	}

	sets.Weapons['Great Sword'] = {
		main="Montante +1",
		sub="Utu Grip",
	}

	sets.Weapons['Sword'] = {
		main="Naegling",
		sub={ name="Ternion Dagger +1", augments={'Path: A',}},
	}

	sets.Weapons['Club'] = {
		main={ name="Loxotic Mace +1", augments={'Path: A',}},
		sub="Blurred Shield +1",
	}

	sets.Weapons['Axe'] = {
		main="Dolichenus",--Dolichenus
		sub={ name="Ternion Dagger +1", augments={'Path: A',}},
	}

	sets.Weapons.Shield = 
	{
		sub="Blurred Shield +1",
	}

	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=1},
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.SB = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})
	
	sets.Movement = {
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
	}

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe3", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +2",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Heath. Earring +2",
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=1},
		right_ring="Niqmaddu Ring",
		back="Null Shawl",
	}

	--Base TP set to build off
	sets.OffenseMode.TP = set_combine(sets.OffenseMode, {

	})

	sets.OffenseMode.DT = set_combine(sets.OffenseMode, {
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		feet="Sakpata's Leggings",
	})
	
	--Same TP set but WSD can be altered also
	sets.OffenseMode.PDL = set_combine(sets.OffenseMode, {

	})

	-- This caps with Auspice from WHM
	sets.Subtle_Blow = {
		body="",
		feet="Sakpata's Leggings",
		hands="Sakpata's Gauntlets",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
	}

	sets.OffenseMode.ACC = set_combine(sets.OffenseMode,{ })
	sets.OffenseMode.PDT = set_combine(sets.OffenseMode, { })
	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode, { })
	sets.OffenseMode.SB =  set_combine(sets.OffenseMode.DT, sets.Subtle_Blow, {})

	sets.DualWield = {}

	sets.Precast = {}

	-- Used for Magic Spells (Fast Cast)
	sets.Precast.FastCast = {
		ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
		body="Sacro Breastplate", --10
		hands="Leyline Gloves", --8
		legs="Enif Cosciales", --8
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, --8
		neck="Orunmila's Torque", --4
		left_ear="Malignance Earring", --1
		right_ear="Loquac. Earring",
		left_ring="Weather. Ring +1", --5
		right_ring="Kishar Ring",
	}
		
	sets.Enmity = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {})
	sets.Midcast.SIRD = set_combine(sets.Midcast, {})
	sets.Midcast.Enhancing = set_combine(sets.Midcast, {})
	sets.Midcast.Enfeebling = set_combine(sets.Midcast, {})
	sets.Midcast.Enfeebling.MACC = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Potency = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Duration = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Drain = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Aspir = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Aspir = {
		head="Ig. Burgeonet +3",
		body="Heath. Cuirass +3",
		hands="Fall. Fin. Gaunt. +3",
		legs="Heath. Flanchard +3",
		feet="Ratri Sollerets",
		neck="Erra Pendant",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
		back="",
		waist="Austerity Belt +1",
	}
	sets.Midcast.Drain = {
		head="Ig. Burgeonet +3",
        body="Heath. Cuirass +3",
        hands="Fall. Fin. Gaunt. +3",
        legs="Heath. Flanchard +3",
        feet="Ratri Sollerets",
        neck="Erra Pendant",
        left_ring="Evanescence Ring",
        right_ring="Stikini Ring +1",
        back="",
        waist="Austerity Belt +1",
	}

	sets.Midcast.Dark = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Dark.MACC = set_combine(sets.Midcast.Enfeebling.MACC, {})
	sets.Midcast.Dark.Absorb = set_combine(sets.Midcast.Drain, {hands="Heath. Gauntlets +3", right_ring="Kishar Ring",back="Chuparrosa Mantle"})
	sets.Midcast.Dark.Enhancing = set_combine(sets.Midcast.Enhancing, {head="Ig. Burgeonet +3",body="Heath. Cuirass +3",hands="Fall. Fin. Gaunt. +3", legs="Heath. Flanchard +3", feet="Ratri Sollerets",right_ring="Stikini Ring +1",
		left_ring="Evanescence Ring",neck ="Incanter's Torque"})
	sets.Midcast.EndarkII = {
        head="Ig. Burgeonet +3",
        body="Heath. Cuirass +3",
        hands="Fall. Fin. Gaunt. +3",
        legs="Heath. Flanchard +3",
        feet="Ratri Sollerets",
        neck="Incanter's Torque",
        left_ring="Evanescence Ring",
        right_ring="Stikini Ring +1",
        back="",
        waist="Casso Sash",
    }
	sets.Midcast.Impact = {
        head=empty, -- Impact requiere dejar la cabeza vacía
        body="Crepuscular Cloak",
        hands="Fall. Fin. Gaunt. +3",
        legs="Heath. Flanchard +3",
        feet="Ratri Sollerets",
        neck="Erra Pendant",
        left_ring="Evanescence Ring",
        right_ring="Stikini Ring +1",
        back="",
        waist="Austerity Belt +1",
    }
		--Job Abilities
	sets.JA = {}
	sets.JA["Provoke"] = sets.Precast.Enmity
	sets.JA["Blood Weapon"] = {body="Fall. Cuirass +3"}
	sets.JA["Souleater"] = {legs="Fallen's Flanchard +3"}
	sets.JA["Arcane Circle"] = {feet="Ignominy sollerets +3"}
	sets.JA["Weapon Bash"] = {hands="Ignominy gauntlets +3"}
	sets.JA["Nether Void"] = {legs="Heath. Flanchard +3"}
	sets.JA["Arcane Crest"] = {feet="Fall. Sollerets +3"}
	sets.JA["Scarlet Delirium"] = {}
	sets.JA["Soul Enslavement"] = {}
	sets.JA["Consume Mana"] = {}
	sets.JA["Diabolic Eye"] = {hands="Fall. Fin. Gaunt. +3"}
	sets.JA["Last Resort"] = {feet="Fallen's Sollerets +3"}

	--WS Sets
	sets.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}}, -- Need Heathen
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Heath. Earring +2",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine(sets.WS, {

	})

	sets.WS.PDL = set_combine(sets.WS, {

	})

	sets.WS.WSD = set_combine(sets.WS, {

	})

	sets.WS.CRIT = set_combine(sets.WS, {
	
	})

	sets.WS.Multi_Hit = set_combine(sets.WS, {
	
	})

	sets.WS.SB = set_combine(sets.WS, sets.Subtle_Blow, {
	
	})

	sets.WS['Catastrophe'] = set_combine(sets.WS, { 
		left_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

	sets.WS['Origin'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

	sets.WS['Entropy'] = set_combine(sets.WS, { 
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	})

	sets.WS['Quietus'] = set_combine(sets.WS, { 
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

	sets.WS['Cross Reaper'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Regal Ring",
	})

	sets.WS['Insurgency'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Regal Ring",
	})

	sets.WS['Torcleaver'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})

	sets.WS['Fimbulvetr'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Regal Ring",
	})

	sets.WS['Scourge'] = set_combine(sets.WS, { 
		left_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Regal Ring",
	})

	sets.WS['Resolution'] = set_combine(sets.WS, { 
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		left_ring="Sroda Ring",
	})

	sets.WS['Judgment'] = set_combine(sets.WS, { 
		right_ear="Thrud Earring",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	})


-- Used to Tag TH on a mob (TH4 is max in gear non-THF)
	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
		legs="Volte Hose",
	    feet="Volte Boots",
	    waist="Chaac Belt",
	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)
	
end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
    equipSet = {}

    if spell.english == "Endark II" then
        equipSet = sets.Midcast.EndarkII
    elseif spell.english == "Impact" then
        equipSet = sets.Midcast.Impact
    end

    return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Function is called when a lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' and player.sub_job_level == 49 then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		elseif not buffactive['Meditate'] and ja_recasts[134] == 0 then
			buff = "Meditate"
		end
	end

	if player.sub_job == 'WAR' and player.sub_job_level == 49 then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	return buff
end

function check_buff_SP()
    buff = 'None'
    --local sp_recasts = windower.ffxi.get_spell_recasts()
    return buff
end

function pet_change_custom(pet, gain)
    equipSet = {}
    return equipSet
end

function pet_aftercast_custom(spell)
    equipSet = {}
    return equipSet
end

function pet_midcast_custom(spell)
    equipSet = {}
    return equipSet
end

-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Full Circle
--              [ CTRL+B ]          Blaze of Glory
--              [ CTRL+A ]          Ecliptic Attrition
--              [ CTRL+D ]          Dematerialize
--              [ CTRL+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


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
    geo_timer = ''
    indi_timer = ''
    indi_duration = 308
    entrust_timer = ''
    entrust_duration = 344
    entrust = 0
    newLuopan = 0

    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

    -- state.CP = M(false, "Capacity Points Mode")

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }

    lockstyleset = 102
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds
    include('Global-Binds.lua')

    send_command('bind ^` input /ja "Full Circle" <me>')
    send_command('bind ^b input /ja "Blaze of Glory" <me>')
    send_command('bind ^a input /ja "Ecliptic Attrition" <me>')
    send_command('bind ^d input /ja "Dematerialize" <me>')
    send_command('bind ^c input /ja "Life Cycle" <me>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^insert gs c cycleback Element')
    send_command('bind ^delete gs c cycle Element')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind !p input /ja "Entrust" <me>')
    --send_command('bind ^, input /ma Sneak <stpc>')
    --send_command('bind ^. input /ma Invisible <stpc>')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad9 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad6 input /ws "Exudation" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')

    send_command('bind #- input /follow <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^b')
    send_command('unbind ^a')
    send_command('unbind ^d')
    send_command('unbind ^c')
    send_command('unbind !`')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    -- send_command('unbind @c')
    send_command('unbind @w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad1')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad+')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +2"}
    sets.precast.JA['Life Cycle'] = {head="Bagua Galero +3", body="Geomancy Tunic +3", back=gear.GEO_Idle_Cape,}


    -- Fast cast sets for spells

    sets.precast.FC = {
    --  /RDM --15
        ranged="Dunna", --3
        main="Sucellus", --5
        sub="Chanter's Shield", --3
        head="Amalric Coif +1", --11
        body="Agwu's Robe", --8
        hands="Agwu's Gages", --6
        legs="Geomancy Pants +2", --15
        ring1="Weather. Ring", --6(4)
        ring2="Kishar Ring", --10
        back=gear.GEO_FC_Cape, --10
        waist="Shinjutsu-no-Obi +1", --5
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        back="Perimede Cape",
        waist="Siegel Sash",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +3"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
        back="Perimede Cape", --(4)
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Brutal Earring",
        ring1="Petrov Ring",
        ring2="Hetairoi Ring",
        waist="Fotia Belt",
        }

    sets.precast.WS['Hexastrike'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Exudation'] = sets.precast.WS['Hexastrike']

    sets.precast.WS['Flash Nova'] = {
        head="Azimuth Hood +2",
        body="Azimuth Coat +2",
        hands="Jhakri Cuffs +2",
        legs="Azimuth Tights +2",
        feet="Azimuth Gaiters +2",
        neck="Saevus Pendant +1",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.GEO_MAB_Cape,
        waist="Refoccilation Stone",
        }

    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC -- Haste

   sets.midcast.Geomancy = {
        main="Idris",
        sub="Chanter's Shield",
        ranged="Dunna",
        head="Bagua Galero +3",
        body="Amalric Doublet +1",
        hands="Shrieker's Cuffs",
        legs="Vanya Slops",
        feet="Amalric Nails +1",
        ear1="Calamitous Earring",
        ear2="Mendi. Earring",
        neck="Reti Pendant",
        ring1="Freke Ring",
        ring2="Mephitas's Ring +1",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
        }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        head="Vanya Hood",
        legs="Bagua Pants +3",
        feet="Azimuth Gaiters +2",
        back="Lifestream Cape",
        })

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Sors Shield", --3/(-5)
        ammo="Esper Stone +1", --(-5)
        head="Vanya Hood", --10
        body="Vanya Robe", --7/(-6)
        hands="Vanya Cuffs",
        legs="Vanya Slops",
        feet="Vanya Clogs", --5
        neck="Incanter's Torque",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=gear.GEO_Cure_Cape, --0/(-10)
        waist="Bishop's Sash",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck="Malison Medallion",
        ring1={name="Haoma's Ring", bag="wardrobe3"},
        ring2={name="Haoma's Ring", bag="wardrobe4"},
        back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','VIT+1','Mag. Acc.+17','"Mag.Atk.Bns."+16','DMG:+7',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
        hands="Telchine Gloves",
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
        feet="Telchine Pigaches",
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','VIT+1','Mag. Acc.+17','"Mag.Atk.Bns."+16','DMG:+7',}},
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head="Amalric Coif +1",
        ear2="Mendi. Earring",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
        main="Idris",
        sub="Ammurapi Shield",
        ammo="Hydrocera",
        head="Geo. Galero +1",
        body="Geomancy Tunic +3",
        hands="Azimuth Gloves +3",
        legs="Geomancy Pants +2",
        feet="Geo. Sandals +3",
        neck="Bagua Charm +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="",
        ring2="Kishar Ring",
        back="Aurist's Cape +1",
        waist="Luminary Sash",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
        waist="Acuity Belt +1",
        }) -- INT/Magic accuracy

    sets.midcast.LockedEnfeebles = {body="Geomancy Tunic +3"}

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Geo. Galero +1",
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +2",
        legs="Azimuth Tights +2",
        feet="Azimuth Gaiters +2",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        main="Rubicundity", --20
        sub="Ammurapi Shield",
        head="Bagua Galero +3", --35
        feet="Agwu's Pigaches", --20
        ring1="Evanescence Ring", --10
        ring2="Archon Ring",
        neck="Erra Pendant", --5
        ear1="", --5
        waist="Fucho-no-Obi", --8
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast['Dark Magic']

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Idris",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Azimuth Hood +2",
        body="Azimuth Coat +2",
        hands="Azimuth Gloves +3",
        legs="Azimuth Tights +2",
        feet="Azimuth Gaiters +2",
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Kishar Ring",
        --ring2="Metamor. Ring +1",
        back=gear.GEO_MAB_Cape,
        waist="Acuity Belt +1",
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        ear2="Digni. Earring",
        })

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        })

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        --body="Seidr Cotehardie",
        })

    sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {})

    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
        head=empty,
        body="Twilight Cloak",
        hands="Geo. Mitaines +2",
        --ring2="Archon Ring",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Daybreak",
        sub="Genmei Shield",
        ranged="Dunna",
        head="Volte Beret",
        body="Azimuth Coat +2",
        hands="Bagua Mitaines +3",
        legs="Assid. pants +1", --Volte Brais
        feet="Geo. Sandals +3", --Volte Gaiters
        neck="Bathy Choker +1",
        ear1="Lugalbanda Earring",
        ear2="Odnowa Earring +1",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back=gear.GEO_Idle_Cape,
        waist="Plat. Mog. Belt",
        }

    sets.resting = set_combine(sets.idle, {
        waist="Shinjutsu-no-Obi +1",
        })

    sets.idle.DT = set_combine(sets.idle, {
        head="Azimuth Hood +2", --12/12
        hands="Azimuth Gloves +3", --12/12
        legs="Azimuth Tights +2",
        feet="Azimuth Gaiters +2", --11/11
        neck="Loricate Torque +1", --6/6
        ear2="Odnowa Earring +1", --3/3
        back=gear.GEO_Idle_Cape, --5/5
        waist="Plat. Mog. Belt", --3/3
        })

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        -- Pet: -DT (37.5% to cap) / Pet: Regen
        sub="Genmei Shield", --10/0/0/0
        main="Idris", --0/0/25/0
        head="Azimuth Hood +2", --12/12/0/5
        body={ name="Telchine Chas.", augments={'Pet: DEF+13',}}, --0/0/0/3
        hands="Geo. Mitaines +2", --3/0/13/0
        legs={ name="Telchine Braconi", augments={'Pet: Mag. Evasion+14',}}, --0/0/0/3
        feet="Bagua Sandals +3", --0/0/0/5
        neck="Bagua Charm +2",
        ear1="Lugalbanda Earring",
        ear2="Odnowa Earring +1", --3/3/0/0
        ring2="Defending Ring", --10/10/0/0
        back=gear.GEO_Pet_Cape, --0/0/0/15
        waist="Isa Belt" --0/0/3/1
        })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        hands="Azimuth Gloves +3", --12/12
        back=gear.GEO_Idle_Cape, --5/5
        waist="Plat. Mog. Belt" --3/3
        })

    sets.PetHP = {head="Bagua Galero +3"}

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    --sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    --sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

    sets.idle.Town = set_combine(sets.idle, {
        main="Idris",
        sub="Ammurapi Shield",
        ranged="Dunna",
        head="Azimuth Hood +2",
        body="Azimuth Coat +2",
        hands="Azimuth Gloves +3",
        legs="Azimuth Tights +2",
        feet="Geo. Sandals +3",
        neck="Bagua Charm +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        back=gear.GEO_Pet_Cape,
        waist="Acuity Belt +1",
        })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Geo. Sandals +3"}

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main="Idris",
        sub="Genmei Shield",
		neck="Lissome Necklace",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Telos Earring",
        ear2="Crep. Earring",
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        waist="Cetl Belt",
		back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
        }


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
        main="Bunzi's Rod", --10
        sub="Ammurapi Shield",
        head="Ea Hat +1", --7/(7)
        body="Azimuth Coat +2", --(5)
        hands="Amalric Gages +1", --0/(6)
        legs="Azimuth Tights +2", --15
        neck="Mizu. Kubikazari", --10
        ring2="Mujin Band", --(5)
        }

    sets.buff.Doom = {ring1={name="Saida Ring", bag="wardrobe3"}, ring2={name="Saida Ring", bag="wardrobe4"},}
    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and buffactive.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Enfeebling Magic' and newLuopan == 1 then
        -- prevent Cohort Cloak from unequipping head when relic head is locked
        equip(sets.midcast.LockedEnfeebles)
    elseif spell.skill == 'Geomancy' then
        if buffactive.Entrust and spell.english:startswith('Indi-') then
            equip({main=gear.Gada_GEO})
                entrust = 1
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        --[[if spell.english:startswith('Geo') then
            geo_timer = spell.english
            send_command('@timers c "'..geo_timer..'" 600 down spells/00136.png')
        elseif spell.english:startswith('Indi') then
            if entrust == 1 then
                entrust_timer = spell.english
                send_command('@timers c "'..entrust_timer..' ['..spell.target.name..']" '..entrust_duration..' down spells/00136.png')
                entrust = 0
            else
                send_command('@timers d "'..indi_timer..'"')
                indi_timer = spell.english
                send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
            end
        end ]]
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
        enable('head')
        newLuopan = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    classes.CustomIdleGroups:clear()
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if pet.isvalid then
        if pet.hpp > 73 then
            if newLuopan == 1 then
                equip(sets.PetHP)
                disable('head')
            end
        elseif pet.hpp <= 73 then
            enable('head')
            newLuopan = 0
        end
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Auto.value then
        msg = ' Auto: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 21)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end


--Turin

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "10"
MacroBook = "1"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set default mode (TP,ACC,DT)
state.OffenseMode:options('TP','ACC','DT','PDL','SB','MEVA') -- ACC effects WS and TP modes
state.OffenseMode:set('DT')

--Modes for specific to Ninja
state.WeaponMode:options('Kannagi', 'Heishi', 'Savage Blade','Karambit','Aeolian Edge','Abyssea','Ninjitsu')
state.WeaponMode:set('Kannagi')

elemental_ws = S{'Aeolian Edge', 'Blade: Teki', 'Blade: To','Blade: Chi','Blade: Ei','Blade: Yu'}

jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()
	--Set the weapon options.  This is set below in job customization section

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Kannagi'] = {
		main={ name="Kannagi", augments={'Path: A',}},
		sub="Yagyu Darkblade", -- Gokotai
	}
sets.Weapons['Heishi'] = {
		main={ name="Heishi Shorinken", augments={'Path: A',}},
		sub="Yagyu Darkblade", -- Gokotai
	}


	sets.Weapons['Ninjitsu'] = {
		main="Tauret",
		sub="Yagyu Darkblade", -- Gokotai
	}

	sets.Weapons['Savage Blade'] = {
		main="Naegling",
		sub="Yagyu Darkblade",
	}

	sets.Weapons['Karambit'] = {
		main="Karambit",
		sub="empty",
	}

	sets.Weapons['Aeolian Edge'] = {
		main="Tauret",
		sub="Yagyu Darkblade",
	}

	sets.Weapons['Abyssea'] = {
		main="",
		sub="",
	}

	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Eihwaz Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Andartia's Mantle", augments={'Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.SB = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})

	--Defined below based off time of day
	sets.Movement = {}

	sets.Movement.Day = {
		feet="Danzo Sune-Ate",
	}
	sets.Movement.Night = {
		feet="Hachiya Kyahan +1", --Hachi. Kyahan +1
	}
	sets.Movement.Dusk = {
		feet="Hachiya Kyahan +1", --Hachi. Kyahan +1
	}

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo="Happo Shuriken +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Ken. Sune-Ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Hattori Earring +1",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine (sets.OffenseMode.TP, {
	    head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine (sets.OffenseMode.TP, {
	    head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
	})
	sets.OffenseMode.PDL = set_combine (sets.OffenseMode.TP, {
	    head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT,{
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
	})

	sets.OffenseMode.SB = set_combine(sets.OffenseMode.DT,{ })

	sets.DualWield = {}

	sets.Precast = {}
	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head={ name="Herculean Helm", augments={'"Fast Cast"+5','INT+7','Mag. Acc.+13',}}, --13
		body="Dread Jupon", -- 9
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, -- 8
		legs="Gyve Trousers", -- 6
		feet="", -- 6
		neck="Orunmila's Torque", -- 4
		waist="Plat. Mog. Belt",
		left_ear="Etiolation Earring", -- 1
		right_ear="Loquac. Earring", -- 2
		left_ring="Kishar Ring", -- 4
		right_ring="Rahab Ring", -- 2
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}, -- 10
	} -- 67

	sets.Precast.Utsusemi = {
		neck="Magoraga Beads", -- 10 FC (+6)
	}

	sets.Precast.QuickMagic = {

	}

	sets.Enmity = { -- Head and Back upgrade slots
		ammo="Sapience Orb", --2
		body="Emet Harness +1", --10
		hands="Kurys Gloves", --9
		--="Zoar Subligar +1", --6
		feet="", --7 Ahosi Leggings
		neck="Moonlight Necklace", --15
		waist="Kasiri Belt", --3
		left_ear="Cryptic Earring", --4
		right_ear="Friomisi Earring", --2
		left_ring="Petrov Ring", --4
		right_ring="Eihwaz Ring", --5
	}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})
	-- Utsusemi Set
	sets.Midcast.Utsusemi = {
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		feet="Hattori Kyahan +3",
	}
	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {}
	-- Cure Set
	sets.Midcast.Cure = {}
	-- Enhancing Skill
	sets.Midcast.Enhancing = {
		hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
	}
	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {
		ammo="Hydrocera",
		head="Hachiya Hatsu. +3",
		body="Malignance Tabard",
		hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Moonlight Necklace",
		waist="Eschan Stone",
		left_ear="Hermetic Earring",
		right_ear="Crep. Earring",
		left_ring={ name="Stikini Ring +1", bag="wardrobe1",},
		right_ring={ name="Stikini Ring +1", bag="wardrobe2",},
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
	-- High MAB for spells
	sets.Midcast.Nuke = {
    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Mpaca's Boots", augments={'Path: A',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Hermetic Earring",
    right_ear="Friomisi Earring",
	left_ring={ name="Stikini Ring +1", bag="wardrobe1",},
	right_ring={ name="Stikini Ring +1", bag="wardrobe2",},
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {waist="Siegel Sash",}

	sets.JA = {}
	sets.JA["Futae"] = {hands="Hattori Tekko +3"}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Enmity
	sets.JA["Mijin Gakure"] = {}
	sets.JA["Yonin"] = {head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}}}
	sets.JA["Innin"] = {head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}}}
	sets.JA["Issekigan"] = {}
	sets.JA["Mikage"] = {}

	--Default WS set base
	sets.WS = {
		ammo="Yetshila +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear="Ishvara Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+10 Attack+10','AGI+10','Weapon skill damage +10%',}},
	}

	sets.WS.WSD = set_combine({ sets.WS,
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
	})

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine({ sets.WS,	    
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
	})

	sets.WS.CRIT = {
		ammo="Yetshila +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Herculean Boots",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Odr Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.WS.MAB = set_combine({ sets.WS,
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})

	--WS Sets
	sets.WS["Blade: Rin"] = sets.WS.CRIT
	sets.WS["Blade: Retsu"] = {}
	sets.WS["Blade: Teki"] = sets.WS.MAB
	sets.WS["Blade: To"] = sets.WS.MAB
	sets.WS["Blade: Chi"] = sets.WS.MAB
	sets.WS["Blade: Ei"] = set_combine(sets.WS.MAB, {head="Pixie Hairpin +1", left_ring="Archon Ring"})
	sets.WS["Blade: Jin"] = sets.WS.CRIT
	sets.WS["Blade: Ten"] = {}
	sets.WS["Blade: Ku"] = {}
	sets.WS["Blade: Kamu"] = {}
	sets.WS["Blade: Yu"] = sets.WS.MAB
	sets.WS["Blade: Hi"] = sets.WS.CRIT
	sets.WS["Blade: Shun"] = {}

	sets.WS["Asuran Fists"] = {
	    ammo="Yetshila +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Odr Earring",
		left_ring="Hetairoi Ring",
		right_ring="Gere Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+10 Attack+10','AGI+10','Weapon skill damage +10%',}},
	}

	sets.WS["Savage Blade"] = {
	    ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+10 Attack+10','AGI+10','Weapon skill damage +10%',}},
	}

	sets.TreasureHunter = {
	    head="Volte Cap",
		body="Volte Jupon",
		waist="Chaac Belt",
	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}
	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}
	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}
	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}
	return equipSet
end
--Function is called by the gearswap command
function self_command_custom(command)

end

-- This function is called when the job file is unloaded
function user_file_unload()

end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

Cycle_Time = 1
function Cycle_Timer()
	if world.time >= 17*60 or world.time <= 7*60 then
		if world.time >= (18*60) or world.time <= (6*60) then
			sets.Movement = set_combine(sets.Movement, sets.Movement.Night)
			log('Night Feet')
		else
			sets.Movement = set_combine(sets.Movement, sets.Movement.Dusk)
			log('Dusk Feet')
		end
	else
		sets.Movement = set_combine(sets.Movement, sets.Movement.Day)
		log('Day Feet')
	end
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end


--Turin

-- Load and initialize the include file.
include('Mirdain-Include')

-- Use "gs c food" to use the specified food item 
Food = "Miso Ramen"

BlueNuke = S{'Spectral Floe','Entomb', 'Magic Hammer', 'Tenebral Crush'}
BlueHealing = S{'Magic Fruit'}
BlueSkill = S{'Occultation','Erratic Flutter','Nature\'s Meditation','Cocoon','Barrier Tusk','Metallic Body','Mighty Guard'}
BlueTank = S{'Jettatura','Geist Wall','Blank Gaze','Sheep Song','Sandspin','Healing Breeze'}

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them
state.OffenseMode:options('TP','ACC','DT','PDT','MEVA') -- ACC effects WS and TP modes

-- Function used to change pallets based off sub job and modes
function Macro_Sub_Job()
	local macro = 1
	if player.sub_job == "BLU" then
		state.OffenseMode:set('DT')
		--Set you macro pallet for when you are /BLU
		macro = 1
		send_command('wait 2;aset set tanking')
	else
		state.OffenseMode:set('TP')
		--Set you macro pallet for when you are NOT /BLU
		macro = 1
	end
	return macro
end

Buff_Delay = 5 -- Used this to slow down auto buffing
Tank_Delay = 5 -- delays between tanking actions (only used when auto-buffing enabled and target locked on)

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "12"
MacroBook = "12"
MacroSet = Macro_Sub_Job()

--Modes for specific to Paladin.  These are defined below in "Weapons".
state.WeaponMode:options('Epeolatry','Naegling','Club','Great Axe','Axe')
state.WeaponMode:set('Epeolatry')

--Enable JobMode for UI.
UI_Name = 'Runes'
UI_Name2 = 'Auto Tank'

--Modes for specific to RUN
state.JobMode:options('None','Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark') -- Modes used to use Rune Enhancement
state.JobMode:set('None')

Runes = {
	Fire = {Name = "Ignis", Description = "[ICE RESISTANCE] and deals [FIRE DAMAGE]"},
	Ice = {Name = "Gelus", Description = "[WIND RESISTANCE] and deals [ICE DAMAGE]"},
	Wind = {Name = "Flabra", Description = "[EARTH RESISTANCE] and deals [WIND DAMAGE]"},
	Earth = {Name = "Tellus", Description = "[LIGHTNING RESISTANCE] and deals [EARTH DAMAGE]"},
	Lightning = {Name = "Sulpor", Description = "[WATER RESISTANCE] and deals [LIGHTNING DAMAGE]"},
	Water = {Name = "Unda", Description = "[FIRE RESISTANCE] and deals [WATER DAMAGE]"},
	Light = {Name = "Lux", Description = "[DARK RESISTANCE] and deals [LIGHT DAMAGE]"},
	Dark = {Name = "Tenebrae", Description = "[LIGHT RESISTANCE] and deals [DARKNESS DAMAGE]"},
	None = {Name = 'None', Description = "None"}
}

jobsetup (LockStylePallet,MacroBook,MacroSet)

-- HP balancing: 3000 HP
-- MP balancing: 950 MP

function get_sets()

	sets.Weapons = {}

	sets.Weapons['Epeolatry'] = {
		main="Epeolatry",
		sub="Utu Grip",
	}

	sets.Weapons['Naegling'] = {
		main="Naegling",
		sub="Dolichenus",
	}

	sets.Weapons['Axe'] = {
		main="Dolichenus",
		sub="Naegling",
	}

	sets.Weapons['Great Axe'] = {
		main="Lycurgos",
		sub="Utu Grip",
	}

	sets.Weapons['Club'] = {
		main={ name="Loxotic Mace +1", augments={'Path: A',}},
	}

	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	-- Standard Idle set
	sets.Idle = {
		ammo="Homiliary", -- 1 Refresh
		head={ name="Nyame Helm", augments={'Path: B',}}, -- 7/7
		body="Erilaz Surcoat +3",
		hands="Erilaz Gauntlets +3", -- 11/11
		legs="Eri. Leg Guards +3", -- 13/13
		feet="Erilaz Greaves +3", -- 11/11
		neck={ name="Futhark Torque +2", augments={'Path: A',}}, -- 7/7
		waist="Plat. Mog. Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=1}, -- 3/5
		right_ear="Sanare Earring", -- Upgrade to +1/+2 Earring
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Damage taken-5%',}}, -- 5/5
    } -- 75 PDT / 58 MDT		3571 HP/ 1149 MP

	sets.Idle.PDT = set_combine( sets.Idle, {
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt", -- 4/0
		left_ear="Tuisto Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=4}, -- 7/-1
	})

	sets.Idle.MEVA = set_combine( sets.Idle, {
		ammo="Staunch Tathlum +1",
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		head="Erilaz Galea +3",
		body="Runeist Coat +3",
		waist="Plat. Mog. Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=1}, -- 3/5
		right_ear="Sanare Earring",
	})

	sets.Idle.DT = set_combine( sets.Idle, {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		waist={ name="Plat. Mog. Belt", priority=2},
		left_ear={ name="Tuisto Earring", priority=3},
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
	})

	-- Set is used for midcast during MEVA OffenseMode
	sets.MEVA = {
		ammo="Staunch Tathlum +1",
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		body="Runeist Coat +3",
		hands="Erilaz Gauntlets +3", -- 11/11
		legs="Eri. Leg Guards +3", -- 13/13
		feet="Erilaz Greaves +3", -- 11/11
		waist="Plat. Mog. Belt",
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=1}, -- 3/5
	}

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})

	-- This gear will be equiped when the player is moving and not engaged
	sets.Movement = {
		left_ring={name="Moonlight Ring", bag="wardrobe3"},
		right_ring={name="Moonlight Ring", bag="wardrobe4"},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}, priority=1},
    } -- 73 PDT / 33 MDT		3028 HP / 963 MP

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe2", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Erilaz Galea +3",
		body="Ashera Harness",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}, priority=1},
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back="Null Shawl",
	}

	--DPS set for tanking
	sets.OffenseMode.TP = {
		head="Erilaz Galea +3",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	} -- No fucks given

	-- Gear to swap in for ACC when TP
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode, { })

	--Physical Damage Taken set for tanking
	sets.OffenseMode.PDT = set_combine(sets.OffenseMode, {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Adamantite Armor",
		hands="Turms Mittens +1",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		back="Null Shawl",
	}) -- Maintains Capped PDT with some DPS mixed in

	--Magic Evasion set for tanking
	sets.OffenseMode.MEVA = set_combine(sets.Idle.MEVA, {

	}) -- Focus on Magic Evasion with some DPS mixed in

	-- Standard Tanking TP set
	sets.OffenseMode.DT = set_combine(sets.Idle.DT, {	
		body="Ashera Harness",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		back="Null Shawl",
	})

	-- Set used for hate generation on Job abilities
	sets.Enmity = { -- 23 Epo
		ammo="Sapience Orb", -- 2
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3", -- 11
		feet="Erilaz Greaves +3", -- 8 
		neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=2}, -- 10
		waist={ name="Plat. Mog. Belt", priority=1},
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear={ name="Cryptic Earring", priority=5}, -- 4
		left_ring={ name="Eihwaz Ring", priority=6}, -- 5
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=2},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Damage taken-5%',}}, -- 10
	} -- 99 Enmity 2884 HP / 840 MP

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.SIRD = set_combine(sets.Idle.DT, {
		ammo="Staunch Tathlum +1", -- 11
		head="Erilaz Galea +3", -- 20
		hands="Regal Gauntlets", -- 10
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}}, -- 20
		neck="Moonlight Necklace", -- 15
		waist="Audumbla Sash", -- 10
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}, -- 10
	})	-- 104 With Merits

	sets.Precast = {}
	-- Used for Magic Spells

	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head="Rune. Bandeau +3", -- 14
		body="Erilaz Surcoat +3", -- 13
		hands="Leyline Gloves", -- 7
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}, priority=2}, -- 8
		neck="Orunmila's Torque", -- 5
		waist={ name="Plat. Mog. Belt", priority=1},
		right_ear={ name="Etiolation Earring", priority=3},
		left_ear={ name="Tuisto Earring", priority=4},
		left_ring="Kishar Ring", -- 4
		right_ring="Weather. Ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}, -- 10
	} --65 FC

	sets.Precast.FastCast.Enhancing = set_combine(sets.Precast.FastCast, {
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}}, -- 7  (15 - 8) 
		waist="Siegel Sash", -- 8
	}) -- 80+ FC
	sets.Precast.Cure = {set_combine(sets.Precast.FastCast, {
		waist="Sroda Belt",
	})

	}


	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, sets.Enmity, sets.SIRD, {
	
	})
	sets.Midcast.Cure = {set_combine(sets.SIRD, {
		waist="Sroda Belt",
	})

	}

	-- Enhancing Skill
	sets.Midcast.Enhancing = {
		ammo="Staunch Tathlum +1",
	    head="Erilaz Galea +3",
		body="Runeist Coat +3",
		hands={ name="Regal Gauntlets", priority=2},
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear="Mimir Earring",
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Damage taken-5%',}}, -- 5/5
	}
	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = set_combine(sets.Midcast.Enhancing, {
		waist="Siegel Sash",
	})

	sets.Midcast["Aquaveil"] = set_combine(sets.Midcast.Enhancing, sets.SIRD, {
		body="Runeist Coat +3",
	})

	sets.Midcast["Phalanx"] = set_combine(sets.Midcast.Enhancing, {
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}}, --7
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Etiolation Earring", priority=1},
		body="Runeist Coat +3",
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
	})

	sets.Midcast["Flash"] = set_combine(sets.Enmity, {
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		hands="Erilaz Gauntlets +3",
		body="Runeist Coat +3",
		right_ear={ name="Etiolation Earring", priority=1},
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
	})

	sets.Midcast["Foil"] = set_combine(sets.Enmity, {
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		hands="Erilaz Gauntlets +3",
		body="Runeist Coat +3",
		right_ear={ name="Etiolation Earring", priority=1},
		left_ring={name="Moonlight Ring", bag="wardrobe3", priority=4},
		right_ring={name="Moonlight Ring", bag="wardrobe4", priority=5},
	})

	-- JOB ABILITIES --
	sets.JA = {}
    sets.JA["Elemental Sforzo"] = set_combine(sets.Enmity, { body="Futhark Coat +3" })
    sets.JA["Gambit"] = set_combine(sets.Enmity, { hands="Runeist Mitons +3",})
    sets.JA["Rayke"] = set_combine(sets.Enmity, { feet="Futhark Boots +3" })
    sets.JA["Liement"] = set_combine(sets.Enmity, { body="Futhark Coat +3" })
    sets.JA["One For All"] = sets.Idle
    sets.JA["Valiance"] = set_combine(sets.Enmity, {
        body="Runeist Coat +3",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Damage taken-5%',}}, -- 5/5
        legs="Futhark Trousers +3"
    })
    sets.JA["Vallation"] = set_combine(sets.Enmity, {
        body="Runeist Coat +3",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Damage taken-5%',}}, -- 5/5
        legs="Futhark Trousers +3"
    })
    sets.JA["Pflug"] = set_combine(sets.Enmity, { feet="Runeist Bottes +2" })
    sets.JA["Battuta"] = set_combine(sets.Enmity, { head="Futhark Bandeau +3" })
    sets.JA["Vivacious Pulse"] = set_combine(sets.Precast.Divine, { head="Erilaz Galea +3" })
    sets.JA["Embolden"] = set_combine(sets.Enmity, { back={ name="Evasionist's Cape", augments={'Enmity+5','"Embolden"+12','"Dbl.Atk."+1','Damage taken-1%',}},})
    sets.JA["Swordplay"] = set_combine(sets.Enmity, { hands="Futhark Mitons +3" })
	sets.JA["Provoke"] = sets.Enmity

	sets.Embolden = { back={ name="Evasionist's Cape", augments={'Enmity+5','"Embolden"+12','"Dbl.Atk."+1','Damage taken-1%',}},}

	--Default WS set base
	sets.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}
	sets.WS.WSD = {}
	sets.WS.CRIT = {}

	--Great Sword WS
	sets.WS["Hard Slash"] = {}
	sets.WS["Frostbite"] = {}
	sets.WS["Freezebite"] = {}
	sets.WS["Shockwave"] = {}
	sets.WS["Crescent Moon"] = {}
	sets.WS["Sickle Moon"] = {}
	sets.WS["Spinning Slash"] = {}
	sets.WS["Herculean Slash"] = {}
	sets.WS["Resolution"] = {}
	sets.WS["Dimidiation"] = {}

	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
		body="Volte Jupon",
		waist="Chaac Belt",
	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------


buff_time = os.clock()
tank_time = os.clock()

JA_Delay = os.clock()


-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}
	equipSet = set_combine(equipSet, Embolden_Check(spell))

	if state.OffenseMode.value == 'MEVA' then
		equipSet = set_combine(equipSet, sets.MEVA)
	end

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end

--Function used to automate Job Ability use - Checked first
function check_buff_JA()
	buff = 'None'
	if os.clock() - buff_time > Buff_Delay then
		local ja_recasts = windower.ffxi.get_ability_recasts()
		local delay = os.clock() - JA_Delay

		if player.sub_job == 'SAM' then
			if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
				buff = "Hasso"
			end
		end

		if player.sub_job == 'WAR' then
			if not buffactive['Berserk'] and ja_recasts[1] == 0 then
				buff = "Berserk"
			elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
				buff = "Aggressor"
			elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
				buff = "Warcry"
			end
		end

		if buffactive[Runes[state.JobMode.value].Name] == 3 and windower.ffxi.get_player().target_locked then
			if not buffactive['Valiance'] and not buffactive['Vallation'] and not buffactive['Liement'] and ja_recasts[23] == 0 and delay > 3 then
				buff = "Vallation" -- Next Single Target DT and FC
			end
			if not buffactive['Valiance'] and not buffactive['Vallation'] and not buffactive['Liement'] and ja_recasts[113] == 0 then
				buff = "Valiance" -- AoE DT and FC
				JA_Delay = os.clock() -- Need to give Valiance a chance to register before Vallation is used
			end
		end

		--Rune sets
		if Runes[state.JobMode.value].Name ~= "None" then
			if ja_recasts[92] == 0 and buffactive[Runes[state.JobMode.value].Name] ~= 3 then
				buff = Runes[state.JobMode.value].Name
				info(Runes[state.JobMode.value].Description)
			end

		end

		if buff ~= 'None' then
			buff_time = os.clock()
		end
	end
	return buff
end

--Function used to automate Spell use
function check_buff_SP()
	buff = 'None'
	if os.clock() - buff_time > Buff_Delay then
		local sp_recasts = windower.ffxi.get_spell_recasts()

		if not buffactive['Enmity Boost'] and sp_recasts[476] == 0 and player.mp > 100 then
			buff = "Crusade"
		elseif not buffactive['Phalanx'] and sp_recasts[106] == 0 and player.mp > 100 then
			buff = "Phalanx"
		elseif not buffactive['Aquaveil'] and sp_recasts[55] == 0 and player.mp > 100 then
			buff = "Aquaveil"
		elseif not buffactive['Multi Strikes'] and sp_recasts[493] == 0 and player.mp > 36 then
			buff = "Temper"
		elseif not buffactive['Ice Spikes'] and sp_recasts[250] == 0 and player.mp > 16 then
			buff = "Ice Spikes"
		end

		if player.sub_job == "BLU" and player.sub_job_level > 8 then 
			if not buffactive['Defense Boost'] and sp_recasts[547] == 0 and player.mp > 10 then
				buff = "Cocoon"
			end
		end

		if buff ~= 'None' then
			buff_time = os.clock()
		else
			buff = check_tank()
		end
	end
	return buff
end


function check_tank()
	buff = 'None'
	if os.clock() - tank_time > Tank_Delay then
				log('tank check')
		if (player.status == "Engaged" or windower.ffxi.get_player().target_locked) and state.JobMode2.value == "ON" then
			local sp_recasts = windower.ffxi.get_spell_recasts()
			if sp_recasts[112] == 0 and player.mp > 25 then
				buff = "Flash"
			end
			if sp_recasts[840] == 0 and player.mp > 48 then
				buff = "Foil"
			end
		end
	end

	if buff ~= 'None' then
		tank_time = os.clock()
	end
	return buff
end

-- This function is called when the job file is unloaded
function user_file_unload()

end

-- Swaps back when embolden buff is active to extend duration
function Embolden_Check(spell)
	equipSet = {}
	if spell.target.name == player.name then
		if buffactive['Embolden'] then
			equipSet = sets.Embolden
			info('Embolden Set')
		end
	end
	return equipSet
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup variables that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
 
    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')
 
    state.ClosedPosition = M(false, 'Closed Position')
 
    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')
 
    state.CP = M(false, "Capacity Points Mode")
 
    lockstyleset = 41
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Gear Modes
function user_setup()
	state.IdleMode:options('Regen','DT')
    state.OffenseMode:options('Hybrid','Mpaca','Artifact', 'DT')
    state.HybridMode:options('Normal', 'HIGH', 'MID', 'LOW')
    state.WeaponskillMode:options('Normal', 'Acc')
    
-- Allows the use of Ctrl + ~ and Alt + ~ for 2 more macros of your choice.
    send_command('bind ^` input /ja "Chocobo Jig II" <me>') --Ctrl'~'
    send_command('bind !` input /ja "Spectral Jig" <me>') --Alt'~'
    send_command('bind f9 gs c cycle OffenseMode') --F9
    send_command('bind ^f9 gs c cycle WeaponSkillMode') --Ctrl'F9'
    send_command('bind f10 gs c cycle idlemode') --F10
    send_command('bind f11 gs c cycle mainstep') --F11
    send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind PAGEUP input /equip main "Masamune";input /echo MASAMUNE MODE ON!!!!!!;input /macro set 1;')
	send_command('bind ^PAGEUP input /equip main "Shining One";input /echo SHINING ONE MODE ON;input /macro set 2;')
	send_command('bind HOME input /equip ring1 "Warp Ring"; input /echo Warping; /input /wait 11 ; input /item "Warp Ring" <me>;')
	send_command('bind ^HOME input /equip ring2 "Dim. Ring (Dem)"; /echo Reisenjima; input /wait 11; input /item "Dim. Ring (Dem)" <me>;')
	
    select_default_macro_book()
    set_lockstyle()
 
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end
 
-- Erases the Key Binds above when you switch to another job.
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind ^=')
    send_command('unbind f11')
    send_command('bind @c')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()


 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.Enmity = {head="Highwing Helm",neck="",hands="Kurys Gloves",ear2="Friomisi Earring",ring1="Petrov Ring",body="",legs="Samnuha Tights",feet=""}
 
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body=""}
    sets.precast.JA['Trance'] = {head=""}
	sets.precast.JA['Meditate']= {head="Wakido Kabuto +3",hands="Sakonji Kote +3"}
    sets.precast.Waltz = {ammo="Yamarang",
        head="Anwig Salade",
        neck="",
        lear="",
        body="",
        hands="",
        ring1="",
        ring2="",
        back="",
        waist="",
        legs="",
        feet=""}
	
 
    sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring"}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.precast.WS['Tachi: Fudo'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Tachi: Kasha'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Tachi: Gekko'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Tachi: Yukikaze'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Tachi: Shoha'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Beithir Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.WS['Sonic Thrust'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Beithir Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

 
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.SpellInterrupt = {}
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
 
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.idle.DT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +2",
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back="moonbeam Cape",
        }
		
	sets.idle.Regen = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Sacro Breastplate",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back="moonbeam Cape",
}
		
 
    sets.idle.Town = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Sacro Breastplate",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Danzo sune-ate",
		neck="Sam. Nodowa +2",
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Chirich Ring +1",
		back="Moonbeam Cape",
}
 

 
    ------------------------------------------------------------------------------------------------
    -------------------------------------- Dual Wield Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW
 
    -- No Magic Haste (39% DW to cap)
    sets.engaged.DW = {
        ammo="Ginsen",
        head="Adhemar Bonnet +1",
        neck="", --5
        ear1="", --3
        ear2="", --4
        body="", --11
        hands="Adhemar Wrist. +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back={ name="", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="", --5
        legs="Samnuha Tights",
        feet=""
        } -- 28%
 
    -- 15% Magic Haste (32% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo="Ginsen",
        head="Adhemar Bonnet +1",
        neck="", --5
        ear1="", --3
        ear2="", --4
        body="", --11
        hands="Adhemar Wrist. +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back={ name="", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="", --5
        legs="Samnuha Tights",
        feet=""
        } -- 28%
 
    -- 30% Magic Haste (21% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo="Ginsen",
        head="Adhemar Bonnet +1",
        neck="", --5
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        body="", --11
        hands="Adhemar Wrist. +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back={ name="", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="", --5
        legs="Samnuha Tights",
        feet=""
        } -- 21%
 
    -- 35% Magic Haste (16% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Ginsen",
        head="Adhemar Bonnet +1",
        neck="Anu Torque",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        body="", --11
        hands="Adhemar Wrist. +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back={ name="", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="", --5
        legs="Samnuha Tights",
        feet=""
        } -- 16% Gear
 
    -- 45% Magic Haste (1% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo="",
        head="Adhemar Bonnet +1",
        neck="Anu Torque",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        body="Mummu Jacket +2",
        hands="Adhemar Wrist. +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back="",
        waist="Windbuffet Belt +1",
        legs="Samnuha Tights",
        feet=""
        } -- 0%
    
    ------------------------------------------------------------------------------------------------
    --------------------------------------- Accuracy Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
-- Define three tiers of Accuracy.  These sets are cycled with the F9 Button to increase accuracy in stages as desired.
    sets.engaged.DT = {
		sub="Utu Grip",
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back="moonbeam Cape",
	}
    sets.engaged.Mpaca = {
		sub="Utu Grip",
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	 sets.engaged.Hybrid = {
		sub="Utu Grip",
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",--Wakido Kote +3
		legs="Kasuga Haidate +3",
		feet="Ryuo Sune-Ate +1",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Kasuga Earring +1",
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
    sets.engaged.Artifact = {
		sub="Utu Grip",
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Wakido Kabuto +3",
		body="Wakido Domaru +3",
		hands="Wakido Kote +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet="Wakido Sune. +3",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		ring1="Chirich Ring +1",
		ring2="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
		}
-- Base Shield
    sets.engaged.Mpaca = set_combine(sets.engaged, sets.engaged.Mpaca)
    sets.engaged.Artifact = set_combine(sets.engaged, sets.engaged.Artifact)
	sets.engaged.Hybrid = set_combine(sets.engaged, sets.engaged.Hybrid)
-- Base DW
    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW, sets.engaged.Acc3)
-- LowHaste DW
    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc3)
-- MidHaste DW
    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc3) 
-- HighHaste DW
    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc1)
    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc3)
-- HighHaste DW
    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.LowAcc)
    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.MidAcc)
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.HighAcc)
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
-- Define three tiers of Defense Taken.  These sets are cycled with the F10 Button. DT1-16%, DT2-28%, DT3-47%
 

-- No Haste DW
    sets.engaged.DW.LOW = set_combine(sets.engaged.DW, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT1)
    
    sets.engaged.DW.MID = set_combine(sets.engaged.DW, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT2)
 
    sets.engaged.DW.HIGH = set_combine(sets.engaged.DW, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT3)   
-- Low Haste DW
    sets.engaged.DW.LOW.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT1)
    
    sets.engaged.DW.MID.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT2)
    
    sets.engaged.DW.HIGH.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT3)
-- Mid Haste
    sets.engaged.DW.LOW.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT1)
    
    sets.engaged.DW.MID.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT2)
 
    sets.engaged.DW.HIGH.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT3)     
-- High Haste
    sets.engaged.DW.LOW.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT1)
    
    sets.engaged.DW.MID.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT2)
    
    sets.engaged.DW.HIGH.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT3)
-- Max Haste
    sets.engaged.DW.LOW.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.LowAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.MidAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT1)
    sets.engaged.DW.HighAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT1)
    
    sets.engaged.DW.MID.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.LowAcc.MID.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.MidAcc.MID.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT2)
    sets.engaged.DW.HighAcc.MID.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT2)
    
    sets.engaged.DW.HIGH.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.LowAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.MidAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT3) 
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
--  sets.buff['Saber Dance'] = {legs=""}
--  sets.buff['Fan Dance'] = {body="Horos Bangles +1"}
    sets.buff['Climactic Flourish'] = {head=""} --body="Meg. Cuirie +2"}
    sets.buff['Closed Position'] = {feet=""}
 
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }
 
    sets.CP = {back="Mecisto. Mantle"}
--  sets.Reive = {neck="Ygnas's Resolve +1"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    
-- Used to overwrite Moonshade Earring if TP is more than 2750.
    if spell.type == 'WeaponSkill' then
        if player.tp > 2750 then
        equip({right_ear = "Sherida Earring"})
        end
    end
    

-- Forces Maculele Tiara +1 to override your WS Head slot if Climactic Flourish is active.  Corresponds with sets.buff['Climactic Flourish'].
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
    if spell.type=='Waltz' and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
    if buff == 'Saber Dance' or buff == 'Climactic Flourish' or buff == 'Fan Dance' then
        handle_equipping_gear(player.status)
    end
 
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            handle_equipping_gear(player.status)
        end
    end
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end
 
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end
 
function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode
 
    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
 
    return wsmode
end
 
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
 
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff['Climactic Flourish'] then
        meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    end
    if state.ClosedPosition.value == true then
        meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
    end
 
    return meleeSet
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
 
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end
 
 
-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = '[ Melee'
 
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
 
    msg = msg .. ': '
 
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
 
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end
 
    if state.ClosedPosition.value then
        msg = msg .. '[ Closed Position: ON ]'
    end
 
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end
 
    msg = msg .. '[ '..state.MainStep.current
 
    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
 
    msg = msg .. ' ]'
 
    add_to_chat(060, msg)
 
    eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 9 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 9 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 39 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 39 then
            classes.CustomMeleeGroups:append('')
        end
    end
end
 
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end
 
        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end
 
        send_command('@input /ja "'..doStep..'" <t>')
    end
    gearinfo(cmdParams, eventArgs)
end
 
function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end
 
-- If you attempt to use a step, this will automatically use Presto if you are under 5 Finishing moves and resend step.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under5FMs = not buffactive['Finishing Move 5'] and not buffactive['Finishing Move (6+)']
         
        if player.main_job_level >= 77 and prestoCooldown < 1 and under5FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
    
-- If you attempt to use Climactic Flourish with zero finishing moves, this will automatically use Box Step and then resend Climactic Flourish. 
        local under1FMs = not buffactive['Finishing Move 1'] and not buffactive['Finishing Move 2'] and not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5'] and not buffactive['Finishing Move (6+)']
 
    if spell.english == "Climactic Flourish" and under1FMs then
            cast_delay(1.9)
            send_command('input /ja "Box Step" <t>')
    end 
end
 
-- My Waltz Rules to Overwrite Mote's
-- My Current Waltz Amounts: I:372 II:697 III:1134
function refine_waltz(spell, action, spellMap, eventArgs)
    if missingHP ~= nil then
        if player.main_job == 'DNC' then
            if missingHP < 40 and spell.target.name == player.name then
                -- Not worth curing yourself for so little.
                -- Don't block when curing others to allow for waking them up.
                add_to_chat(122,'Full HP!')
                eventArgs.cancel = true
                return
            elseif missingHP < 475 then
                newWaltz = 'Curing Waltz'
                waltzID = 190
            elseif missingHP < 850 then
                newWaltz = 'Curing Waltz II'
                waltzID = 191
            else
                newWaltz = 'Curing Waltz III'
                waltzID = 192
            end
        else
            -- Not dnc main or sub; ignore
            return
        end
    end
end
 
-- Automatically loads a Macro Set by: (Pallet,Book)
function select_default_macro_book()
    if player.sub_job == 'SAM' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(3, 5)    
    elseif player.sub_job == 'BLU' then
        set_macro_page(4, 5)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(1, 5)
    end
end
 
function set_lockstyle()
    send_command('@wait 1;input /lockstyleset 41')
end


--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
                
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.
        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
        
		// OPTIONAL IF YOU WANT / NEED to skip the cycles...  
       
	    gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

-------------------------------------------------------------                                        
--                              
--      ,---.     |    o               
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |                         
-------------------------------------------------------------  

send_command('lua l sch-hud')
send_command('wait 5;input /lockstyleset 43') --40
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt','nuke')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal','AGWU','NAKED','EAR', 'acc','Seidr')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 910   --important to update these if you have a smaller screen
hud_y_pos = 740    --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 255 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font =  'IMPACT'


-- Setup your Key Bindings here:

		if player.sub_job == 'WHM' then
	--send_command('bind ^numpad3 gs c scholar aoe;wait 1;input /ma "Cure III" <stal>')
	send_command('bind ~numpad3 input /ma "Curaga III" <stal>')
	send_command('bind ~numpad1 input /ma "Curaga" <stal>')
	send_command('bind ~numpad2 input /ma "Curaga II" <stal>')
	--set_macros(4,16)
	
    end

   -- windower.send_command('bind insert gs c nuke cycle')  	-- insert to Cycles Nuke element
	 windower.send_command('bind ` gs c nuke cycle')  	-- insert to Cycles Nuke element
	 windower.send_command('bind ~` gs c nuke cycledown')
    windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')			-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode      	
    windower.send_command('bind !end gs c hud lite')  	-- Alt-End to toggle light hud version
		
    send_command('bind !o input /ma "Regen V" <stal>')
	send_command('bind !e input /ma "Haste" <stal>')
	send_command('bind !r input /ma "Refresh" <stal>')
	send_command('bind !y input /ma "Phalanx" <stal>')
	send_command('bind !u input /ma "Aquaveil" <stal>')
	send_command('bind !q input /ma "Adloquium" <stal>')
	send_command('bind !p input /ma "blink" <stal>')
	send_command('bind !s input /ma "Stoneskin" <me>')
	send_command('bind ^` input /ja "sublimation" <me>')
	send_command('bind @` input /ma "klimaform" <me>')
	--send_command('bind ~q input /item "panacea" <me>')
	send_command('bind ^v paste')
	
	send_command('bind @numpad7 gs c sc tier') -----> Skillchain TIER
	send_command('bind @numpad0 gs c sc castsc') ------> create skillchain


	
	
	
	 send_command('bind ~o gs c scholar duration; wait 1;gs c scholar aoe')

	

    send_command('bind ^numpad4 gs c scholar aoe;wait 1;input /ma "Cure IV" <stal>')
	--send_command('bind ^numpad3 gs c scholar aoe;wait 1;input /ma "Cure III" <stal>')
	--send_command('bind ^numpad3 input /ma "Curaga III" <stal>')
		--send_command('bind ^numpad1 input /ma "Curaga" <stal>')
	--send_command('bind ^numpad2 input /ma "Curaga II" <stal>')

	send_command('bind ^numpad2 gs c scholar aoe;wait 1;input /ma "Cure II" <stal>')
	send_command('bind ^numpad1 gs c scholar aoe;wait 1;input /ma "Cure" <stal>')
	send_command('bind ^numpad3 gs c scholar aoe;wait 1;input /ma "Cure III" <stal>')
	send_command('bind ^numpad4 gs c scholar aoe;wait 1;input /ma "Cure IV" <stal>')
	

	
	send_command('bind !numpad4 input /ma "Cure IV" <stal>')
	send_command('bind !numpad1 input /ma "Cure" <stal>')
	send_command('bind !numpad2 input /ma "Cure II" <stal>')
	send_command('bind !numpad3 input /ma "Cure III" <stal>')
	-- send_command('bind !numpad5 input /ma "paralyna" <stal>')
	-- send_command('bind !numpad6 input /ma "blindna" <stal>')
	send_command('bind !numpad7 input /ja "Tabula Rasa" <me>')
	send_command('bind !numpad8  gs c scholar duration; wait 1;gs c scholar aoe; wait 1;input /ma "Embrava" <stal>')
	send_command('bind !numpad9 gs c scholar power ; wait 1;input /ma "kaustra" <t>')
	-- send_command('bind !numpad8 input /ma "viruna" <stal>')
	-- send_command('bind !numpad9 input /ma "poisona" <stal>')
	-- send_command('bind !numpad0 input /ma "Cursna" <stal>')
	-- send_command('bind !# input /ma "stona" <stal>')
	
	


	send_command('bind ^numpad+ input /equip Ring1 "Warp Ring"; wait 1; input /equip Ring2 "Dim. Ring (Holla)"')

	
	
	
	send_command('bind @1 gs c scholar light;wait 1.5;input /ja "Addendum: White" <me>')
	--send_command('bind @1 gs c scholar light;wait 1;input gs c scholar addendum')
    send_command('bind @2 gs c scholar dark;wait 1.5;input /ja "Addendum: black" <me>')
	--send_command('bind @3 gs c scholar addendum')
	send_command('bind @0 gs c scholar aoe')
	send_command('bind @4 gs c scholar duration')
	send_command('bind @5 gs c scholar power')  
	send_command('bind @6 gs c scholar accuracy')
	send_command('bind @9 input /ja "immanence" <me>')
	send_command('bind @i input /ma "Impact" <t>')
	send_command('bind @d input /ma "Dispelga" <t>')
	
	--send_command('bind @. gs c nuke cycle')
	send_command('bind @numpad1 gs c nuke t1')
	send_command('bind @numpad2 gs c nuke t2')
	send_command('bind @numpad3 gs c nuke t3')
	send_command('bind @numpad4 gs c nuke t4')
	send_command('bind @numpad5 gs c nuke t5')
	send_command('bind ~numpad. input /ma "sleep" <t>')
	send_command('bind ~numpad0 input /ma "break" <t>')
	send_command('bind ~numpad8 input /ja "Modus Veritas" <t>')
	send_command('bind @numpad8 gs c nuke helix')  
	send_command('bind @numpad9 gs c nuke storm')  
	send_command('bind @numpad+ input /ma "silence" <t>') 
	send_command('bind @numpad- input /ma "frazzle" <t>') 
	
	

	

	--send_command('bind ~numpad1 input /ma "stona" <stal>')
	
--Custom 6 step skillchain macro w/o Tabula Rasa	
	
	--send_command('lua l StatusHelper')
--send_command('lua l Partybuffs')


--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
	send_command('unbind @1')
	send_command('unbind @2')
	send_command('unbind @3')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad4')
    send_command('unbind @numpad1')
    send_command('unbind @numpad2')
    send_command('unbind @numpad3')
    send_command('unbind @numpad4')
    send_command('unbind @numpad5')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad4')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !f9')	
    send_command('unbind !q')  
	send_command('unbind !e') 
	send_command('unbind !r') 
	send_command('unbind !u') 
	send_command('unbind !o') 
	send_command('unbind !p') 
	send_command('unbind !y') 
	send_command('unbind !k') 
	send_command('unbind !s') 	
	send_command('unbind ^`') 
	send_command('unbind ~q')
	send_command('unbind ~1')
	send_command('unbind ~2')
		send_command('unbind @1')	
	send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
    send_command('unbind @6')	
    send_command('unbind @7')
    send_command('unbind @8')
    send_command('unbind @9')
	send_command('unbind ~numpad0')
	send_command('unbind ~numpad.')
	send_command('unbind ~numpad1')
	send_command('unbind ~numpad2')
	send_command('unbind ~numpad3')
end


--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
--include('SCH_Lib2.lua')          -- leave this as is   
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------


-- Optional. Swap to your sch macro sheet / book
set_macros(1,15) -- Sheet, Book
--set_lockstyleset (46)

-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {
	--main="Daybreak",
    --sub="Genmei Shield",
    main="Musa",
	sub="Khonsu",
	ammo="Homiliary",
    head="Volte Beret",
    body="arbatel gown +3", --"annointed Kalasiris",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="assid. Pants +1",
    feet="Herald's Gaiters",
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape",

    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh,{

    })   
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType],{
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head= { name="Nyame Helm", augments={'Path: B',}},
    body="arbatel gown +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Warder's Charm +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape",

    })  
    sets.me.idle.mdt = set_combine(sets.me.idle[refreshType],{
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head= { name="Nyame Helm", augments={'Path: B',}},
    body="arbatel gown +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Warder's Charm +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape",

    })  
	
	    sets.me.idle.nuke = {
	main="Mpaca's staff",
	sub="Enki strap",
	head="agwu's cap",
	left_ear="Regal Earring",
    right_ear="Malignance Earring",
	neck="Argute Stole +2",
	ring2="Mujin Band",
	left_ring="Freke Ring",
	ammo="Ghastly Tathlum +1",
	body="arbatel gown +3", --"Agwu's Robe",
	legs="Agwu's Slops",
	feet="Arbatel loafers +3", --"Agwu's Pigaches",
	hands="Amalric Gages +1",
	

    }  
	
	
	
	
	
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current],{

    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Shattersoul"] = {

    }
    sets.me["Myrkr"] = {

    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel Bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +3"}
    sets.buff['Penury'] = {legs="Arbatel Pants +3"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +3"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}	
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set
   
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = {
    main={ name="Musa", augments={'Path: C',}},
    sub="Enki Strap",
    ammo="Homiliary",
    head="Amalric Coif +1",
    body= "Zendik Robe", --{ name="Agwu's Robe", augments={'Path: A',}},
    hands="Acad. Bracers +3",
    legs="Agwu's Slops",
    feet="Amalric Nails +1",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Kishar Ring",
    back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

	sets.precast["Stun"] = {
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Sapience Orb",
    head="Amalric Coif +1", --{ name= "amalric coif" augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    --body="Vrikodara Jupon",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    --legs={ name="Lengo Pants", augments={'INT+5','Mag. Acc.+4','"Mag.Atk.Bns."+1','"Refresh"+1',}},
    feet="Pedagogy Loafers +3",
    --neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    --left_ring="Weather. Ring +1",
    right_ring="Kishar Ring",
    back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},

	}
		
		--sets.precast.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
		
			sets.precast.Impact = set_combine(sets.precast.casting, {
        head=empty,
        body="Crepuscular Cloak",
		hands= "Regal Cuffs",
        ring2="Archon Ring",
        })
		
		sets.precast.Dispelga = set_combine(sets.precast.casting, {
		main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
    }) 

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. 
    sets.precast.grimoire = {
	main={ name="Musa", augments={'Path: C',}},
    sub="Enki Strap",
    ammo="Homiliary",
    head="Acad. Mortar. +3", --"Acad. Mortar. +3",
    body= "Zendik Robe", --{ name="Agwu's Robe", augments={'Path: A',}},
    hands="Acad. Bracers +3",
    legs="Agwu's Slops",
    feet="Amalric Nails +1",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Kishar Ring",
    back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.precast['Dispelga'] = {
        main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
}
	
	

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
	waist="Siegel Sash",
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
	head="Umuthi Hat",
	legs="Doyen Pants",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	main="Musa",
	sub="Enki Strap",
	head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Heka's Kalasiris",
	feet= "vanya clogs",
	ear2="Mendicant's Earring",
	legs="Doyen Pants",
	waist="Witful Belt",
	
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {legs="Pedagogy Pants +3"}
    sets.precast["Enlightenment"] = {body="Peda. Gown +3"}	 
    sets.precast["Sublimation"] = {head="Acad. Mortar. +3", body="Peda. Gown +3"}	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	--waist="Hachirin-no-Obi",
		waist="Acuity belt +1",
    }
	
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
	sets.midcast.Helix = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Culminus",
    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
    head={ name="Agwu's Cap", augments={'Path: A',}},
    body={ name="Agwu's Robe", augments={'Path: A',}},
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs= "Arbatel Pants +3",
    feet="Arbatel Loafers +3",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Orpheus's Sash", --"Skrymir Cord +1",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
}
	sets.midcast.Helix.MB = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub=  		 "Culminus",
	head= 	 	 "Peda. M.Board +3",
	body= 		 "Agwu's Robe",
	hands= 		 "agwu's gages", 
	legs= 	 	 "Agwu's Slops", -- 
	feet= 		 "Arbatel loafers +3", --"Agwu's Pigaches",
	neck=		 "Argute Stole +2",
	left_ear=    "Malignance Earring",
    right_ear=   "Arbatel Earring +2",
	right_ring=  "Mujin Band", --"Metamor. Ring +1", --"Mujin Band",
	left_ring=   "Freke Ring",
	ammo=		 "Ghastly Tathlum +1",
	waist=       "Skrymir Cord +1", --Acuity belt +1",

	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	
	
	
    -- sets.midcast.DarkHelix = {
	-- main="Bunzi's Rod",
	-- sub="Culminus",
	-- head="Pixie Hairpin +1",
	-- ammo="Ghastly Tathlum +1",
	-- waist="Skrymir cord",
	-- feet="agwu's pigaches", --"Amalric Nails +1",
	-- neck="Argute Stole +2",
	-- ear1="Regal Earring",
	-- ear2="Malignance Earring",
	-- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
    -- }
	
	-- sets.midcast.WindHelix ={
	-- main="Bunzi's Rod",
	-- sub="Culminus",
	-- waist="Skrymir cord",
	-- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}, 
	-- }
	
	-- sets.midcast["Aero V"] ={
	-- main="Marin Staff +1",
	-- sub="Enki Strap",
	-- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}, 
	-- }
	
	
	
	-- sets.midcast["Aero IV"] = {main="Marin Staff +1",
	-- sub="Enki Strap"}
	-- sets.midcast["Aero III"] = {main="Marin Staff +1",
	-- sub="Enki Strap"}
	-- sets.midcast["Aero II"] = {main="Marin Staff +1",
	-- sub="Enki Strap"} 
	-- sets.midcast["Aero"] = {main="Marin Staff +1",
	-- sub="Enki Strap"}

	
	-- sets.midcast["Luminohelix II"] = {
	-- main="Daybreak",
	-- sub="Culminus",
	-- waist="Skrymir cord",
	-- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	-- }
	--ring1="Weatherspoon Ring +1",}
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    
	
	--sets.midcast.Helix = {
	-- sets.midcast["Ionohelix II"] = {
	-- main="Bunzi's Rod",
    -- sub="culminus",
    -- ammo="Pemphredo Tathlum",
	-- head="agwu's cap",
    -- --head="Pedagogy Mortarboard +3",
    -- body= "PEdagogy gown +3", --"Merlinic Jubbah", --body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- hands="agwu's gages", --hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
   -- legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"M	ag.Atk.Bns."+20',}}, --"Merlinic Shalwar", 
    -- feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    -- neck="Mizu. Kubikazari",
    -- waist="Skrymir cord",
    -- left_ear="Regal Earring",
    -- right_ear="Malignance Earring",
    -- left_ring="Freke Ring",
    -- right_ring="Metamor. Ring +1",
    -- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    -- }
	
	-- --sub="Culminus",
	-- ammo="Ghastly Tathlum +1",
	-- waist="Orpheus's Sash",
	-- --feet="Amalric Nails +1",
	-- neck="Argute Stole +2",
	-- ear1="Regal Earring",
	-- ear2="Malignance Earring"

    -- }	

	sets.midcast["Kaustra"] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
    head="Pixie Hairpin +1",
    body="Agwu's Robe",
    hands="Amalric Gages +1",
    legs="amalric slops +1", -- Agwu's Slops",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    --waist="Hachirin-no-Obi",
    waist="Acuity belt +1",
	left_ear="Malignance Earring",
    right_ear="Arbatel Earring +2",
    left_ring= "stikini ring +1", --left_ring="Archon Ring",
    right_ring="Freke Ring",
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
	
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Culminus",
    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
    head={ name="Agwu's Cap", augments={'Path: A',}},
    body={ name="Agwu's Robe", augments={'Path: A',}},
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Agwu's Slops",
    feet="Arbatel Loafers +3",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Orpheus's Sash", --"Skrymir Cord",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
}
	
	
	
	
	
	-- main="Bunzi's Rod",
    -- sub="Ammurapi Shield",
    -- ammo="Pemphredo Tathlum",
    -- head="Pedagogy Mortarboard +3",
    -- body="Merlinic Jubbah", --body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- hands="agwu's gages", --hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- legs="Merlinic Shalwar", --legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"M	ag.Atk.Bns."+20',}},
    -- feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    -- neck="Argute Stole +2",
    -- left_ear="Regal Earring",
	-- waist="Acuity belt +1",
    -- right_ear="Malignance Earring",
    -- left_ring="Freke Ring",
    -- right_ring="Metamor. Ring +1",
    -- back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
    -- }

	sets.midcast["Sublimation"] = {head="Acad. Mortar. +3", body="Peda. Gown +3",waist="embla sash"}
    
    sets.midcast.nuking.normal = {
		main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Pedagogy Mortarboard +3",
    body="Merlinic Jubbah", --body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands="agwu's gages", --hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
   legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --"Merlinic Shalwar", 
    feet="Arbatel loafers +3",  --feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Mizu. Kubikazari",
    waist="Acuity belt +1", --"Orpheus's Sash",
    left_ear="Malignance Earring",
    right_ear="Arbatel Earring +2",
    left_ring="Freke Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    }
	
		sets.midcast['Dia'] = set_combine(sets.midcast.nuking.normal, {
    ammo="Per. Lucky Egg",
    head="Volte Cap",
    body="Volte Jupon",
    feet="Amalric Nails +1",
    waist="Chaac Belt",
    })
	
	sets.midcast.nuking.NAKED = {
		main=empty,
    sub=empty,
    ammo=empty,
     head=empty,
     body=empty,
     hands=empty,
     legs=empty,
     feet=empty,  --feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck=empty,
    waist=empty,
    left_ear=empty,
    right_ear=empty,
    left_ring=empty,
    right_ring=empty,
    back=empty,
    }
	
			sets.midcast.MB.NAKED = {
	main="Mpaca's staff",
	sub=	"Enki strap",
	ammo="Ghastly Tathlum +1",
	head="agwu's cap",
	body= "arbatel gown +3", --"Agwu's Robe", --
	neck="Argute Stole +2",
	hands= "agwu's gages",
	legs= "Agwu's Slops", -- 
	feet= "Arbatel loafers +3", --"Agwu's Pigaches", --
	waist="Acuity belt +1",
	left_ear="Malignance Earring",
    right_ear="Arbatel Earring +2",
	right_ring="Mujin Band", --"Metamor. Ring +1", --
	left_ring="Freke Ring",
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
	
	    sets.midcast.nuking.acc = {
		main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
	head= "agwu's cap",
    --head="Pedagogy Mortarboard +3",
    body="Merlinic Jubbah", --body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands="agwu's gages", --hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
   legs= { name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --"Merlinic Shalwar", 
    feet="Arbatel loafers +3",  --feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Mizu. Kubikazari",
    waist="Acuity belt +1", --"Orpheus's Sash",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    }
	
		    sets.midcast.nuking.AGWU = {
		main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
     head={ name="Agwu's Cap", augments={'Path: A',}},
     body={ name="Agwu's Robe", augments={'Path: A',}},
     hands={ name="Agwu's Gages", augments={'Path: A',}},
     legs="Agwu's Slops",
     feet="Arbatel Loafers +3",  feet="Arbatel loafers +3",  --feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Mizu. Kubikazari",
    waist="Acuity belt +1", --"Orpheus's Sash",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    }
	
	sets.midcast.nuking.EAR = {
	main=		"Bunzi's Rod",
    sub=		"Ammurapi Shield",
    ammo=		"Pemphredo Tathlum",
    head=		{ name="Agwu's Cap", augments={'Path: A',}},
    body=		{ name="Agwu's Robe", augments={'Path: A',}},
    hands=		{ name="Agwu's Gages", augments={'Path: A',}},
    legs=		"Agwu's Slops",
    feet=		"Arbatel Loafers +3",  feet="Arbatel loafers +3",  --feet="agwu's pigaches", --feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck=		"Mizu. Kubikazari",
    waist=		"Acuity belt +1", --"Orpheus's Sash",
    left_ear=   "Malignance earring",
    right_ear=  "Arbatel Earring +2",
    left_ring=  "Freke Ring",
    right_ring= "Metamor. Ring +1",
    back=		{ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    }
	
	
	sets.midcast['Elemental Magic'] = {
	main="Bunzi's Rod",
    sub="Ammurapi Shield",
	head="agwu's cap",
	left_ear="Regal Earring",
    right_ear="Malignance Earring",
	neck="Argute Stole +2",
	right_ring="Metamor. Ring +1", --"Mujin Band",
	left_ring="Freke Ring",
	ammo="Ghastly Tathlum +1",
	body="arbatel gown +3", --"Agwu's Robe",
	waist="Acuity belt +1",
	legs="arbatel pants +3", --Agwu's Slops",
	feet="Arbatel loafers +3", --"Agwu's Pigaches",
	hands= "agwu's gages", 
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

    
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
   -- sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
	sets.midcast.MB.normal = {
	--main="Bunzi's Rod",
    --sub="Ammurapi Shield",
	main= "Mpaca's staff",
	sub="Enki strap",
	head="agwu's cap",
	left_ear="Malignance Earring",
    right_ear="Arbatel Earring +2",
	neck="Argute Stole +2",
	right_ring="Metamor. Ring +1", --"Mujin Band",
	left_ring="Freke Ring",
	ammo="Ghastly Tathlum +1",
	body="arbatel gown +3", --"Agwu's Robe",
	waist="Acuity belt +1",
	legs= "Agwu's Slops", -- 
	feet="Arbatel loafers +3", --"Agwu's Pigaches",
	hands= "agwu's gages", 
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
		sets.midcast.MB.AGWU = {
	main= "Bunzi's Rod", --"Mpaca's staff",
	sub="ammurapi shield", --"Enki strap",
	ammo="Ghastly Tathlum +1",
	head="agwu's cap",
	body= "arbatel gown +3", --"Agwu's Robe", --
	neck="Argute Stole +2",
	hands= "agwu's gages",
	legs= "Agwu's Slops", -- 
	feet= "Arbatel loafers +3", --"Agwu's Pigaches", --
	waist="Acuity belt +1",
	left_ear="Regal Earring",
    right_ear="Malignance Earring",
	right_ring="Mujin Band", --"Metamor. Ring +1", --
	left_ring="Freke Ring",
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
		sets.midcast.MB.EAR = {
		main= "Mpaca's staff",
	sub="Enki strap",
	ammo="Ghastly Tathlum +1",
	head="agwu's cap",
	body="arbatel gown +3", --"Agwu's Robe",
	neck="Argute Stole +2",
	hands= "agwu's gages",
	legs= "Agwu's Slops", -- 
	feet="Arbatel loafers +3", --"Agwu's Pigaches",
	waist="Acuity belt +1",
    left_ear=   "Malignance earring",
    right_ear=  "Arbatel Earring +2",
	right_ring="Metamor. Ring +1", --"Mujin Band",
	left_ring="Freke Ring",
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	

	
		sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal,  {
	main= "Mpaca's staff",
	sub="Enki strap",
	head= "Arbatel Bonnet +3",
	left_ear="Regal Earring",
    right_ear="Malignance Earring",
	neck="Argute Stole +2",
	right_ring="Metamor. Ring +1", --"Mujin Band",
	left_ring="Freke Ring",
	ammo="Ghastly Tathlum +1",
	body="arbatel gown +3", --"Agwu's Robe",
	waist="Acuity belt +1",
	legs= "arbatel pants +3", 
	feet="Arbatel loafers +3", --"Agwu's Pigaches",
	hands= "agwu's gages", 
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	})
	
    sets.midcast.nuking.Seidr = {
	 sub="Ammurapi Shield",
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.Seidr = set_combine(sets.midcast.nuking.normal, {
	head="agwu's cap",
	right_ring="warp ring",
    })	
	
    -- Enfeebling
	sets.midcast["Stun"] = {}	
	
	sets.midcast['Dispelga'] = set_combine(sets.midcast.MndEnfeebling, {
        main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
	})
	
	
    sets.midcast.IntEnfeebling = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Acad. Mortar. +3",
    body="Acad. Gown +3",
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs="Arbatel Pants +3",
    feet="Acad. Loafers +3",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist={ name="Obstin. Sash", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},

    }
    sets.midcast.MndEnfeebling = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Acad. Mortar. +3",
    body="Cohort Cloak +1",
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs="Arbatel Pants +3",
    feet="Acad. Loafers +3",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist={ name="Obstin. Sash", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},

    }
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
	main="Musa",
    sub="Enki Strap",
   -- ammo="Hasty Pinion +1",
    ammo="Pemphredo Tathlum",
    head="telchine cap", --"Arbatel Bonnet +3",
    body= "Pedagogy gown +3",--"Telchine Chas.", --augments={'Enh. Mag. eff. dur. +10',}},
    hands="Telchine Gloves", --Arbatel Bracers +3
    legs="Telchine Braconi", --augments={'Enh. Mag. eff. dur. +10',}},
    feet="Telchine Pigaches", --augments={'Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear= "", --"Andoaa Earring",
    right_ear="Mimir Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe1"},
    right_ring={name="Stikini Ring +1", bag="wardrobe2"},
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    })
	sets.midcast.Haste = sets.midcast.Enhancing
	
	
	
    sets.midcast.storm = set_combine(sets.midcast.enhancing,{

    })       
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
		--neck="Nodens Gorget",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head="Amalric Coif +1",
		    ammo="Staunch Tathlum +1",
    head="Amalric Coif +1",
    hands="Regal Cuffs",
    waist="Emphatikos Rope",
		
    })
    
	sets.midcast.aquaveil = sets.midcast.refresh 
	
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		--main="Rubicundity",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
		left_ring= "stikini ring +1", 
		waist="Fucho-no-obi",
		feet="Agwu's Pigaches",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
	
		sets.midcast['Dia'] = set_combine(sets.midcast.nuking.normal, {
    ammo="Per. Lucky Egg",
    head="", --Volte Cap
    body="", --Volte Jupon
    feet="Amalric Nails +1",
    waist="Chaac Belt",
    })
	
	
	sets.midcast["Cursna"] = {
	main="gada",
    sub="Genmei Shield",
    ammo="Homiliary",
    head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
    body="Pedagogy Gown +3",
    hands="Pedagogy Bracers +3",
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet="Vanya Clogs",
    neck="malison Medallion", -- "Debilis Medallion",
    waist="Witful Belt",
    left_ear="meili Earring",
    right_ear="beatific earring",
    left_ring="Haoma's Ring",
    right_ring="Menelaus's Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
	main="Musa", --Daybreak", --main="Raetic Rod +1",
    sub="enki strap", --"Genmei Shield", --sub="Sors Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
    body="Kaykaus Bliaut +1",
    hands="Pedagogy Bracers +3",
    legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    feet="Kaykaus Boots +1", 
    neck="Incanter's Torque",
    waist="Austerity Belt +1",
    left_ear="Mendi. Earring",
    right_ear="",
    left_ring="evanescence ring", --"Lebeche Ring",
    right_ring="Stikini Ring +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}, --"tempered cape",--"Solemnity Cape",

    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		back="Twilight Cape",
		--waist="Hachirin-no-Obi",
		waist="Acuity belt +1",
	})    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
	main="bolelabunga",--"Musa",
    sub="ammurapi shield", --"Enki Strap",
    ammo="Pemphredo Tathlum",
    head= "telchine cap",--"Arbatel Bonnet +3", 
    body=  "Telchine Chas.", --"Pedagogy gown +3", --
    hands="Arbatel Bracers +3",
    legs="Telchine Braconi", --augments={'Enh. Mag. eff. dur. +10',}},
    feet="Telchine Pigaches", --augments={'Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="",
    right_ear="Lugalbanda Earring",
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
	head="Telchine Cap",
	
    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{
	--back="Bookworm's Cape",
    })

	sets.midcast.Impact = { --set_combine(sets.midcast.nuking.normal,{
        head=empty,
        body="Crepuscular Cloak",
		hands= "Regal Cuffs",
        ring2="Archon Ring",
        }
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
 


--Turin

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "5"
MacroBook = "6"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set default mode (TP,ACC,DT,PDL)
state.OffenseMode:options('TP','ACC','DT','PDL','Evasion')
state.OffenseMode:set('Evasion')

--Weapons options
state.WeaponMode:options('Twashtar','Aeneas','Gandring','Naegling','Evisceration')
state.WeaponMode:set('Twashtar')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	-- Weapon setup
	sets.Weapons = {}

sets.Weapons['Twashtar'] = {
		main="Twashtar",
		sub="Fusetto +2",
	}

	sets.Weapons['Aeneas'] = {
		main={ name="Aeneas", augments={'Path: A',}},
		sub={ name="Gleti's Knife", augments={'Path: A',}},
	}

	sets.Weapons['Gandring'] = {
		main="Gandring",
		sub="Crepuscular Knife",
	}

	sets.Weapons['Naegling'] = {
		main="Naegling",
		sub="Crepuscular Knife",
	}

	sets.Weapons['Evisceration'] = {
		main="Tauret",
		sub={ name="Aeneas", augments={'Path: A',}},
	}

	sets.Weapons.Sleep = {
		sub="Mpu Gandring",
	}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Adamantite Armor",
		hands={ name="Gleti's Gauntlets", augments={'Path: A',}},
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		waist="Null Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Sanare Earring",
		left_ring={ name="Moonlight Ring", bag="wardrobe3", priority=2},
		right_ring={ name="Moonlight Ring", bag="wardrobe4", priority=1},
		back="Null Shawl",
    }
	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.Evasion = set_combine(sets.Idle, {})

	sets.Movement = {
		feet="Pill. Poulaines +3",
    }

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe2", priority=1},
		waist="Gishdubar Sash",

	}
	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		right_ear="Skulk. Earring +2",
		left_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Hetairoi Ring",
		back="Null Shawl",
	}
	sets.OffenseMode.Evasion = set_combine(sets.OffenseMode.TP, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})	
	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
		head="Malignance Chapeau",
		body="Adamantite Armor",
		hands="Malignance Gloves",
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet="Malignance Boots",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=1},
		left_ring={ name="Moonlight Ring", priority=3},
		waist={ name="Plat. Mog. Belt", priority=2},
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode.TP, {})

	--Dual Wield need only 6 if not getting haste samba
	sets.DualWield = { 
	    --left_ear="Eabani Earring",
	    --waist="Reiki Yotai",
	}

	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head={ name="Herculean Helm", augments={'"Fast Cast"+5','INT+7','Mag. Acc.+13',}}, -- 12
		body="Dread Jupon", -- 8
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, -- 8
		legs="Enif Cosciales", -- 6
		feet="", -- 6
		neck="Orunmila's Torque", --4
		waist={name = "Plat. Mog. Belt", priority=2 },
		left_ear="Etiolation Earring", -- 1
		right_ear={ name="Tuisto Earring", priority=3},
		left_ring="Prolix Ring", -- 3
		right_ring="Weather. Ring +1",
	} -- 51 -- Need cape for another 10%

	sets.Enmity = {
	    ammo="Sapience Orb", -- 2
	    left_ear="Cryptic Earring", -- 4
		right_ear="Friomisi Earring", --2
		left_ring="Petrov Ring", -- 4
	}

	-- Used for Raises and Cure spells
	sets.Precast.QuickMagic = set_combine( sets.Precast.FastCast, {

	});

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})
	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {}
	-- Cure Set
	sets.Midcast.Cure = {}
	-- Enhancing Skill
	sets.Midcast.Enhancing = {}
	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {}
	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {
		waist="Siegel Sash",
	}
	sets.JA = {}
	sets.JA["Perfect Dodge"] = {hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},}
	sets.JA["Steal"] = {feet="Pillager's Poulaines +3",}
	sets.JA["Flee"] = {feet="Pillager's Poulaines +3",}
	sets.JA["Hide"] = {body="Pillager's Vest +3",}
	sets.JA["Sneak Attack"] = {hamds="Skulker's Armlets +3",}
	sets.JA["Mug"] = {} --head="Plunderer's Bonnet +3"
	sets.JA["Trick Attack"] = {hands="Pillager's Armlets +3",} --body="Plunderer's Vest +3",
	sets.JA["Accomplice"] = {head="Skulker's Bonnet +3",}
	sets.JA["Feint"] = {legs="Plun. Culottes +3",}
	sets.JA["Despoil"] = {legs="Skulker's Culottes +3", feet="Skulk. Poulaines +3",}
	sets.JA["Collaborator"] = {head="Skulker's Bonnet +3",}
	sets.JA["Conspirator"] = {body="Skulker's Vest +3",}
	sets.JA["Bully"] = {}
	sets.JA["Larceny"] = {}

	-- Dancer JA Section

	sets.Flourish = set_combine(sets.Idle.DT, {})

	sets.Jig = set_combine(sets.Idle.DT, {})

	sets.Step = set_combine(sets.OffenseMode.DT, {})

	sets.Samba = set_combine(sets.Idle.DT, {})

	-------------------------------------------------------------------------------
	-- Waltz Potency gear caps at 50%, while Waltz received potency caps at 30%. -- 
	-------------------------------------------------------------------------------
	sets.Waltz = set_combine(sets.OffenseMode.DT, {
		ammo="Yamarang", -- 5%
		head="Malignance Chapeau",
		body={ name="Gleti's Cuirass", augments={'Path: A',}}, -- 10%
		hands="", -- 5% Slither Gloves +1
		legs="", -- 10% Dashing Subligar
		feet="Malignance Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		left_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}) -- 30% Potency

	--Default WS set base
	sets.WS = {
		ammo="Yetshila +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}

	sets.WS.MAB = set_combine( sets.WS, {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Beithir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	})
	--WS Sets
	sets.WS["Wasp Sting"] = {}
	sets.WS["Viper Bite"] = {}
	sets.WS["Shadowstich"] = {}
	sets.WS["Gust Slash"] = {}
	sets.WS["Cyclone"] = {}
	sets.WS["Energy Steal"] = {}
	sets.WS["Energy Drain"] = {}
	sets.WS["Dancing Edge"] = {}
	sets.WS["Shark Bite"] = {}
	sets.WS["Evisceration"] = {}
	sets.WS["Aeolian Edge"] = set_combine( sets.WS.MAB, {
		feet="Skulk. Poulaines +3",
	})

	--Custome sets for each jobsetup
	sets.Custom = {}

	sets.TreasureHunter = {
		hands="Plun. Armlets +3",
		feet="Skulk. Poulaines +3",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end

function check_buff_JA()
	buff = 'None'
	--local ja_recasts = windower.ffxi.get_ability_recasts()
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

-- This function is called when the job file is unloaded
function user_file_unload()

end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

--[[     
 === Notes ===
 this is incomplete. my war just hit 99
 Using warcry = Upheaval
 Using bloodrage = Ukko's
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    wsList = S{ 'Savage Blade', 'Impulse Drive', 'Torcleaver', 'Ukko\'s Fury', 'Upheaval'}
    gsList = S{'Macbain', 'Kaquljaan', 'Nativus Halberd'}
    war_sub_weapons = S{"Sangarius", "Usonmunku", "Perun", "Tanmogayi +1", "Reikiko", "Digirbalag"}

    get_combat_form()
    get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    state.drain = M(false)
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
    
    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25','DEX+1','Weapon skill damage +7%','Accuracy+10 Attack+10',}}
    --Odyssean.Feet = {}
    --Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}

    Cichols = {}
    Cichols.TP = { name="Cichol's Mantle",  augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
    Cichols.WS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Cichols.VIT = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}

    Valorous = {}
    Valorous.Feet = {}
    Valorous.Body = {}
   
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    Valorous.Feet.TP = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+6','INT+1',}}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    
    Valorous.Body.STP = { name="Valorous Mail", augments={'Accuracy+30','"Store TP"+6','DEX+3','Attack+14',}}
    Valorous.Body.DA = { name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+4','VIT+4','Attack+6',}}
    
    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }

    sets.Organizer = {
        main="Chango",
        sub="Naegling", 
        body="Montante +1",
        hands="Shining One",
        ring1="Blurred Shield +1"
        --grip="Pearlsack",
        --waist="Linkpearl",
    }

    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
     -- Precast Sets
     -- Precast sets to enhance JAs
     --sets.precast.JA['Mighty Strikes'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Blood Rage'] = { body="Boii Lorica +3" }
     sets.precast.JA['Provoke'] = set_combine(sets.TreasureHunter, { hands="Pummeler's Mufflers +1"})
     sets.precast.JA['Berserk'] = { body="Pummeler's Lorica +3", hands="Agoge Calligae", back=Cichols.TP, feet="Agoge Calligae"}
     sets.precast.JA['Warcry'] = { head="Agoge Mask"}
     sets.precast.JA['Mighty Strikes'] = { head="Agoge Mufflers"}
     sets.precast.JA['Retaliation'] = { hands="Pummeler's Mufflers +1", feet="Ravager's Calligae +2"}
     sets.precast.JA['Aggressor'] = { head="Pummeler's Mask +1", body="Agoge Lorica"}
     sets.precast.JA['Restraint'] = { hands="Ravager's Mufflers +2"}
     sets.precast.JA['Warrior\'s Charge'] = { legs="Agoge Cuisses"}

     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     --sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = { head="" }
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
     sets.Lugra           = { ear1="Lugra Earring +1" }
     sets.Brutal          = { ear1="Brutal Earring" }
 
     sets.reive = {neck="Ygnas's Resolve +1"}
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        -- head="Yaoyotl Helm",
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
         ammo="Impatiens",
         head="Sakpata's Helm",
         ear1="Loquacious Earring",
         hands="Leyline Gloves",
         ring1="Weatherspoon Ring", -- 10 macc
         ring2="Prolix Ring",
         legs="Eschite Cuisses",
         feet="Odyssean Greaves"
     }
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     -- Midcast Sets
     sets.midcast.FastRecast = {
         ammo="Impatiens",
         head="Otomi Helm",
         feet="Odyssean Greaves"
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         head="Otomi Helm",
         feet="Odyssean Greaves"
     }
 
     -- Ranged for xbow
     sets.precast.RA = {
         head="",
         hands="",
         ring2="Crepuscular Ring",
         feet=""
     }
     sets.midcast.RA = {
         head="White rarab cap +1",
        --  neck="Iqabi Necklace",
         ear2="Crepuscular Earring",
         hands="Nyame Gauntlets",
         body="Nyame Mail",
         ring1="Cacoethic Ring +1",
         ring2="Crepuscular Ring",
         waist="Chaac Belt",
         legs="Nyame Flanchard",
         feet="Nyame Sollerets"
     }

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Knobkierrie",
         head="Sakpata's Helm",
         neck="Warrior's Bead Necklace +2",
         ear1="Thrud Earring",
         ear2="Moonshade Earring",
         body="Nyame Mail", --Pummeler's Lorica +3
         hands="Sakpata's Gauntlets",
         ring1="Niqmaddu Ring",
         ring2="Regal Ring",
         back=Cichols.WS,
         waist="Sailfi Belt +1",
         legs="Nyame Flanchard", --Odyssean.Legs.WS,
         feet="Nyame Sollerets" --Sulevia's Leggings +2"
     }

     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         hands="Odyssean Gauntlets",
        --  ammo="Ginsen",
         --body="Flamma Korazin +2",
        --  head="Valorous Mask",
         --body="Ravenous Breastplate",
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Cessance Earring",
         waist="Olseni Belt",
     })
    
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
         neck="Fotia Gorget",
         back=Cichols.VIT,
    	--body=Valorous.Body.DA, 
        waist="Fotia Belt",
    })
    sets.precast.WS['Upheaval'].Mid = set_combine(sets.precast.WS['Upheaval'], {
        head="Stinger Helm +1",
         back=Cichols.VIT,
    })
 
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
    	body="Nyame Mail",--Hjarrandi Breastplate",
        neck="Fotia Gorget",
        waist="Sailfi Belt +1",
        feet="Nyame Sollerets" --/Valorous.Feet.WS
    })
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
         head="Hjarrandi Helm",
         neck="Fotia Gorget",
         ear1="Schere Earring",
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses",
    	 body="Sakpata's Plate",
         waist="Fotia Belt",
         feet="Flamma Gambieras +2"
     })
     sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS.Resolution, {
         head="Flamma Zucchetto +2",
         ammo="Coiste Bodhar",
         --head="Valorous Mask",
     })
     sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
         head="Sakpata's Helm",
         ammo="Knobkierrie",
         neck="Fotia Gorget",
         legs=Odyssean.Legs.WS,
         waist="Caudata Belt"
     })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
        --  ammo="Ginsen",
         neck="Fotia Gorget",
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

    sets.precast.WS.Stardiver = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        waist="Fotia Belt",
        legs="Sakpata's Cuisses",
    })
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head="Valorous Mask",
        neck="Shadow Gorget",
        ear1="Thrud Earring",
        waist="Sailfi Belt +1",
        feet=Valorous.Feet.WS
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Impulse Drive'], {
        ammo="Knobkierrie",
        neck="Warrior's Bead Necklace +2",
        legs="Sakpata's Cuisses",
        waist="Sailfi Belt +1",
    })
     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         ear1="Friomisi Earring",
         hands="Odyssean Gauntlets",
         legs="Limbo Trousers",
     })
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         back=Cichols.WS,
         waist="Fotia Belt",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
     -- Resting sets
     sets.resting = {
         --head="Baghere Salade",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
     }
 
     -- Idle sets
     sets.idle.Town = {
         ammo="Coiste Bodhar",
         head="Hjarrandi Helm",
         neck="Warrior's Bead Necklace +2",
         ear1="Brutal Earring",
         ear2="Telos Earring",
         body="Sakpata's Plate",
         hands="Volte Moufles",
         ring1="Niqmaddu Ring",
         ring2="Regal Ring",
         waist="Sailfi Belt +1",
         back=Cichols.TP,
         legs="Sakpata's Cuisses",
         feet="Hermes' Sandals"
     }
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Staunch Tathlum +1",
         head="Sakpata's Helm",
         ear1="Etiolation Earring",
         ear2="Genmei Earring",
         neck="Sanctity Necklace",
         body="Sakpata's Plate",
         ring1="Paguroidea Ring",
         ring2="Defending Ring",
         hands="Volte Moufles",
         --waist="Asklepian Belt",
         legs="Sakpata's Cuisses",
         feet="Hermes' Sandals"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
         ear2="Infused Earring",
         hands="Volte Moufles",
         ring1="Paguroidea Ring",
     })
 
     sets.idle.Weak = set_combine(sets.idle.Field, {
         head="Hjarrandi Helm",
         body="Tartarus Platemail",
         ring2="Paguroidea Ring",
         waist="Flume Belt",
     })

     -- Defense sets
     sets.defense.PDT = {
         ammo="Staunch Tathlum +1",
         head="Sakpata's Helm", -- no haste
         body="Sakpata's Plate", -- 3% haste
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses", -- 5% haste
         feet="Sakpata's Leggings", -- 3% haste
         neck="Agitator's Collar",
         ring1="Niqmaddu Ring",
         ring2="Defending Ring",
         waist="Sailfi Belt +1",
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         ear1="Telos Earring",
     })
 
     sets.Kiting = {feet="Hermes' Sandals"}
 
     sets.Reraise = {head="Nyame Helm",body="Nyame Mail"}

     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         ammo="Crepuscular Pebble",
         head="Sakpata's Helm", -- no haste
         body="Sakpata's Plate", -- 3% haste
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses", -- 5% haste
         feet="Sakpata's Leggings", -- 3% haste
         neck="Agitator's Collar",
         ring2="Defending Ring",
         waist="Sailfi Belt +1",
     }
     sets.Defensive_Acc = set_combine(sets.Defensive, {
         neck="Warrior's Bead Necklace +2",
         ring2="Regal Ring",
     })
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         ammo="Coiste Bodhar",
         head="Flamma Zucchetto +2",
         neck="Warrior's Bead Necklace +2",
         ear1="Schere Earring",
         ear2="Dedition Earring",
    	 body="Sakpata's Plate",--Tatenashi Haramaki +1", 
         hands="Tatenashi Gote +1",
         ring1="Niqmaddu Ring",
         ring2="Petrov Ring",
         back=Cichols.TP,
         --waist="Ioskeha Belt",
         waist="Sailfi Belt +1",
         --legs="Pummeler's Cuisses +2",
         legs= "Tatena. Haidate +1",
         feet="Flamma Gambieras +2"
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
         head="Hjarrandi Helm",
         ammo="Coiste Bodhar",
         neck="Warrior's Bead Necklace +2",
         ear1="Schere Earring",
         ear2="Brutal Earring",
         body="Sakpata's Plate",
         --hands="Flamma Manopolas +2",
         hands="Sakpata's Gauntlets",
         ring1="Niqmaddu Ring",
         ring2="Flamma Ring",
         waist="Ioskeha Belt",
         legs="Tatenashi Haidate +1",
         feet="Tatenashi Sune-ate +1"
    	 --body="Flamma Korazin +2"
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         ammo="Ginsen",
         body="Sakpata's Plate",
         ear1="Telos Earring",
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses"
        --  back="Grounded Mantle +1",
     })

     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

     sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        hands="Emicho Gauntlets",
        waist="Shetal Stone"
     })
     sets.engaged.OneHand = set_combine(sets.engaged, {
         head="Hjarrandi Helm",
    	 body="Hjarrandi Breastplate", 
         ear1="Telos Earring",
         ear2="Cessance Earring",
         waist="Ioskeha Belt",
         legs="Tatenashi Haidate +1",
         feet="Tatenashi Sune-ate +1",
         --ring2="Hetairoi Ring"
         ring2="Flamma Ring"
        --ring1="Hetairoi Ring",
     })
     sets.engaged.OneHand.PDT = set_combine(sets.engaged.OneHand, sets.Defensive)
     sets.engaged.OneHand.Mid = set_combine(sets.engaged.OneHand, {
         body="Sakpata's Plate",
     })
     sets.engaged.OneHand.Mid.PDT = set_combine(sets.engaged.OneHand.Mid, sets.Defensive)

     sets.engaged.GreatSword = set_combine(sets.engaged, {
         ear1="Schere Earring",
         ear2="Brutal Earring",
     })
     sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {
         ear1="Telos Earring",
         --back="Grounded Mantle +1"
         --ring2="K'ayres RIng"
     })
     sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	--head="Twilight Helm",neck="Twilight Torque",
     	--body="Twilight Mail"
     })
     sets.buff.Berserk = { 
         --feet="Warrior's Calligae +2" 
     }
     sets.buff.Retaliation = { 
         hands="Pummeler's Mufflers +1"
     }
    
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
	--if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        --if is_sc_element_today(spell) then
            --if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            --else
                --equip(sets.WSDayBonus)
            --end
        --end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
        -- if player.tp > 2999 then
        --     equip(sets.BrutalLugra)
        -- else -- use Lugra + moonshade
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         equip(sets.Lugra)
        --     else
        --         equip(sets.Brutal)
        --     end
        -- end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end
--end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
        get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end
    
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
    get_combat_form()
    get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    --if war_sj then
        --state.CombatForm:set("War")
    --else
        --state.CombatForm:reset()
    --end
    if S{'NIN', 'DNC'}:contains(player.sub_job) and war_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    elseif S{'SAM', 'WAR'}:contains(player.sub_job) and player.equipment.sub == 'Blurred Shield +1' then
        state.CombatForm:set("OneHand")
    else
        state.CombatForm:reset()
    end

end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 8)
	else
		set_macro_page(1, 8)
	end
end

