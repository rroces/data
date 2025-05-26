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