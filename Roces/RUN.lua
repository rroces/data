--------------------------------------------------------------------------------------------------------------------- Setup functions for this job.  Generally should not be modified.
------------------------------------------------------------------------------------------------------------
--OffenseMode = F9. Weaponskill Mode = Windows Key + F9. Idle mode = CTRL + F12. Casting Mode = CTRL + F11. 

--[[
	To optimise:
	
]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
	
	local player = windower.ffxi.get_player()
	
	lockstyleset = 20
end	
------------------------------------------------------------------------------------------------------------
------- User setup functions for this job.  Recommend that these be overridden in a sidecar file.	-------
------------------------------------------------------------------------------------------------------------
function user_setup()
    state.OffenseMode:options('TP','DTParry','MEva')
    state.WeaponskillMode:options('Normal', 'DT', 'Acc' ,'CappedAttack')
    state.PhysicalDefenseMode:options('DT', 'Resist')
    state.IdleMode:options('HPDT','VITDefense', 'Refresh', 'Phalanx')
	state.CastingMode:options('Normal', 'sird')
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
	
	state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart','Lycurgos'}
	state.WeaponLock = M(false, 'Weapon Lock')
	
	send_command('bind delete input /item Panacea <me>')
    send_command('bind end input /item Remedy <me>')
    send_command('bind pagedown input /item "Holy Water" <me>')
	
	send_command('bind numpad6 gs c cycle WeaponSet')
    send_command('bind numpad4 gs c cycle WeaponLock')

	select_default_macro_book()
	set_lockstyle()
end

function user_unload()
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind pagedown')
	send_command('unbind numpad6')
	send_command('unbind numpad4')
end

function init_gear_sets()
	sets.Epeolatry = {main="Epeolatry", sub="Utu Grip"}
    sets.Lycurgos = {main="Lycurgos", sub="Utu Grip"}
    sets.Lionheart = {main="Lionheart", sub="Utu Grip"}

    sets.enmity = { --55% PDT/DT / +79 Enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head={name="Halitus Helm", priority=3},
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist={name="Plat. Mog. Belt", priority=5},
		left_ear={name="Etiolation Earring", priority=1},
		right_ear={name="Cryptic Earring", priority=2},
		left_ring="Supershear Ring",
		right_ring={name="Moonlight Ring", priority=4},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}, }
		
	sets.EnhancingSkill = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={name="Nyame Mail", priority=3},
		hands="Runeist Mitons +3",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		feet="Erilaz Greaves +3",
		neck="Enhancing Torque",
		waist="Cascade Belt",
		left_ear={name="Etiolation Earring", priority=1},
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring",
		right_ring={name="Stikini left_ring", priority=2},
		back={name="Moonlight Cape", priority=4}}
		
	sets.Sird = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={ name="Taeon Tabard", augments={'Accuracy+22','Spell interruption rate down -10%','Phalanx +3',}},
		hands="Rawhide Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		feet={ name="Taeon Boots", augments={'Accuracy+17','Spell interruption rate down -10%','Crit. hit damage +3%',}},
		neck="Moonbeam Necklace",
		waist={name="Plat. Mog. Belt", priority=3},
		left_ear={ name="Tuisto Earring", priority=2},
		right_ear="Erilaz Earring +2",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", priority=1},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}	
		
    sets.Cures = { -- Capped DT, 3350~ HP, +70 enmity
		ammo="Sapience Orb",
		head="Null Masque",
		body={name="Runeist Coat +3", priority=3},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Sroda Belt",
		left_ear="Mendi. Earring",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Supershear Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%','Phys. dmg. taken-10%',}},}
			
	--------------------------------------
	-- Precast sets
	--------------------------------------
    sets.precast.JA['Vallation'] = { -- +73 enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head="Halitus Helm",
		body={name="Runeist Coat +3", priority=2},
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Trance Belt",
		left_ear={name="Tuisto Earring", priority=1},
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
		
    sets.precast.JA['Valiance'] = { -- +73 enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head="Halitus Helm",
		body={name="Runeist Coat +3", priority=3},
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Trance Belt",
		left_ear={name="Tuisto Earring", priority=1},
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
				
    sets.precast.JA['Pflug'] = { -- +84 enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head="Halitus Helm",
		body={name="Emet Harness +1", priority=1},
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist={name="Plat. Mog. Belt", priority=3},
		left_ear={name="Tuisto Earring", priority=2},
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring="Begrudging Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
			
    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {
		hands="Futhark Bandeau +3"})
	
    sets.precast.JA['Elemental Sforzo'] = { -- +76 Enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head="Halitus Helm",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={name="Futhark Torque +2", priority=1},
		waist={name="Plat. Mog. Belt", priority=2},
		left_ear="Friomisi Earring",
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring="Begrudging Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
	
    sets.precast.JA['Liement'] = { -- +73 Enmity w/o weapon/crusade
		ammo="Sapience Orb",
		head="Halitus Helm",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={name="Futhark Torque +2", priority=1},
		waist={name="Plat. Mog. Belt", priority=2},
		left_ear="Friomisi Earring",
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring="Begrudging Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
	
    sets.precast.JA['Lunge'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Agwu's Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Agwu's Slops", augments={'Path: A',}},
		feet={ name="Herculean Boots", augments={'"Resist Silence"+11','Accuracy+2','Magic burst dmg.+15%','Accuracy+12 Attack+12','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Hermetic Earring",
		left_ring="Defending Ring",
		--left_ring="Mujin Band",
		right_ring="Locus Ring",
		back={ name="Ogma's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}		
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
	
    sets.precast.JA['Gambit'] = set_combine(sets.enmity, {
		hands="Runeist Mitons +3"})
	
    sets.precast.JA['Rayke'] = set_combine(sets.enmity,  {
		feet="Futhark Boots +3"})
		
    sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {hands="Futhark Mitons +3"})
	
    sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}
	
    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {
		head="Erilaz Galea +3", 
		legs="Runeist Trousers +1",
		back={name="Moonlight Cape", priority=2},
		left_ring="Defending Ring", 
		right_ring={name="Moonlight Ring", priority=1},})
		
    sets.precast.JA['One for All'] = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3", 
		body={name="Runeist Coat +3", priority=5},
		hands="Regal Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Turms Leggings +1",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist={name="Plat. Mog. Belt", priority=4},
		left_ear={name="Tuisto Earring", priority=1},
		right_ear={ name="Odnowa Earring +1", priority=3},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring={name="Moonlight Ring", priority=2},
		back={name="Moonlight Cape", priority=6},}
	
	sets.precast.JA['Odyllic Subterfuge'] = sets.enmity
	
    sets.precast.JA['Provoke'] = sets.enmity
	
	sets.precast.JA['Souleater'] = sets.enmity
	
    sets.precast.JA['Last Resort'] = sets.enmity

	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",
		head="Rune. Bandeau +2",
		body="Erilaz Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Agwu's Slops",
		feet={ name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3',}},
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist={name="Plat. Mog. Belt", priority=2},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring={name="Moonlight Ring", priority=1},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}		
			-- Fast Cast: 55%  / 30% Inspiration
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		back={name="Moonlight Cape", priority=2},
		right_ring={name="Moonlight Ring", priority=1},
		waist="Siegel Sash", 
		head="Erilaz Galea +3",
		legs="Futhark Trousers +3"})

	sets.precast.FC['Ninjitsu Magic'] = set_combine(sets.precast.FC, {
		neck="Magoraga Beads"})
	
	sets.precast.JA['Arcane Circle'] = sets.enmity

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
	
    sets.precast.WS['Resolution'] = {
	    ammo="Crepuscular Pebble",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
		
    sets.precast.WS['Resolution'].DT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=3},
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Paguroidea Ring",
		right_ring={ name="Gelatinous Ring +1", priority=2},
		back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}	
		
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},})
		
	sets.precast.WS['Resolution'].CappedAttack = set_combine(sets.precast.WS['Resolution'].Normal, {
	    ammo="Crepuscular Pebble",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})

    sets.precast.WS['Dimidiation'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
		
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		body="Nyame Mail",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},})
		
	sets.precast.WS['Dimidiation'].DT = set_combine(sets.precast.WS['Dimidiation'], {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist={name="Plat. Mog. Belt", priority=1},
		left_ear={name="Tuisto Earring", priority=3},
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},})
		
    sets.precast.WS['Herculean Slash'] = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",	
		feet="Erilaz Greaves +3",
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=2},
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Paguroidea Ring",
		right_ring={ name="Gelatinous Ring +1", priority=3},
		back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}	
		
	sets.precast.WS['Shockwave'] = {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",	
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}}
		
	sets.precast.WS['Swift Blade'] = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
	
	sets.precast.WS['Sanguine Blade'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Orpheus's Sash",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
		
    sets.precast.WS['Requiescat'] = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
    sets.precast.WS['Ground Strike'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
		
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS['Ground Strike'].Normal, {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		body="Nyame Mail",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Defending Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},})
		
	sets.precast.WS['Armor Break'] = {
		ammo="Yamarang",
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Erilaz Gauntlets +3",
		legs="Eri. Leg Guards +3",	
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Crep. Earring",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Chirich Ring +1",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}}
		
	sets.precast.WS['Decimation'] = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
	sets.precast.WS['Rampage'] = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},		
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
	--------------------------------------
	-- Midcast sets
	--------------------------------------
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3", 
		body="Nyame Mail",
		hands="Regal Gauntlets",
		legs="Futhark Trousers +3", 
		feet="Erilaz Greaves +3", 
	    neck="Futhark Torque +2", 
		waist="Engraved Belt", 		
		left_ear="Etiolation Earring", 
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Defending Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},}
		
    sets.midcast['Phalanx'] =  {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Herculean Vest", augments={'MND+2','Pet: INT+4','Phalanx +4','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		hands={ name="Herculean Gloves", augments={'Rng.Acc.+21','Pet: "Subtle Blow"+4','Phalanx +5','Accuracy+10 Attack+10',}},
		legs={ name="Herculean Trousers", augments={'Pet: DEX+3','Pet: INT+6','Phalanx +4','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		feet={ name="Herculean Boots", augments={'Weapon skill damage +3%','"Subtle Blow"+4','Phalanx +4','Accuracy+17 Attack+17',}},
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist={name="Plat. Mog. Belt", priority=3},
		left_ear="Etiolation Earring",
		right_ear="Erilaz Earring +2",
		left_ring={ name="Gelatinous Ring +1", priority=2},
		right_ring={name="Moonlight Ring", priority=1},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}		
    
	sets.midcast['Regen IV'] = set_combine(sets.idle.VITDefense, {
		head="Runeist Bandeau +2", 
		body={ name="Nyame Mail", augments={'Path: B',}},	
		hands="Regal Gauntlets", 
		legs="Futhark Trousers +3", 
		neck="Sacro Gorget",
		waist="Sroda Belt",
		right_ear="Erilaz Earring +2",})
    
	sets.midcast['Stoneskin'] = set_combine(sets.idle.VITDefense, {
		head="Runeist Bandeau +2", 
		body={ name="Nyame Mail", augments={'Path: B',}},		
		legs="Futhark Trousers +3", 
		hands="Regal Gauntlets", 
		neck="Futhark Torque +2",
		waist="Siegel Sash"})
	
	sets.midcast['Flash'] = sets.enmity
	
	sets.midcast['Stun'] = sets.enmity
	
	sets.midcast['Stun'].Macc = sets.midcast['Blind']	
	
	sets.midcast['Foil'] = set_combine(sets.enmity, {
		head="Erilaz Galea +3",})
		
	sets.midcast['Blind'] = {
		ammo="Pemphredo Tathlum",
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Agwu's Gages",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Gwati Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back="Null Shawl"}
		
	sets.midcast['Refresh'] = set_combine(sets.idle.VITDefense, {
		head="Erilaz Galea +3", 
		body={ name="Nyame Mail", augments={'Path: B',}},		
		hands="Regal Gauntlets", 
		legs="Futhark Trousers +3", 
		waist="Gishdubar Sash"})
    
	sets.midcast['Temper'] = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={name="Runeist Coat +3", priority=3},
		hands="Runeist Mitons +3",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		feet="Erilaz Greaves +3",
		neck="Enhancing Torque",
		waist="Engraved Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", priority=2},
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back={name="Moonlight Cape", priority=1},}
		
	sets.midcast['Shell V'] = set_combine(sets.idle.VITDefense, {
		body={ name="Nyame Mail", augments={'Path: B',}},		
		head="Erilaz Galea +3", 
		legs="Futhark Trousers +3", 
		hands="Regal Gauntlets"})
		
	sets.midcast['Barfire'] = sets.EnhancingSkill
		
	sets.midcast['Barblizzard'] = sets.EnhancingSkill
		
	sets.midcast['Baraero'] = sets.EnhancingSkill
		
	sets.midcast['Barstone'] = sets.EnhancingSkill
		
	sets.midcast['Barthunder'] = sets.EnhancingSkill
		
	sets.midcast['Barwater'] = sets.EnhancingSkill
		
	sets.midcast['Barpoison'] = sets.EnhancingSkill
		
	sets.midcast['Barparalyze'] = sets.EnhancingSkill
		
	sets.midcast['Barsleep'] = sets.EnhancingSkill
		
	sets.midcast['Baramnesia'] = sets.EnhancingSkill
		
	sets.midcast['Barblind'] = sets.EnhancingSkill
		
	sets.midcast['Barpetrify'] = sets.EnhancingSkill
		
	sets.midcast['Barvirus'] = sets.EnhancingSkill
		
	sets.midcast['Barsilence'] = sets.EnhancingSkill
		
	sets.midcast['Poisonga'] = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=2},
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Paguroidea Ring",
		right_ring={ name="Gelatinous Ring +1", priority=2},
		back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}	
		
	sets.midcast['Utsusemi: Ichi'] = sets.idle.HPDT
			
	sets.midcast['Utsusemi: Ni'] = sets.midcast['Utsusemi: ichi']
	
    sets.midcast['Cure III'] = sets.Cures
	
    sets.midcast['Cure IV'] = sets.Cures
	
	sets.midcast['Wild Carrot'] = sets.Cures
		
	sets.midcast['Healing Breeze'] = sets.Cures
	
	sets.midcast['Magic Fruit'] = sets.Cures
