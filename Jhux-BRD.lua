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

  sets.weapons = {}			
		--sets.weapons.index = {'Idris','Maxentius','MaligPole','IdrisBlurred','MaxBlurred'}
		--weapons_ind = 1
		sets.weapons.MPU = {
		main="Mpu Gandring",
		sub="Fusetto +2",}
		
		sets.weapons.Naegling		= {
		main="Naegling",
		sub="Fusetto +2",}
	
		sets.weapons.Kraken		= {
		main="Naegling",
		sub="Kraken Club",}
	

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'FullLength', 'Placeholder', 'Enmity'}
	state.Weaponmode = M{['description']='Weapon Set', 'Naegling','Kraken','CarnKraken','Carnwenhan','Tauret','Daybreak'} --'Twashtar', 'Kraken', 'Tauret'}
    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 17,
	macro book = 9
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc','NIN','DNC','test')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc','Attack')
    state.CastingMode:options('Normal', 'Resistant','Enmity')
	--state.CastingMode:options('Normal', 'Resistant')
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

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling','Kraken','CarnKraken','Carnwenhan','Carn2', 'Daybreak', 'Tauret','MPU','MPUK'} --'Twashtar', 
    state.WeaponLock = M(false, 'Weapon Lock')
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2

    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !p input /ja "Pianissimo" <me>')
  
	send_command('bind !~numpad8 gs c cycleback Etude')
    send_command('bind !~numpad7 gs c cycle Etude')
    send_command('bind !~numpad9 gs c Etude')	

    send_command('bind !~numpad4 gs c cycleback Carol')
    send_command('bind !~numpad5 gs c cycle Carol')
	send_command('bind !~numpad6 gs c Carol')

    send_command('bind !~numpad1 gs c cycleback Threnody')
    send_command('bind !~numpad2 gs c cycle Threnody')
	send_command('bind !~numpad3 gs c Threnody')

    send_command('bind @` gs c cycle LullabyMode')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	
	send_command('bind @i input /ja  "box step" <t>')

	send_command('bind !/ input /ma "Utsusemi: Ni" <me>;wait 3;gs c update')
	send_command('bind !. input /ma "Utsusemi: Ichi" <me>;wait 5;gs c update')

	send_command('bind ^numpad3 input /ws "Rudra\'s Storm" <t>;wait 1;gs c update')
	send_command('bind ^numpad2 input /ws "Mordant Rime" <t>;wait 1;gs c update')
	send_command('bind ^numpad4 input /ws "Evisceration" <t>;wait 1;gs c update')
	send_command('bind ^numpad5 input /ws "True Strike" <t>;wait 1;gs c update')
	send_command('bind ^numpad1 input /ws "Savage Blade" <t>;wait 1;gs c update')
	send_command('bind ^numpad9 input /ws "Ruthless Stroke" <t>;wait 1;gs c update')

	--send_command('bind @numpad1 input //exec 2s.txt')	
	send_command('bind @q input //exec ody2.txt')	-- 5 songs full power for odyssey con Herculean
	send_command('bind @a input //exec ody3.txt')	-- 5 songs full power for odyssey 2x haste
	--send_command('bind @f3 input //exec dummy.txt')
	send_command('bind @f4 input //exec dummy2.txt')
	send_command('bind @f5 input //exec dummy3.txt')
	send_command('bind ^v paste')
	send_command('bind @d input /ma "Dispelga" <t>')
	--	send_command('lua l Partybuffs')

	windower.send_command('bind !`  input /ma "Chocobo Mazurka" ')
	windower.send_command('bind @numpad0 input /ma "Aria of passion" <stal> ')
	windower.send_command('bind @numpad1 input /ma "honor March" <stal> ')
	windower.send_command('bind @numpad2 input /ma "Victory March" <stal>')
	--windower.send_command('bind @numpad3 input /ma "Valor Minuet III" <stal>')
	windower.send_command('bind @numpad3 input /ma "Herculean Etude" <stal>')
	windower.send_command('bind @numpad4 input /ma "Valor Minuet IV" <stal>')
	windower.send_command('bind @numpad5 input /ma "Valor Minuet V" <stal>')
	windower.send_command('bind @numpad6 input /ma "Blade Madrigal" <stal>')
	windower.send_command('bind ~numpad6 input /ma "sword Madrigal" <stal>')
	windower.send_command('bind @numpad7 input /ma "Sentinel\'s scherzo"  <stal>')
	windower.send_command('bind @numpad8 input /ma "Mage\'s Ballad III" <stal>')
	windower.send_command('bind @numpad9 input /ma "Mage\'s Ballad II" <stal>')
	windower.send_command('bind @numpad+ input /ma "Knight\'s Minne V"  <stal>')
	windower.send_command('bind @numpad- input /ma "Knight\'s Minne IV"  <stal>')
	windower.send_command('bind !numpad0 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Aria of passion" <stal>')
	windower.send_command('bind !numpad1 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Honor March" <stal>')
	windower.send_command('bind !numpad2 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Victory March" <stal>')
	windower.send_command('bind !numpad3 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Valor Minuet III" <stal>')
	windower.send_command('bind !numpad4 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Valor Minuet IV" <stal>')
	windower.send_command('bind !numpad5 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Valor Minuet V" <stal>')
	windower.send_command('bind !numpad6 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Blade Madrigal" <stal>')
	windower.send_command('bind !numpad7 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Sentinel\'s Scherzo" <t>')
	windower.send_command('bind !numpad8 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Mage\'s Ballad III" <stal>')
	windower.send_command('bind !numpad9 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Mage\'s Ballad II" <stal>')
	windower.send_command('bind ~numpad1 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Knight\'s Minne V" <stal>')
	windower.send_command('bind ~numpad2 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Knight\'s Minne IV" <stal>')
	windower.send_command('bind ~numpad3 input /ja "Pianissimo" <me>;wait 1.5;input /ma "Knight\'s Minne III" <stal>')
	windower.send_command('bind !numpad+ input /ja "Pianissimo" <me>;wait 1.5;input /ma "Army\'s Paeon" <stal>')
	windower.send_command('bind !numpad- input /ja "Pianissimo" <me>;wait 1.5;input /ma "Army\'s Paeon II" <stal>')
	windower.send_command('bind ~numpad7 input /ma "Army\'s Paeon" <stal>')
	windower.send_command('bind ~numpad8 input /ma "Army\'s Paeon II" <stal>')
	windower.send_command('bind ~numpad8 input /ma "Army\'s Paeon II" <stal>')
	windower.send_command('bind ~numpad+ input /ja "Pianissimo" <me>;wait 1.5; input /ma "Foe Sirvente" <stal>')
	windower.send_command('bind ~numpad- input /ja "Pianissimo" <me>;wait 1.5; input /ma "Adventure\'r Dirge" <stal>')
	
	
	send_command('lua l autows')
	send_command('bind @k input //autows on')
	send_command('bind ^k input //autows off')
	
	
	send_command('bind @1 input //gs equip sets.weapons.Naegling;wait 1;input //autows set Savage Blade;wait 1;input //autows on')
	send_command('bind ~1 input //gs equip sets.weapons.Kraken;wait 1;input //autows set Savage Blade;wait 1;input //autows on')
	send_command('bind @2 input //autows set Mordant Rime;wait 1;input //autows on')
	send_command('bind @3 input //autows set Rudras Storm;wait 1;input //autows on')
	send_command('bind @4 input //autows set Aeolian Edge;wait 1;input //autows on')
	send_command('bind @5 input //autows set Cyclone;wait 1;input //autows on')
	send_command('bind @8 input //autows set Evisceration;wait 1;input //autows on')
	send_command('bind @9 input //gs equip sets.weapons.MPU;input //autows set Ruthless Stroke;wait 1;input //autows on')
	send_command('bind @7 input //autows set wasp sting;wait 1;input //autows on')
	--windower.send_command('sta !packets')
	send_command('bind ^numpad+ input /equip Ring1 "Warp Ring"; wait 1; input /equip Ring2 "Dim. Ring (Holla)"')
	if player.sub_job == 'WHM' then	
		send_command('lua l StatusHelper')
		send_command('bind !numpad7 sts r')
		send_command('bind !numpad8 input /ma "Cure IV" <stal>')
	end	

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
	send_command('unbind @k')
	send_command('unbind @l')
	send_command('unbind ~^numpad1')
    send_command('unbind ~^numpad2')
	send_command('unbind ~^numpad3')
    send_command('unbind ^`')
    send_command('unbind !`')
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
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind @a')
	send_command('unbind @q')
	send_command('unbind !numpad7')
	send_command('unbind !numpad8')	
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad2')
	send_command('unbind @numpad1')	
	send_command('unbind @numpad2')
    send_command('unbind @numpad3')
    send_command('unbind @numpad4')
    send_command('unbind @numpad5')
    send_command('unbind @numpad6')	
    send_command('unbind @numpad7')
    send_command('unbind @numpad8')
    send_command('unbind @numpad9')
	send_command('unbind @1')	
	send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
    send_command('unbind @6')	
    send_command('unbind @7')
    send_command('unbind @8')
    send_command('unbind @9')
	send_command('unbind !numpad1')	
	send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')	
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
	send_command('unbind ~numpad2')
	send_command('unbind ~numpad1')
	send_command('unbind ~numpad3')
	send_command('unbind ~numpad4')
	send_command('unbind ~numpad5')
	send_command('unbind ~numpad6')
	send_command('unbind ~numpad7')
	send_command('unbind ~numpad1')
	send_command('unbind ~numpad9')
	send_command('unbind @d')
	send_command('unbind @1')
	send_command('lua u StatusHelper')
	--send_command('lua u Partybuffs')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--include('AugGear.lua')

        --------------------------------------
        -- Ambuscade Cape
        --------------------------------------
		
    Intarabus={}
    Intarabus.STP=		{ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}} --{ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Intarabus.WSDSTR=	{ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Intarabus.WSDDEX=	{ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}} --{ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Intarabus.WSDCHR=	{ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}}--{ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}}
    Intarabus.FC=		{ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
		main="Kali",--{ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub="Genmei Shield",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves", --augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Volte Brais",
		feet="Volte Gaiters",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
		} -- FC 79%/ OC 3%

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC.BardSong = {
		main="Kali",--{ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub="Genmei Shield",
		head="Fili Calot +3",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves", --augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Volte Brais",
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck="Loricate Torque +1",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Fili Earring +1", --genmei earring
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
		} -- FC 81%

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.FC.Enmity = set_combine(sets.Enmity)
	
	sets.precast.FC.FullLength = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

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
		--range={ name="Linos", augments={'Accuracy+14 Attack+14','Weapon skill damage +3%','CHR+8',}},
		head={ name="Lustratio Cap +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Lustr. Mittens +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Bard's Charm +2",
		waist="Kentarch Belt +1", 
		left_ear="Ishvara Earring",
		right_ear=  "Moonshade Earring", 
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Evisceration'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}},
		--range={ name="Linos", augments={'Accuracy+11 Attack+11','Weapon skill damage +3%','STR+8',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear= "Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Rufescent Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}
	
	    -- range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+7',}},
		-- head={ name="Blistering Sallet +1", augments={'Path: A',}},
		-- body="Ayanmo Corazza +2",
		-- hands={ name="Lustr. Mittens +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		-- legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		-- feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		-- neck="Fotia Gorget",
		-- waist="Fotia Belt",
		-- left_ear="Ishvara Earring",
		-- right_ear= "Moonshade Earring", 
		-- left_ring="Ilabrat Ring",
		-- right_ring="Hetairoi Ring",
		-- back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		-- }

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Fotia Belt"})

    sets.precast.WS['Mordant Rime'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}},
		--range={ name="Linos", augments={'Accuracy+14 Attack+14','Weapon skill damage +3%','CHR+8',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
		legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1", 
		left_ear="Regal Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}

    sets.precast.WS['Rudra\'s Storm'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}},
		--range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+7',}},
		head={ name="Lustratio Cap +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Lustr. Mittens +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1", 
		left_ear="Ishvara Earring",
		right_ear= "Moonshade Earring", 
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}

    sets.precast.WS['Aeolian Edge'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}}, --, augments={'Accuracy+14 Attack+14','Weapon skill damage +3%','CHR+8',}},
		head={ name="Lustratio Cap +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Sanctity Necklace",
		waist="skrymir cord", --Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}

    sets.precast.WS['Savage Blade'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}},
		--ammo= "aurgelmir orb +1",
		head= "Nyame Helm",  --{ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body= "Nyame Mail", --{ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs= "Nyame Flanchard", --{ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear= "Moonshade Earring", 
		left_ring= "Epaminondas's Ring",
		right_ring= "sroda ring", --"Cornelia's Ring", --"Rufescent Ring",
		back=Intarabus.WSDSTR  --{ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}
		
		sets.precast.WS['Savage Blade'].Attack = set_combine(sets.precast.WS['Savage Blade'], {
		right_ring= "ephramad's ring",
		left_ring= "sroda ring",
		})
		
		    sets.precast.WS['Ruthless Stroke'] = {
		range={ name="Linos", augments={'Accuracy+20','Weapon skill damage +2%','STR+8',}},
		--ammo= "aurgelmir orb +1",
		head= "Nyame Helm",  --{ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body= "Nyame Mail", --{ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs= "Nyame Flanchard", --{ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear= "Moonshade Earring", 
		left_ring= "Epaminondas's Ring",
		right_ring= "sroda ring", --"Cornelia's Ring", --"Rufescent Ring",
		back=Intarabus.WSDSTR  --{ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
		}
		




    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {legs="Fili Rhingrave +3"}
    sets.midcast.Carol = {hands="Mousai Gages +1"}
    sets.midcast.Etude = {}
	--sets.midcast."adventurer/s Dirge" = { hands="Nyame Gauntlets", augments={'Path: B',}}
    sets.midcast.HonorMarch = {range="Marsyas", hands="Fili manchettes +3"}
	sets.midcast['Aria of Passion'] = {range="Loughnashade", hands="Fili manchettes +3", legs ="Inyanga Shalwar +2"}
	sets.midcast.Lullaby = {body="Fili Hongreline +3", hands="Brioso Cuffs +3"}
    -- sets.midcast.Lullaby = 
		-- {
		-- main = "mafic cudgel",
		-- sub="genmei Shield",
        -- head="Halitus Helm",
        -- body="Emet Harness +1",
        -- hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        -- legs="Zoar Subligar +1",
        -- feet={ name="Nyame Sollerets", augments={'Path: B',}},
        -- neck={ name="Unmoving Collar +1"},
        -- waist="Warwolf Belt",
        -- left_ear="Trux Earring", --cryptic
        -- right_ear="Cryptic Earring", 
        -- left_ring= "provocare ring", --"Begrudging Ring", --provocare
        -- right_ring= "eihwaz ring", --"Supershear Ring", --eihwaz
        -- back="Reiki Cloak",}

	
	sets.midcast.Lullaby.Resistant = {body="Brioso Justau. +3", hands="Brioso Cuffs +3", legs="Brioso Cannions +2"}
    sets.midcast.Madrigal = {head="Fili Calot +3"}
    sets.midcast.March = {hands="Fili manchettes +3"}
    sets.midcast.Minne = {legs="Mousai Seraweels +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +3"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Threnody = {body="Mou. Manteel +1"}
    sets.midcast['Adventurer\'s Dirge'] = {range="Marsyas", hands="Bihu Cuffs +3",  head="Nyame Helm"}
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +3"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +3"}
    sets.midcast["Chocobo Mazurka"] = {range="Marsyas"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
        main="Carnwenhan",
        range="Gjallarhorn",
        sub="Genmei Shield",
        head="Fili Calot +3",
        body="Fili Hongreline +3",
        hands="Fili manchettes +3",
        legs= "brioso cannions +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Fili Earring +1", --genmei earring
        left_ring="Defending Ring",
        right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		body="Fili Hongreline +3",
		hands="Inyan. Dastanas +2",
		legs="brioso cannions +2", --"Inyanga Shalwar +2",",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
		}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {body="Brioso Justau. +3", hands="Brioso Cuffs +3", legs="Brioso Cannions +2"})

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = {
        ear1="Gersemi Earring",
        -- ear2="Darkside Earring",
        ring2={name="Stikini Ring +1", bag="wardrobe1"},
        }

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder =
	{
		range=info.ExtraSongInstrument,

		main= "Kali", --, augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub="Genmei Shield",
    head="Fili Calot +3",
    body="Fili Hongreline +3",
    hands="Fili manchettes +3",
    legs= "brioso cannions +2",  --"Inyanga Shalwar +2",",
    feet="Brioso Slippers +3",
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Hearty Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
}
		-- --main = "Sangoma",
		-- main="Daybreak",
		-- head="Inyanga Tiara +2",
		-- body="Inyanga Jubbah +2",
		-- hands="Inyan. Dastanas +2",
		-- legs="Assid. Pants +1",
		-- feet="Aya. Gambieras +2",
		-- neck="Bathy Choker +1",
		-- waist="Flume Belt +1 +1",
		-- left_ear="Etiolation Earring",
		-- right_ear="Fili Earring +1", --genmei earring
		-- left_ring="Defending Ring",
		-- right_ring="Inyanga Ring",
		-- }
						    sets.midcast.Lullaby.Enmity =
	{
		range=info.ExtraSongInstrument,
		sub="Genmei Shield",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs="Zoar Subligar +1",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Unmoving Collar +1"},
        waist="Warwolf Belt",
        left_ear="Trux Earring", --cryptic
        right_ear="Cryptic Earring", 
        left_ring= "provocare ring", --"Begrudging Ring", --provocare
        right_ring= "eihwaz ring", --"Supershear Ring", --eihwaz
        back="Reiki Cloak",}
		

		
		
	sets.midcast.FullLength = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})
	sets.midcast.Enmity = set_combine(sets.Enmity) -- {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Kaykaus Mitra +1", --augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Kaykaus Bliaut +1", --augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		hands="Kaykaus Cuffs +1", --augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs= "Vanya Slops", --"Kaykaus Tights +1", --augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet="Kaykaus Boots +1", -- augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Meili Earring",
		left_ring="Menelaus's Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
		}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.StatusRemoval = sets.midcast.Cursna

    sets.midcast.Cursna = {
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Vanya Robe",
		hands="Inyan. Dastanas +2",
		legs="Gyve Trousers",
		feet= "Vanya Clogs", --augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck= "Malison Medallion", --"Debilis Medallion",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Mendi. Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back="Aurist's Cape +1",
		}
		
		sets.Enmity = {
			sub="genmei Shield",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs="Zoar Subligar +1",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Unmoving Collar +1"},
        waist="Warwolf Belt",
        left_ear="Trux Earring", --cryptic
        right_ear="Cryptic Earring", 
        left_ring= "provocare ring", --"Begrudging Ring", --provocare
        right_ring= "eihwaz ring", --"Supershear Ring", --eihwaz
        back="Reiki Cloak",}
		
		


    sets.midcast['Enhancing Magic'] = {
		main=	"Sangoma",
		sub=		"Ammurapi Shield",
		range=		"Gjallarhorn",
		head= 		"Telchine cap", --.Head.DUR",
		body= 		"Telchine chas.", --.Body.DUR",
		hands= 		"Telchine Gloves", --"Telchine.Hands.DUR",
		legs= 		"Telchine Braconi", --.Legs.DUR",
		feet=		"Kaykaus Boots +1", --, augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck=		"Incanter's Torque",
		waist=		"Embla Sash",
		left_ear=	"Andoaa Earring",
		right_ear=	"Mimir Earring",
		left_ring=	{name="Stikini Ring +1", bag="wardrobe"},
		right_ring=	{name="Stikini Ring +1", bag="wardrobe1"},
		back=		"Aurist's Cape +1",
		}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = sets.midcast['Enhancing Magic']
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
        main=	"Carnwenhan",
        sub=	"Ammurapi Shield",
        head=	"Brioso Roundlet +3",
        body=	"Brioso Justau. +3",
        hands=	"Brioso Cuffs +3",
        legs=	"Brioso Cannions +2",
        feet=	"Brioso Slippers +3",
        neck=	"Mnbw. Whistle +1",
        ear1=	"Digni. Earring",
        ear2=	"Vor Earring",
        ring1=	"Kishar Ring",
        ring2=	"Metamor. Ring +1",
        waist=	"Acuity Belt +1",
        back=	"Aurist's Cape +1",
        }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		--main = "mafic cudgel",
			--main="Sangoma",
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Ashera Harness",
		hands="Inyan. Dastanas +2",
		legs="Brioso Cannions +2",
		feet="Fili Cothurnes +3", --"Volte spats",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Fili Earring +1", --genmei earring
		left_ring="Defending Ring",
		right_ring= "Stikini ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}

    sets.idle.DT = {
		--main=		"Naegling", --sangoma
		--main = "mafic cudgel",
		--sub=		"Genmei Shield",
		ammo=		"Staunch Tathlum +1",
		head=		"Nyame Helm",
		body=		"Nyame Mail",
		hands=		{ name="Nyame Gauntlets", augments={'Path: B',}},
		legs=		"Nyame Flanchard",
		feet=		{ name="Nyame Sollerets", augments={'Path: B',}},
		neck=		{ name="Loricate Torque +1", augments={'Path: A',}},
		waist=		"Luminary Sash",
		left_ear=	"Malignance Earring",
		right_ear=	"Etiolation Earring",
		left_ring=	"Moonlight Ring", --"Gelatinous Ring +1",
		right_ring=	"Moonlight Ring", --"Defending Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}

    sets.idle.MEva = {
		--main="Sangoma",
		--main = "mafic cudgel",
		--sub="Genmei Shield",
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Ashera Harness",
		hands="Inyan. Dastanas +2",
		legs="Brioso Cannions +2",
		feet="Fili Cothurnes +3", --"Volte spats",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Fili Earring +1", --genmei earring
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}

    sets.idle.Town = {
				--main="Sangoma",
		--sub="Genmei Shield",
		--range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Ashera Harness",
		hands="Inyan. Dastanas +2",
		legs="Brioso Cannions +2",
		feet="Fili Cothurnes +3", --"Volte spats",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Fili Earring +1", --genmei earring
		left_ring="Defending Ring",
		right_ring= "Stikini ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes +3"}
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
		--range="Linos", 
		--main={ name="Carnwenhan", augments={'Path: A',}},
		ammo = "Aurgelmir Orb +1",
		sub="Genmei Shield",
		head="Bunzi's hat", --"Aya. Zucchetto +2",
		body="Ashera Harness",--"Ashera Harness",
		hands= "volte mittens",
		legs="Volte Tights", --volte
		feet="Volte Spats",
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist="sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Dignitary's Earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}	

    sets.engaged.Acc = sets.engaged

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
		range={ name="Linos", augments={'Accuracy+13','"Dbl.Atk."+2','Quadruple Attack +3',}},
		--ammo = "Aurgelmir Orb +1",
		head="Bunzi's hat", --"Aya. Zucchetto +2",
		body="Ashera Harness",
		hands=  "volte mittens",
		legs="Volte Tights", --volte
		feet="Volte Spats",
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="crepuscular earring", --"Dignitary's Earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		--right_ring="ephramad's ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}
		
		    sets.engaged.DW.NIN = {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+2','Quadruple Attack +3',}},
		--ammo = "Aurgelmir Orb +1",
		head="Bunzi's hat", --"Aya. Zucchetto +2",
		body= "Ashera Harness",
		hands=  "volte mittens",
		legs="Volte Tights", --volte
		feet="Volte Spats",
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="eabani Earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}
		
				    sets.engaged.DW.DNC = {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+2','Quadruple Attack +3',}},
		--ammo = "Aurgelmir Orb +1",
		head="Bunzi's hat", --"Aya. Zucchetto +2",
		body= "Ashera Harness",
		hands=  "volte mittens",
		legs="Volte Tights", --volte
		feet="Volte Spats",
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist="Gerdr belt +1",
		left_ear="Telos Earring",
		right_ear="suppanomimi",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}
		
				    sets.engaged.DW.Volte = {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+2','Quadruple Attack +3',}},
		--ammo = "Aurgelmir Orb +1",
		head="Bunzi's hat", --"Aya. Zucchetto +2",
		body="Volte Harness",
		hands=  "volte mittens",
		legs="Volte Tights", --volte
		feet= "nyame Sollerets", --"Volte Spats",
		neck= { name="Bard's Charm +2", augments={'Path: A',}},
		waist= "gerdr belt +1", --"sailfi belt +1",
		left_ear= "Telos Earring",
		right_ear= "Suppanomimi", --"Dedition earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe3"},
		right_ring={name="Chirich Ring +1", bag="wardrobe4"},
		--right_ring="ephramad's ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		}

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
	head={ name="Blistering Sallet +1", augments={'Path: A',}},})

    sets.engaged.Aftermath = sets.engaged.DW 

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid =
			{
	ammo="Aurgelmir Orb +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Ashera Harness",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Chirich Ring +1",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
}
	



	-- {
        -- neck="Loricate Torque +1", --6/6
        -- ring1="Gelatinous Ring +1",            --{name="Moonlight Ring", bag="wardrobe3"}, --5/5
        -- ring2="Defending Ring", --10/10
        -- }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid,
		{
	ammo="Aurgelmir Orb +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Ashera Harness",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Chirich Ring +1",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
})
	
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid, 
	{
	ammo="Aurgelmir Orb +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Ashera Harness",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Chirich Ring +1",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
})
	
	
	
	
	-- {	
			
		-- ammo=	     	"Staunch Tathlum +1",
		-- head=		"Nyame Helm",
		-- body=		"Nyame Mail",
		-- hands=		{ name="Nyame Gauntlets", augments={'Path: B',}},
		-- legs=		"Nyame Flanchard",
		-- feet=		{ name="Nyame Sollerets", augments={'Path: B',}},
		-- neck=	{ name="Bard's Charm +2", augments={'Path: A',}}, --	{ name="Loricate Torque +1", augments={'Path: A',}},
		-- waist=		"Luminary Sash",
		-- left_ear=	"Malignance Earring",
		-- right_ear=	"Etiolation Earring",
		-- left_ring=	"Moonlight Ring", --"Gelatinous Ring +1",
		-- right_ring=	"Moonlight Ring", --"Defending Ring",
		-- back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		-- })
	
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe2"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe3"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
	--include('gseditor.lua')
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
		 if spell.name == 'Aria of Passion' then
            equip({range="Loughnashade"})
        end
		if string.find(spell.name,'Paeon') then
            equip(sets.precast.FC.SongPlaceholder)
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
		if string.find(spell.name,'Paeon') then
            equip(sets.precast.FC.SongPlaceholder)
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
			 if spell.name == 'Aria of Passion' then
            equip({range="Loughnashade"})
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
        if state.CombatForm.current == 'DW' then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
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
	if player.sub_job == 'NIN' then
		state.CombatForm:set('DW')
	elseif 	player.sub_job == 'DNC' then
		state.CombatForm:set('DW')
	else
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
    if state.WeaponSet.value == "Carnwenhan" then
        equip({main="Carnwenhan",sub="Fusetto +2"}) --sub="Ternion Dagger +1"
		    elseif state.WeaponSet.value == "Carn2" then
        equip({main="Carnwenhan",sub="Crepuscular Knife"}) --sub="Ternion Dagger +1"
   -- elseif state.WeaponSet.value == "Twashtar" then
     --   equip({main="Twashtar",sub="Ternion Dagger +1"})
	     elseif state.WeaponSet.value == "CarnKraken" then
        equip({main="Carnwenhan",sub="Kraken Club"})
    elseif state.WeaponSet.value == "Naegling" then
        equip({main="Naegling",sub="Fusetto +2"}) --sub="Gleti's Knife"
	elseif state.WeaponSet.value == "Kraken" then
        equip({main="Naegling",sub="Kraken club"}) --sub="Gleti's Knife"
	elseif state.WeaponSet.value == "Daybreak" then
        equip({main="Daybreak",sub="fusetto +2"})	--sub="tauret"
    elseif state.WeaponSet.value == "Tauret" then
        equip({main="Tauret",sub="Fusetto +2"})
		    elseif state.WeaponSet.value == "MPU" then
        equip({main="Mpu Gandring",sub="Fusetto +2"})
	    elseif state.WeaponSet.value == "MPUK" then
        equip({main="Mpu Gandring",sub="Kraken club"})
    end
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

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
    elseif state.SongMode.value == 'FullLength' then
        return 'FullLength'	
	elseif state.SongMode.value == 'Enmity' then
        return 'Enmity'
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

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end	-- change to 0.25 with 90 Daur
	 --if player.equipment.range == 'Loughnashade' then mult = mult + 0.3  end -- change to 0.25 with 90 Daur
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
    if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
	if player.equipment.legs == "brioso cannions +2" then mult = mult + 0.17 end  --"Inyanga Shalwar +2" --
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.1 end
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
    set_macro_page(1, 12)
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end

-- function determine_haste_group()
	-- classes.CustomMeleeGroups:clear()
	-- if state.HasteMode.value == true then																					-- ***This Section is for Haste II*** --																													-- ***This section is for Haste I*** --										
		-- if 	(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) and buffactive[370] or  		-- GeoHaste + (2x march or Haste or MG) + Samba
				-- (buffactive[228] and buffactive[580] and buffactive[370]) then														-- Embrava + GeoHaste + Samba
				-- add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
				-- classes.CustomMeleeGroups:append('MagicHasteCappedSamba')
				-- elseif 	(buffactive[228] and (buffactive[33] or buffactive[604]) and buffactive[370]) or									-- Embrava + (Haste or MG) + Samba
				-- ((buffactive[33] or buffactive[604]) and ((buffactive.march == 2) and buffactive[370])) then						-- (Haste or MG) + (2x march + Samba)
				-- add_to_chat(8, '-------------Haste 40% + Samba-------------')
				-- classes.CustomMeleeGroups:append('Haste_40Samba')
				-- elseif 	(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) or   							-- GeoHaste + (2x march or Haste or MG)
				-- (buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
				-- add_to_chat(8, '-------------Magic Haste Capped--------------')
				-- classes.CustomMeleeGroups:append('MagicHasteCapped')
				-- elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive.march == 1) or							-- ((Haste + MG) or GeoHaste) + 1x march
				-- ((buffactive[33] or buffactive[604]) and buffactive.march == 2) or													-- (Haste or MG) + 2x march
				-- (buffactive[228] and buffactive.march == 1 and buffactive[370]) or													-- Embrava + 1x march + Samba
				-- ((buffactive[33] or buffactive[604]) and buffactive[228]) then														-- (Haste or MG) + Embrava
				-- add_to_chat(8, '-------------Haste 40%-------------')
				-- classes.CustomMeleeGroups:append('Haste_40')        
				-- elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive[370]) or 									-- ((Haste + MG) or GeoHaste) + Samba
				-- (buffactive[228] and buffactive.march == 1) then 																	-- Embrava + 1x march
				-- add_to_chat(8, '-------------Haste 35%-------------')
				-- classes.CustomMeleeGroups:append('Haste_35')
				-- elseif 	((buffactive[33] or buffactive[604]) and buffactive.march == 1 and buffactive[370]) or 								-- (Haste or MG) + 1x march + Samba		
				-- (buffactive.march == 2 and buffactive[370]) or																		-- 2x march + Samba
				-- (buffactive[228] and buffactive[370]) or  																			-- Embrava + Samba
				-- (buffactive[33] and buffactive[604]) or																				-- Haste + MG
				-- (buffactive[580]) then 																								-- GeoHaste
				-- add_to_chat(8, '-------------Haste 30%-------------')
				-- classes.CustomMeleeGroups:append('Haste_30')
				-- elseif  ((buffactive[33] or buffactive[604]) and buffactive.march == 1) or 													-- (Haste or MG) + 1x march	
				-- (buffactive.march == 2) or 																							-- 2x march
				-- (buffactive[228]) then																								-- Embrava
				-- add_to_chat(8, '-------------Haste 25%-------------')
				-- classes.CustomMeleeGroups:append('Haste_25')
				-- elseif 	((buffactive[33] or buffactive[604]) and buffactive[370]) then														-- (Haste or MG) + Samba
				-- add_to_chat(8, '-------------Haste 20%-------------')
				-- classes.CustomMeleeGroups:append('Haste_20')
				-- elseif	((buffactive.march == 1) and buffactive[370]) or																	-- 1x march + Samba
				-- (buffactive[33] or buffactive[604]) then																			-- Haste or MG
				-- add_to_chat(8, '-------------Haste 15%-------------')
				-- classes.CustomMeleeGroups:append('Haste_15')
				-- elseif 	(buffactive.march == 1) then																						-- 1x march
				-- add_to_chat(8, '-------------Haste 10%-------------')
				-- classes.CustomMeleeGroups:append('Haste_10')
				-- elseif 	(buffactive[370]) then																								-- Samba
				-- add_to_chat(8, '-------------Haste  5%-------------')
				-- classes.CustomMeleeGroups:append('Haste_5')		
		-- end
	-- end
-- end	