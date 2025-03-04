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
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+H ]           Cycle Helix Mode
--              [ WIN+R ]           Cycle Regen Mode
--              [ WIN+S ]           Toggle Storm Surge
--
--  Abilities:  [ CTRL+` ]          Immanence
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
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

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--                gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar power          Rapture                     Ebullience
--              gs c scholar duration       Perpetuance
--              gs c scholar accuracy       Altruism                    Focalization
--              gs c scholar enmity         Tranquility                 Equanimity
--              gs c scholar skillchain                                 Immanence
--              gs c scholar addendum       Addendum: White             Addendum: Black


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
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
    -- state.CP = M(false, "Capacity Points Mode")

    update_active_strategems()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II'}
        }

    lockstyleset = 10

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('DT', 'Enmity', 'Refresh')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line
    include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^` input /ja Immanence <me>')
    send_command('bind PAGEUP gs c toggle MagicBurst')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^[ gs c scholar power')
    send_command('bind ^] gs c scholar accuracy')
    send_command('bind ^; gs c scholar speed')
    send_command('bind !w input /ma "Aspir II" <t>')
    send_command('bind !o input /ma "Regen V" <stpc>')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !] gs c scholar duration')
    send_command('bind !; gs c scholar cost')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @h gs c cycle HelixMode')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind HOME input /equip ring1 "Warp Ring"; input /echo Warping; /input /wait 11 ; input /item "Warp Ring" <me>;')
	send_command('bind ^HOME input /equip ring2 "Dim. Ring (Mea)"; /echo Reisenjima; input /wait 11; input /item "Dim. Ring (Mea)" <me>;')

    send_command('bind ^numpad0 input /Myrkr')

    include('Global-Binds.lua')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^;')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind !;')
    send_command('unbind ^,')
    send_command('unbind !.')
    -- send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind @s')
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

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engage Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.engaged = {
        main="Musa",
	sub="Khonsu",
	ammo="Oshasha's Treatise",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Sibyl Scarf",
	waist="Fucho-no-Obi",
	ear1="Enervating Earring",
	ear2="Cessance Earring",
	ring1="Apate Ring",
	ring2="Rajas Ring",
	back="Aurist's Cape +1",
	}
		
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
	sets.precast.JA['Light Arts'] = {
	head="Acad. Mortar. +3",
	body="Arbatel Gown +3",
	hands="Acad. Bracers +3",
	legs="Acad. Pants +2",
	feet="Acad. Loafers +2",
	}
    sets.precast.JA['Dark Arts'] = set_combine(sets.precast.JA['Light Arts'], {})
    sets.precast.JA['Accesion'] = set_combine(sets.precast.JA['Light Arts'], {})
    sets.precast.JA['Perpetuance'] = set_combine(sets.precast.JA['Light Arts'], {})
    sets.precast.JA['Manifestation'] = set_combine(sets.precast.JA['Light Arts'], {})
    sets.precast.JA['Ebullience'] = set_combine(sets.precast.JA['Light Arts'], {})
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"}
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"}
    sets.precast.JA['Sublimation'] = {
        main="Musa",
        sub="Enki Strap",
        head="Acad. Mortar. +3",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Eabani Earring",
        ear2="Savant's Earring",
        ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",
        waist="Carrier's Sash",
        }

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
	main="Musa", --10
        sub="Khonsu",
        head="Acad. Mortar. +3", --8
        body="Agwu's Robe", --8
	hands="Acad. Bracers +3", --9
        legs="Agwu's Slops", --7
        feet="Acad. Loafers +2", --4
        ear1="Malignance Earring", --4
        ear2="Etiolation Earring", --1
	ring1="Kishar Ring", --4
        ring2="Weather. Ring", --5
        waist="Embla Sash", --5
	back={ name="Lugh's Cape", augments={'"Fast Cast"+10',}},
        } --75 (+15)

    sets.precast.FC.Grimoire = set_combine(sets.precast.FC,{})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})




    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2={name="Stikini Ring +1", bag="wardrobe2"},})


    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
	head="Vanya Hood",
        ring2="Weather. Ring", --5/(4)
	ear1="Mendicant's Earring",
        back="Fi Follet Cape +1", --(4)
        waist="Embla Sash",
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        ammo="Sapience Orb", --2
        head=empty,
        body="Twilight Cloak",
        hands="Gende. Gages +1", --7
        neck="Orunmila's Torque", --5
        ear1="Malignance Earring", --4
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        back="Swith Cape +1", --4
        waist="Shinjutsu-no-Obi +1", --5
        })

    sets.precast.FC.Utsusemi = sets.precast.FC.Cure


    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        legs="Carmine Cuisses +1", --20
        neck="Loricate Torque +1", --5
        ear2="Magnetic Earring", --8
  }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Cure = {
	main="Chatoyant Staff",
        sub="Khonsu", 
	ammo="Staunch Tathlum +1",
        head="Kaykaus Mitra +1",
        body="Arbatel Gown +3", 
        hands="Nyame Gauntlets",
        legs="Acad. Pants +2",
        feet="Kaykaus Boots +1",
	neck="Loricate Torque +1",
	ear1="Mendicant's Earring", --5/(-5)
	ear2="Calamitous Earring",
	ring1="Defending Ring",
	ring2={ name="Mephitas's Ring +1", augments={'Path: A',}},
	waist="Hachirin-no-Obi",
	back="Fi Follet Cape +1",
	}

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
	legs="Acad. Pants +2",
        feet="Vanya Clogs",
}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {})

    sets.midcast['Enhancing Magic'] = {
        main="Musa",
        sub="Enki Strap",
	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
	body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back="Fi Follet Cape +1",
        waist="Embla Sash",
        }

    sets.midcast.EnhancingDuration = {
	main="Musa",
	sub="Enki Strap",
	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
	body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
	hands="Arbatel Bracers +3",
	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
	neck={ name="Argute Stole +2", augments={'Path: A',}},
	waist="Embla Sash",
	ear1="Malignance Earring",
	ring2={ name="Mephitas's Ring +1", augments={'Path: A',}},
	back="Fi Follet Cape +1",
	}

    sets.midcast.EnhancingSkill = {}

   sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Musa",
        sub="Enki Strap",
        head="Arbatel Bonnet +3",
	back={ name="Lugh's Cape", augments={'"Fast Cast"+10',}},
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        back={ name="Lugh's Cape", augments={'"Fast Cast"+10',}},
        })
		


    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.RefreshSelf =  set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
  	left_ear="Earthcry Earring",
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
	})

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = {}
    sets.midcast.SpikesSpell = {}

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell


     -- Custom spell classes

     -- Custom spell classes
    sets.midcast.MndEnfeebles = {
	main="Daybreak",
	ammo="Pemphredo Tathlum",
	legs="Acad. Pants +2",
	feet="Acad. Loafers +2",
	neck="Argute Stole +2",
	ear1="Malignance Earring",
	ear2="Regal Earring",
	ring1="Kishar Ring",
	ring2="Metamor. Ring +1",
	back="Aurist's Cape +1",
	waist="Sacro Cord",
	}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        head="Acad. Mortar. +3",
        })

    sets.midcast.ElementalEnfeeble = sets.midcast.Enfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak"})

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Acad. Mortar. +3",
        feet="Acad. Loafers +2",
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Aurist's Cape +1",
        }

    sets.midcast.Kaustra = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Agwu's Robe",
        hands="Amalric Gages +1", --(5)
        legs="Amalric Slops +1",
        feet="Almaric Nails +1",
        neck="Argute Stole +2", --10
        ear1="Malignance Earring",
	ear2="Regal Earring",
        ring2="Archon Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
        waist="Hachirin-no-Obi",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        back=gear.SCH_MAB_Cape,
        })

    -- wal Magic
    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Arbatel Bonnet +3",
        body="Arbatel Gown +3",
        hands="Arbatel Bracers +3",
        legs="Arbatel Pants +3",
        feet="Arbatel Loafers +3",
        neck="Argute Stole +2",
        ear1="Malignance Earring",
	ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
	waist="Sacro Cord",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
       }

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        head=empty,
        body="Twilight Cloak",
        ring2="Archon Ring",
        waist="Shinjutsu-no-Obi +1",
        })

    sets.midcast.Helix = {
        main="Bunzi's Rod",
        sub="Culminus",
	ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
	head="Agwu's Cap",
	body="Agwu's Robe",
	hands="Amalric Gages +1",
	legs="Agwu's Slops",
	feet="Amalric Nails +1",
	neck={ name="Argute Stole +2", augments={'Path: A',}},
	waist="Skrymir Cord",
	ring1="Freke Ring",
        ring2="Mallquis Ring",
	ear1="Malignance Earring",
	ear2="Regal Earring",
	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}


    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
        })

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
        main="Daybreak",
        ring2="Weather. Ring"
        })
		
	sets.magic_burst = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Arbatel Bonnet +3",
        body="Arbatel Gown +3",
        hands="Amalric Gages +1",
        legs="Agwu's Slops",
        feet="Arbatel Loafers +3",
        neck="Argute Stole +2",
	waist="Sacro Cord",
        ear1="Malignance Earring",
	ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
        
        }

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.idle.DT = {
	main="Musa",
	sub="Khonsu", --6
	ammo="Staunch Tathlum +1", --3
	head="Nyame Helm", --7
	body="Shamash Robe", --10
	hands="Nyame Gauntlets", --7
	legs="Nyame Flanchard", --8
	feet="Nyame Sollerets", --7
	neck="Warder's Charm +1",
	waist="Carrier's Sash",
	ear1="Eabani Earring",
	ear2="Etiolation Earring",
	ring1={name="Stikini Ring +1", bag="wardrobe1"},
	ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}


    sets.idle.Enmity = {
	main="Musa",
	sub="Khonsu",
	ammo="Staunch Tathlum +1",
	head="Acad. Mortar. +3",
	body="Shamash Robe",
	hands="Acad. Bracers +3",
	legs="Acad. Pants +2",
	feet="Acad. Loafers +2",
	neck="Warder's Charm +1",
	waist="Carrier's Sash",
	ear1="Eabani Earring",
	ear2="Etiolation Earring",
	ring1="Defending Ring",
	ring2="Warden's Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
    sets.idle.Refresh = {
	main="Musa",
	sub="Khonsu",
	ammo="Staunch Tathlum +1",
	head="Volte Beret",
	body="Shamash Robe",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Sibyl Scarf",
	waist="Fucho-no-Obi",
	ear1="Hearty Earring",
	ear2="Etiolation Earring",
	ring1={name="Stikini Ring +1", bag="wardrobe1"},
	ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}

	
	sets.idle.Town = set_combine(sets.idle.Enmity, {
	main="Musa",
	sub="Khonsu",
	})

    sets.resting = set_combine(sets.idle.Refresh, {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT



    sets.Kiting = {feet="Herald's Gaiters"}
   




    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}
	
	sets.buff.Perpetuance = {
	hands="Arbatel bracers +3",
	}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spellMap == "Helix" then
            equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
            if state.HelixMode.value == 'Duration' then
                equip(sets.Bookworm)
            end
        end
        if buffactive['Klimaform'] and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
            equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
        if spell.english == "Impact" then
            equip(sets.midcast.Impact)
        end
    end
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if (spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element])) and spellMap ~= 'Helix' then
            equip(sets.Obi)
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Sacro Cord"})
        -- Matching day and weather.
       elseif (spell.element == world.day_element and spell.element == world.weather_element) and spellMap ~= 'Helix' then
            equip(sets.Obi)
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Sacro Cord"})
        -- Match day or weather.
       elseif (spell.element == world.day_element or spell.element == world.weather_element) and spellMap ~= 'Helix' then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
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
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_rings()
    check_moving()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_active_strategems()
    update_sublimation()
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local h_msg = state.HelixMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
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

function check_rings()
    rings = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    if rings:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end

    if rings:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
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
    set_macro_page(1, 4)
end

function set_lockstyle()
    send_command('@wait 8;input /lockstyleset 05')
end