----------------------------------------------------	
    sets.midcast['Cure III'].sird = sets.Sird	
	
    sets.midcast['Cure IV'].sird = sets.Sird
	
	sets.midcast['Wild Carrot'].sird = sets.Sird
		
	sets.midcast['Healing Breeze'].sird = sets.Sird
	
	sets.midcast['Magic Fruit'].sird = sets.Sird

	sets.midcast['Refueling'] = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}

	sets.midcast['Cocoon'] = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=2},
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Paguroidea Ring",
		right_ring={ name="Gelatinous Ring +1", priority=2},
		back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}	
		
	sets.midcast['Cocoon'].sird = sets.Sird	
	
	sets.midcast['Geist Wall'] = sets.enmity

	sets.midcast['Stinking Gas'] = sets.enmity

	sets.midcast['Blank Gaze'] = sets.enmity
	
	sets.midcast['Jettatura'] = sets.enmity
	
	sets.midcast['Soporific'] = sets.enmity
	
	sets.midcast['Sheep Song'] = sets.idle.VITDefense
	
	sets.midcast['Stinking Gas'] = sets.enmity
	
	sets.midcast['Stinking Gas'].sird = sets.Sird
	
	sets.midcast['Poisonga'].sird = sets.Sird
	
	sets.midcast['Curing Waltz III'] = sets.Cures

	sets.midcast['Curing Waltz II'] = sets.Cures

	sets.midcast['Curing Waltz'] = sets.Cures
		
	sets.midcast['Divine Waltz'] = sets.Cures
	
	
	--1434 acc w/o food
	sets.precast.JA['Box Step'] = {
		ammo="Yamarang",
		head="Rune. Bandeau +2",
		body="Runeist Coat +3",
		hands="Runeist Mitons +3",
		legs="Rune. Trousers +1",
		feet="Runeist Boots +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Defending Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}
		
	sets.midcast['Stutter Step'] = {
		ammo="Yamarang",
		head="Rune. Bandeau +2",
		body="Runeist Coat +3",
		hands="Runeist Mitons +3",
		legs="Rune. Trousers +1",
		feet="Runeist Boots +3",
		neck="Futhark Torque +2",
		waist="Kentarch Belt +1",
		left_ear="Mache Earring +1",
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Defending Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}

	--------------------------------------
	-- Idle/resting/defense/etc sets -----
	--------------------------------------
	sets.idle.HPDT = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body={name="Runeist Coat +3", priority=3},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Etiolation Earring",
		right_ear="Erilaz Earring +2",
		left_ring="Gurebu's Ring",
		back={name="Moonlight Cape", priority=1},
		right_ring={name="Moonlight Ring", priority=2},}
			
	sets.idle.Refresh = {
		ammo="Homiliary",
		head="Null Masque",
		body={name="Runeist Coat +3", priority=5},
		hands={name="Regal Gauntlets",priority=3},
		legs={name="Herculean Trousers", augments={'"Blood Boon"+8','"Drain" and "Aspir" potency +1','"Refresh"+2',}},
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist={name="Fucho-no-Obi", priority=1},
		left_ear="Hearty Earring",
		right_ear="Erilaz Earring +2",
		left_ring="Gurebu's Ring",
		right_ring="Stikini Ring +1",
		back={name="Moonlight Cape", priority=4},}
			
    sets.idle.VITDefense = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=3},
		right_ear={ name="Odnowa Earring +1", priority=1},
		left_ring="Paguroidea Ring",
		right_ring={ name="Gelatinous Ring +1", priority=2},
		back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','DEF+50',}},}	
		          
	sets.idle.Phalanx = {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Herculean Vest", augments={'MND+2','Pet: INT+4','Phalanx +4','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		hands={ name="Herculean Gloves", augments={'Rng.Acc.+21','Pet: "Subtle Blow"+4','Phalanx +5','Accuracy+10 Attack+10',}},
		legs={ name="Herculean Trousers", augments={'Pet: DEX+3','Pet: INT+6','Phalanx +4','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		feet={ name="Herculean Boots", augments={'Weapon skill damage +3%','"Subtle Blow"+4','Phalanx +4','Accuracy+17 Attack+17',}},
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist={name="Plat. Mog. Belt", priority=3},
		left_ear="Etiolation Earring",
		right_ear="Erilaz Earring +2",
		left_ring={ name="Gelatinous Ring +1", priority=2},
		right_ring={name="Moonlight Ring", priority=1},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}		
		
	sets.Kiting = {right_ring="Shneddick Ring"}

	--------------------------------------               
	-- Engaged sets
	--------------------------------------
    sets.engaged.TP = {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		--legs="Eri. Leg Guards +3",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		--feet="Erilaz Greaves +3",
		feet={ name="Herculean Boots", augments={'Attack+5','Crit.hit rate+1','Quadruple Attack +3','Accuracy+10 Attack+10','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		neck="Anu Torque",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
	sets.engaged.Hybrid = {
		ammo="Aurgelmir Orb",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Turms Mittens +1",
		legs="Meg. Chausses +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}

	sets.engaged.DTParry = { --Wing of War DT Parry set
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Erilaz Surcoat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
	    waist="Plat. Mog. Belt",
		left_ear={name="Tuisto Earring", priority=3},
		right_ear="Eabani Earring",
		left_ring="Gurebu's Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},}
		
	--[[Normal DT Parry set: 
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Nyame Mail",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
	    waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=3},
		right_ear="Eabani Earring",
		left_ring="Gurebu's Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},}
		]]
		
	--[[ August Master trial/Arebati V25 tank set:
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body={name="Runeist Coat +3", priority=5},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist={name="Plat. Mog. Belt", priority=4},
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Gurebu's Ring",
		right_ring={name="Moonlight Ring", priority=2},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
	]]	
		
	sets.engaged.MEva = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={name="Runeist Coat +3", priority=1},
		--hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		--waist={name="Plat. Mog. Belt", priority=2},
		waist="Engraved Belt",
		left_ear={name="Tuisto Earring", priority=4},
		right_ear="Erilaz Earring +2",
		left_ring="Gurebu's Ring",
		right_ring={name="Moonlight Ring", priority=3},
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},}
	  
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.main_job == 'RUN' then
		set_macro_page(1, 20)
	end
end

function job_buff_change(buff, gain)
    if buff == "doom" or buff == "doomed" then
		if gain then
			equip({neck="Nicander's Necklace", Waist="Gishdubar Sash"})
            disable('neck','waist')
		else
			enable('neck','waist')
		end
	end

    if buff == "Embolden" then
		if gain then
			add_to_chat(158,'[Embolden] ON -- Back Locked')
			equip({back="Evasionist's Cape"})
            disable('back')
		else
			enable('back')
			add_to_chat(123,'[Embolden] OFF -- Back Unlocked')
		end
	end
	
	if player.equipment.main == "Epeolatry" then
		if buff == "Aftermath: Lv.3" then
			if gain then
				send_command('input //timers c "AM3" 180')
			else 
				send_command('timers d "AM3"')
			end	
		elseif buff == "Aftermath: Lv.2" then
			if gain then
				send_command('input //timers c "AM2" 120')
			else
				send_command('timers d "AM2"')
			end	
		elseif buff == "Aftermath: Lv.1" then
			if gain then
				send_command('input //timers c "AM1" 90')
			else
				send_command('timers d "AM1"')
			end	
		end	
	end	
	
	if player.equipment.main == "Lionheart" then
		if buff == "Aftermath: Lv.3" then
			if gain then
				send_command('input //timers c "AM3" 180')
			else 
				send_command('timers d "AM3"')
			end	
		elseif buff == "Aftermath: Lv.2" then
			if gain then
				send_command('input //timers c "AM2" 180')
			else
				send_command('timers d "AM2"')
			end	
		elseif buff == "Aftermath: Lv.1" then
			if gain then
				send_command('input //timers c "AM1" 180')
			else
				send_command('timers d "AM1"')
			end	
		end	
	end
end 

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
    
	if spell.type == 'WeaponSkill' and player.target.distance > (3.4 + player.target.model_size) then 
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        eventArgs.cancel = true        
        return
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	
	if spell.type == "WeaponSkill" then 
		add_to_chat(217, 'TP Return: '..tostring(player.tp))
    end
	
	if spell.english == "Gambit" and spell.interrupted == false then 
	   send_command('input /p Gambit on')
	   send_command('input //timers c "Gambit" 96')
	   send_command('@wait 96; input /p Gambit off')
    end
	if spell.english == "Rayke" and spell.interrupted == false then 
		if player.merits.rayke == 1 then 
			send_command('input /p Rayke on')
			send_command('input //timers c "Rayke" 32')
			send_command('@wait 31; input /p Rayke off')
		elseif player.merits.rayke == 2 then
			send_command('input /p Rayke on')
			send_command('input //timers c "Rayke" 36')
			send_command('@wait 35; input /p Rayke off')
		elseif player.merits.rayke == 3 then
			send_command('input /p Rayke on')
			send_command('input //timers c "Rayke" 39')
			send_command('@wait 39; input /p Rayke off')
		elseif player.merits.rayke == 4 then
			send_command('input /p Rayke on')
			send_command('input //timers c "Rayke" 44')
			send_command('@wait 44; input /p Rayke off')
		elseif player.merits.rayke == 5 then
			send_command('input /p Rayke on')
			send_command('input //timers c "Rayke" 47')
			send_command('@wait 47; input /p Rayke off')
	   end
    end
	if spell.english == "Odyllic Subterfuge" and spell.interrupted == false then 
	   send_command('input /p Odyllic Subterfuge on')
	   send_command('input //timers c "Odyllic Subterfuge" 30')
	   send_command('@wait 30; input /p Odyllic Subterfuge off')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    equip(sets[state.WeaponSet.current])
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
end
