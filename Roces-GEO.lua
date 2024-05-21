-- Oganizer & Lockstyle Settings
send_command('wait 5;input /lockstyleset 40')
--send_command('lua l StatusHelper')
--send_command('lua l Partybuffs')
--[[
        Custom commands:

        Toggle Function:
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		
        Casting functions:
        these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler

        gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element
        gs c nuke t2                    Cast tier 2 nuke of saved element
        gs c nuke t3                    Cast tier 3 nuke of saved element
        gs c nuke t4                    Cast tier 4 nuke of saved element
        gs c nuke t5                    Cast tier 5 nuke of saved element
        gs c nuke ra1                   Cast tier 1 -ra nuke of saved element
        gs c nuke ra2                   Cast tier 2 -ra nuke of saved element
        gs c nuke ra3                   Cast tier 3 -ra nuke of saved element 	
		
		gs c geo geocycle				Cycles Geomancy Spell
		gs c geo geocycledown			Cycles Geomancy Spell in reverse order
		gs c geo indicycle				Cycles IndiColure Spell
		gs c geo indicycledown			Cycles IndiColure Spell in reverse order
		gs c geo geo					Cast saved Geo Spell
		gs c geo indi					Cast saved Indi Spell

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


include('organizer-lib') -- Remove if you dont use Organizer

--------------------------------------------------------------------------------------------------------------
res = require('resources') -- leave this as is
texts = require('texts')   -- leave this as is
include('Modes.lua')       -- leave this as is
--------------------------------------------------------------------------------------------------------------

-- Define your modes:
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically.
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes.
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc', 'Seidr')

--Weapons = M('Idris','Maxentius')
--subWeapon = M('genmei shield', 'Daybreak','Ammurapi Shield')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1235 --important to update these if you have a smaller screen
hud_y_pos = 600  --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'

-- Setup your Key Bindings here:
--send_command('bind @e gs c toggle weapons')
windower.send_command('bind @w gs c toggle melee') -- F12 Toggle Melee mode on / off and locking of weapons
windower.send_command('bind @e gs c toggle Weapons')


windower.send_command('bind ` gs c nuke cycle')              -- insert Cycles Nuke element
windower.send_command('bind f3 gs c cycle ImpactMode')
windower.send_command('bind ^numpad7 gs c geo geocycle')     -- home Cycles Geomancy Spell
windower.send_command('bind ^numpad8 gs c geo geocycledown') -- end Cycles Geomancy Spell in reverse order
windower.send_command('bind ^numpad9 gs c geo geo <stpc>')

send_command('bind f3 gs c cycle ImpactMode')
send_command('bind @5 input /ja "Theurgic Focus" <me>')
send_command('bind @0 input /ja "Dematerialize" <me>  <me>')

send_command('bind ^numpad+ input /equip Ring1 "Warp Ring"; wait 1; input /equip Ring2 "Dim. Ring (Holla)"')

windower.send_command('bind ^numpad4 gs c geo indicycle')     -- PgUP Cycles IndiColure Spell
windower.send_command('bind ^numpad5 gs c geo indicycledown') -- PgDown Cycles IndiColure Spell in reverse order
windower.send_command('bind ^numpad6 gs c geo indi')
windower.send_command('bind !f9 gs c toggle runspeed')        -- Alt-F9 toggles locking on / off Herald's Gaiters
windower.send_command('bind F10 gs c toggle mb')              -- F10 toggles Magic Burst Mode on / off.
windower.send_command('bind ^f11 gs c toggle nukemode')       -- Alt-F10 to change Nuking Mode
windower.send_command('bind ^F10 gs c toggle matchsc')        -- CTRL-F10 to change Match SC Mode

windower.send_command('bind f9 gs c toggle idlemode')         -- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
--windower.send_command('bind ^delete gs c hud lite')
--windower.send_command('bind !delete gs c hud keybinds')

windower.send_command('bind !q input /ma "Temper II" <me>')
--windower.send_command('bind !w input /ma "Flurry II" <stal>')
--windower.send_command('bind !e input /ma "Haste II" <stal>')
windower.send_command('bind !r input /ma "Refresh" <stpt>')
windower.send_command('bind !y input /ma "Phalanx II" <stpt>')
windower.send_command('bind !o input /ma "Regen" <stpt>')
windower.send_command('bind !p input /ma "entrust" <me>')
--windower.send_command('bind !p input /ma "Shock Spikes" <me>')
send_command('bind !s input /ma "Stoneskin" <me>')

windower.send_command('bind @numpad5 gs c nuke t5')
windower.send_command('bind @numpad4 gs c nuke t4')
windower.send_command('bind @numpad3 gs c nuke t3')
windower.send_command('bind @numpad2 gs c nuke t2')
windower.send_command('bind @numpad1 gs c nuke t1')
windower.send_command('bind @numpad7 gs c nuke ra1')
windower.send_command('bind @numpad8 gs c nuke ra2')
windower.send_command('bind @numpad9 gs c nuke ra3')
--windower.send_command('bind !numpad5 input /ma "Cure IV" <stal>')
--windower.send_command('bind !numpad7 sts r')

windower.send_command('bind !e input /ma "Haste" <stal>')
windower.send_command('bind @d input /ma "Dispelga" <t>')
windower.send_command('bind !u input /ma "Aquaveil" <me>')
windower.send_command('bind @numpad0 input /ja "Full Circle" <me>')
--windower.send_command('bind ^` input /ja "Full Circle" <me>')	
send_command('bind !numpad4 input /ma "Cure IV" <stal>')
send_command('bind !numpad1 input /ma "Cure" <stal>')
send_command('bind !numpad2 input /ma "Cure II" <stal>')
send_command('bind !numpad3 input /ma "Cure III" <stal>')



if player.sub_job == 'RDM' then
    windower.send_command('bind !w input /ma "Flurry" <stal>')
    windower.send_command('bind !y input /ma "Phalanx" <me>')
end

function job_setup()
    state.ImpactMode = M { ['description'] = 'Impact Mode', 'Normal', 'Occult Acumen' }

    if player.sub_job == 'DRK' then
        state.ImpactMode:set('Occult Acumen')
    end
end

-- job_setup()

if player.sub_job == 'SCH' then
    send_command('bind @1 gs c scholar light;wait 1.5;input /ja "Addendum: White" <me>')
    --send_command('bind @1 gs c scholar light;wait 1;input gs c scholar addendum')
    send_command('bind @2 gs c scholar dark;wait 1.5;input /ja "Addendum: black" <me>')
    -- send_command('bind ^- gs c scholar light')
    -- send_command('bind ^= gs c scholar dark')
    --send_command('bind !- gs c scholar addendum')
    --send_command('bind != gs c scholar addendum')
    send_command('bind ^; gs c scholar speed')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !; gs c scholar cost')
end
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
-- or between Full Pet Regen+DT or Hybrid PetDT and MasterDT when a Luopan is out
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(CTRL-F11)'
keybinds_on['key_bind_mburst'] = '(ALT-`)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'
keybinds_on['key_bind_weapons'] = '(@E)'

keybinds_on['key_bind_element_cycle'] = '(PAGEUP)'
keybinds_on['key_bind_geo_cycle'] = '(CTRL+HOME)'
keybinds_on['key_bind_indi_cycle'] = '(CTRL+END)'
keybinds_on['key_bind_lock_weapon'] = '(WIN+W)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'


-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind PAGEUP')
    send_command('unbind ^home')
    send_command('unbind !home')
    send_command('unbind home')
    send_command('unbind ^end')
    send_command('unbind !end')
    send_command('unbind end')
    send_command('unbind !f9')
    send_command('unbind !`')
    send_command('unbind ^f11')
    send_command('unbind ^F10')
    send_command('unbind @w')
    send_command('unbind f9')
    send_command('unbind f2')
    send_command('unbind f3')
    send_command('unbind f4')
    send_command('unbind f5')
    send_command('unbind f6')
    send_command('unbind ^delete')
    send_command('unbind !delete')
    send_command('unbind !numpad5')
    send_command('unbind !numpad4')
    send_command('unbind !numpad3')
    send_command('unbind !numpad2')
    send_command('unbind !numpad1')
    send_command('unbind !numpad8')
    send_command('unbind !numpad7')
    send_command('unbind !e')
    send_command('unbind @d')
    send_command('unbind !u')
    send_command('unbind ^`')
    send_command('unbind !w')
    send_command('unbind !y')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
end

--------------------------------------------------------------------------------------------------------------
include('GEO_Lib.lua') -- leave this as is
--include('AugGear.lua')
--------------------------------------------------------------------------------------------------------------

geomancy:set('Geo-Frailty')  -- Geo Spell Default      (when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Haste') -- Indi Spell Default     (when you first load lua / change jobs the saved spells is this one)
validateTextInformation()

-- Optional. Swap to your geo macro sheet / book
set_macros(1, 14) -- Sheet, Book

-- Setup your Gear Sets below:
function get_sets()
    sets.weapons = {}
    sets.weapons.index = { 'Idris', 'Maxentius', 'MaligPole', 'IdrisBlurred', 'MaxBlurred' }
    weapons_ind = 1
    sets.weapons.Idris = {
        main = "Idris",
        sub = "Genmei Shield",
    }

    sets.weapons.Maxentius = {
        main = "Maxentius",
        sub = "Genmei Shield",
    }

    sets.weapons.MaligPole = {
        main = "Malignance Pole",
        sub = "Flanged Grip"
    }

    sets.weapons.IdrisBlurred = {
        main = "Idris",
        sub = "Blurred Rod +1",
    }

    sets.weapons.MaxBlurred = {
        main = "Maxentius",
        sub = "Blurred Rod +1",
    }

    --------------------------------------
    -- Ambuscade Cape
    --------------------------------------

    Nantosuelta = {}
    Nantosuelta.PET = { name = "Nantosuelta's Cape", augments = { 'VIT+19', 'Eva.+20 /Mag. Eva.+20', 'Pet: "Regen"+10', 'Pet: "Regen"+5', } }
    Nantosuelta.MND = { name = "Nantosuelta's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+10', '"Fast Cast"+10', } }
    Nantosuelta.NUKE = { name = "Nantosuelta's Cape", augments = { 'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
    Nantosuelta.MNDWS = { name = "Nantosuelta's Cape", augments = { 'MND+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', } }
    Nantosuelta.DA = { name = "Nantosuelta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }

    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc

    sets.me = {}       -- leave this empty
    sets.pan = {}      -- leave this empty
    sets.me.idle = {}  -- leave this empty
    sets.pan.idle = {} -- leave this empty

    -- sets starting with sets.me means you DONT have a luopan currently out.
    -- sets starting with sets.pan means you DO have a luopan currently out.

    -- Your idle set when you DON'T have a luopan out
    sets.me.idle.normal = {
        main = "Idris",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Befouled Crown",
        body = "Azimuth Coat +3",
        hands = "Azimuth Gloves +3",
        legs = "Assid. Pants +1",
        feet = "Geo. Sandals +3",
        neck = "Sanctity Necklace",
        waist = "Fucho-no-Obi",
        left_ear = "Lugalbanda Earring",
        right_ear ="Azimuth Earring +1",
        left_ring = "Stikini Ring +1",
        right_ring = "Defending Ring",
        back = Nantosuelta.PET,
    }

    -- This or herald gaiters or +1 +2 +3...
    sets.me.movespeed = { feet = "Geo. Sandals +3" }

    -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
    sets.me.idle.dt = set_combine(sets.me.idle.normal, {
        main = "Idris",
        sub = "Ammurapi Shield",
        ammo = "Crepuscular Pebble",
        head = "Azimuth Hood +3",
        body = "Adamantite Armor",
        hands = "Geo. Mitaines +2",
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Plat. Mog. Belt",
        left_ear = "Lugalbanda Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Gelatinous Ring +1",
        right_ring = "Defending Ring",
        back = Nantosuelta.PET,
    }) -- DT50%

    sets.me.idle.mdt = set_combine(sets.me.idle.normal, {
        main = "Idris",
        sub = "Ammurapi Shield",
        ammo = "Crepuscular Pebble",
        head = "Azimuth Hood +3",
        body = "Adamantite Armor",
        hands = "Geo. Mitaines +2",
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Carrier's Sash",
        left_ear = "Lugalbanda Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Archon Ring",
        right_ring = "Defending Ring",
        back = Nantosuelta.PET,
    })
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = {

    }

    sets.me.latent_refresh = { waist = "Fucho-no-obi" }


    -----------------------
    -- Luopan Perpetuation
    -----------------------

    -- Luopan's Out --  notice sets.pan
    -- This is the base for all perpetuation scenarios, as seen below
    sets.pan.idle.normal = {
        main = "Idris",
        sub = "Genmei Shield",
        ammo = "Crepuscular Pebble",
        head = "Azimuth Hood +3",
        body = "Geomancy Tunic +3",
        hands = "Geo. Mitaines +2",
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = "Bagua Sandals +3",
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Isa Belt",
        left_ear = "Lugalbanda Earring",
        right_ear ="Azimuth Earring +1",
        left_ring = "Stikini Ring +1",
        right_ring = "Defending Ring",
        back = Nantosuelta.PET,
    } --DT47/Pet:DT26/Pet:regen22

    -- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
    sets.pan.idle.dt = set_combine(sets.pan.idle.normal, {
        main = "Idris",
        sub = "Ammurapi Shield",
        ammo = "Crepuscular Pebble",
        head = "Azimuth Hood +3",
        body = "Adamantite Armor",
        hands = "Geo. Mitaines +2",
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Plat. Mog. Belt",
        left_ear = "Lugalbanda Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Gelatinous Ring +1",
        right_ring = "Defending Ring",
        back = Nantosuelta.PET,
    }) --DT56/Pet:DT26/Pet:regen22

    sets.pan.idle.mdt = set_combine(sets.me.idle.mdt, {

    })
    -- Combat Related Sets

    -- Melee
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    -- No Luopan out
    -- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
    sets.me.melee = set_combine(sets.me.idle[idleMode], {
        main = "Idris",
        sub = "Genmei Shield",
        ammo = "Hasty Pinion +1",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = "Geo. Mitaines +2",
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Lissome Necklace",
        waist = "Cetl Belt",
        left_ear = "Telos Earring",
        right_ear = "Dedition Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Defending Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } },
    })

    -- Luopan is out
    sets.pan.melee = set_combine(sets.pan.idle[idleMode], {
        ammo = "Hasty Pinion +1",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Lissome Necklace",
        waist = "Cetl Belt",
        left_ear = "Telos Earring",
        right_ear = "Dedition Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Defending Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } },
    })

    -- Weapon Skill sets
    -- Example:
    sets.me["Flash Nova"] = {
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Saevus Pendant +1",
        waist = "Luminary Sash", --sacro cord or refoccilation stone
        left_ear = "Malignance Earring",
        right_ear = "Regal Earring",
        left_ring = "Freke Ring",
        right_ring = "Metamor. Ring +1",
        back = Nantosuelta.MNDWS,
    }

    sets.me["Realmrazer"] = {

    }

    sets.me["Judgment"] = {
        ammo = "Oshasha's Treatise",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = { name = "Moonshade Earring", augments = { 'Attack+4', 'TP Bonus +250', } },
        right_ear = "Ishvara Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = "Cornelia's Ring",
    }

    sets.me["Exudation"] = {
        ammo = "Crepuscular Pebble",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Malignance Earring",
        right_ear = "Regal Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        back = Nantosuelta.MNDWS,
    }

    sets.me['Black Halo'] = {
        ammo = "Crepuscular Pebble",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Regal Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Rufescent Ring",
        right_ring = "chirich ring +1", --"Epaminondas's Ring",
        back = Nantosuelta.MNDWS,
    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game.

    ---------------
    -- Casting Sets
    ---------------

    sets.precast = {}           -- leave this empty
    sets.midcast = {}           -- leave this empty
    sets.aftercast = {}         -- leave this empty
    sets.midcast.nuking = {}    -- leave this empty
    sets.midcast.MB = {}
    sets.midcast.MB.normal = {} -- leave this empty
    ----------
    -- Precast
    ----------

    -- Generic Casting Set that all others take off of. Here you should add all your fast cast
    sets.precast.casting = {
        main="Sucellus", --5
        sub="Chanter's Shield", --3
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head = "Amalric Coif +1",
        body = "Agwu's Robe",
        hands = "Agwu's Gages",
        legs = "Geomancy Pants +2",
        feet = { name = "Agwu's Pigaches", augments = { 'Path: A', } },
        neck = "Orunmila's Torque",
        waist = "Embla Sash",
        left_ear = "Malignance Earring",
        right_ear = "Enchntr. Earring +1",
        left_ring = "Kishar Ring",
        right_ring = "Rahab Ring",
        back = Nantosuelta.MND,
    }

    sets.precast.geomancy = set_combine(sets.precast.casting, {

    })
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting, {

    })

    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing, {

    })

    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting, {
        left_ear = "Mendi. Earring", --5
        left_ring = "Kishar ring",   --"Lebeche Ring", --(2)
        back = "Perimede Cape",      --(4)
    })
    sets.precast.regen = set_combine(sets.precast.casting, {

    })

    sets.precast.Impact = set_combine(sets.precast.FC, {
        -- main="Idris",
        head = empty,
        body = "Twilight cloak"
    })
	
    sets.precast.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Ammurapi Shield" })
    ---------------------
    -- Ability Precasting
    ---------------------

    -- Fill up with your JSE!
    sets.precast["Life Cycle"] = {
        head = "Bagua Galero +3",
        body = "Geomancy Tunic +3",
    }
    sets.precast["Bolster"] = {
        body = "Bagua Tunic +3",
    }
    sets.precast["Primeval Zeal"] = {
        head = "Bagua Galero +3",
    }
    sets.precast["Cardinal Chant"] = {
        head = "Geomancy Galero +1",
    }
    sets.precast["Full Circle"] = {
        head = "Azimuth Hood +3",
    }
    sets.precast["Curative Recantation"] = {
        hands = "Bagua Mitaines +3",
    }
    sets.precast["Mending Halation"] = {
        legs = "Bagua Pants +3",
    }
    sets.precast["Radial Arcana"] = {
        feet = "Bagua Sandals +3",
    }

    ----------
    -- Midcast
    ----------

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }

    -- For Geo spells /
    sets.midcast.geo = set_combine(sets.midcast.casting, {
        main="Idris",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Azimuth Hood +3",
        body={ name="Bagua Tunic +3", augments={'Enhances "Bolster" effect',}},
        hands="Geo. Mitaines +2",
        legs="Assid. Pants +1",
        feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
        neck="Bagua Charm +2",
        waist="Embla Sash",
        left_ear="Mendi. Earring",
        right_ear="Azimuth Earring +1",
        left_ring="Stikini Ring +1",
        right_ring="Lebeche Ring",
        back = Nantosuelta.PET,
    })
    -- For Indi Spells
    sets.midcast.indi = set_combine(sets.midcast.geo, {
        head = "Azimuth Hood +3",
        neck = "Bagua Charm +2",
        hands = "Geo. Mitaines +2",
        legs = "Bagua Pants +3",
        feet = "Azimuth gaiters +3",
        back = { name = "Lifestream Cape", augments = { 'Geomancy Skill +10', 'Indi. eff. dur. +20', 'Pet: Damage taken -2%', 'Damage taken-1%', } },
    })
    sets.midcast.entrust = {
        main={ name="Gada", augments={'Indi. eff. dur. +10','CHR+4','"Mag.Atk.Bns."+11','DMG:+9',}},
    }

    sets.midcast.Obi = {
        waist = "Hachirin-no-Obi",
    }

    -- Nuking
    sets.midcast.nuking.normal = set_combine(sets.midcast.casting, {
        main = { name = "Bunzi's Rod", augments = { 'Path: A', } },
        sub = "Ammurapi Shield",
        ammo = { name = "Ghastly Tathlum +1", augments = { 'Path: A', } },
        head = "Azimuth Hood +3",
        body = "Azimuth Coat +3",
        hands = "Agwu's Gages",
        legs = "Azimuth Tights +3",
        feet = { name = "Agwu's Pigaches", augments = { 'Path: A', } },
        neck = "Sibyl Scarf",
        waist = { name = "Acuity Belt +1", augments = { 'Path: A', } },
        left_ear = "Malignance Earring",
        right_ear ="Azimuth Earring +1",
        left_ring = "Freke Ring",
        right_ring = "Shiva Ring +1",
        back = Nantosuelta.NUKE,
    })


    -- main={ name="Bunzi's Rod", augments={'Path: A',}},
    -- sub="Ammurapi Shield",
    -- ammo="Pemphredo Tathlum",
    -- head="C. Palug Crown",
    -- body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- neck="Saevus Pendant +1",
    -- waist="Sacro Cord",
    -- left_ear="Malignance Earring",
    -- right_ear="Regal Earring",
    -- left_ring="Freke Ring",
    -- right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    -- back=Nantosuelta.NUKE,
    -- })

    sets.midcast.nuking.Seidr = set_combine(sets.midcast.nuking.normal, {
        --    body="Seidr Cotehardie",
    })

    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        --sets.midcast.MB.normal = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = { name = "Ghastly Tathlum +1", augments = { 'Path: A', } },
        head = "Ea Hat +1",
        body = "Azimuth Coat +3",
        hands = "Agwu's Robe",
        legs = "Azimuth Tights +3",
        feet = "Agwu's pigaches",
        neck = "Sibyl Scarf",
        waist = { name = "Acuity Belt +1", augments = { 'Path: A', } },
        left_ear = "Malignance Earring",
        right_ear ="Azimuth Earring +1",
        left_ring = "Freke Ring",
        right_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        back = Nantosuelta.NUKE,
    })
    -- sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
    -- main="Idris",
    -- sub="Genmei Shield",
    -- range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    -- head={ name="Agwu's Cap", augments={'Path: A',}},
    -- body={ name="Agwu's Robe", augments={'Path: A',}},
    -- hands={ name="Agwu's Gages", augments={'Path: A',}},
    -- legs={ name="Agwu's Slops", augments={'Path: A',}},
    -- feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    -- neck="Quanpur Necklace",
    -- waist="Austerity Belt +1",
    -- left_ear="Regal Earring",
    -- right_ear="Malignance Earring",
    -- left_ring="Freke Ring",
    -- right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    -- back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
    -- })


    -- {
    -- head="Ea Hat +1",
    -- body={ name="Agwu's Robe", augments={'Path: A',}},
    -- hands={ name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    -- legs="Ea Slops +1",
    -- feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    -- neck="Mizu. Kubikazari",
    -- left_ear="Malignance Earring",
    -- right_ear="Regal Earring",
    -- left_ring="Freke Ring",
    -- right_ring="Mujin Band",
    -- waist="Luminary Sash", --sacro cord or refoccilation stone
    -- })



    -- head="Ea Hat +1", --7/(7)
    -- body="Ea Houppe. +1", --9/(9)
    -- hands="Ea Cuffs +1", --6/(6)
    -- legs="Ea Slops +1", --8/(8)
    -- feet="Bagua Sandals +3",
    -- neck="Mizu. Kubikazari", --10
    -- ring2="Mujin Band", --(5)
    -- })

    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {

    })

    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {

    })

    -- Enfeebling
    sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting, {
        main = { name = "Contemplator +1", augments = { 'Path: A', } },
        sub = "Enki Strap",
        ammo = "Pemphredo Tathlum",
        head = "Geo. Galero +1",
        body = "Geomancy Tunic +3",
        hands = "Geo. Mitaines +2",
        legs = "Geomancy Pants +2",
        feet = { name = "Bagua Sandals +3", augments = { 'Enhances "Radial Arcana" effect', } },
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Luminary Sash",
        left_ear = "Malignance Earring",
        right_ear = "Regal Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Kishar Ring",
        back = Nantosuelta.MND,
    })

    sets.midcast.MndEnfeebling = set_combine(sets.midcast.casting, {
        main = { name = "Contemplator +1", augments = { 'Path: A', } },
        sub = "Enki Strap",
        ammo = "Pemphredo Tathlum",
        head = "Geo. Galero +1",
        body = "Geomancy Tunic +3",
        hands = "Geo. Mitaines +2",
        legs = "Geomancy Pants +2",
        feet = { name = "Bagua Sandals +3", augments = { 'Enhances "Radial Arcana" effect', } },
        neck = { name = "Bagua Charm +2", augments = { 'Path: A', } },
        waist = "Luminary Sash",
        left_ear = "Malignance Earring",
        right_ear = "Regal Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Kishar Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Fast Cast"+10', } },
    })

    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting, {
        main = "Gada", --, augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
        sub = "Ammurapi Shield",
        head = { name = "Telchine Cap", augments = { '"Mag.Atk.Bns."+19', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +9', } },
        body = { name = "Telchine Chas.", augments = { '"Mag.Atk.Bns."+18', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +9', } },
        hands = { name = "Telchine Gloves", augments = { 'Mag. Acc.+19', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +10', } },
        legs = { name = "Telchine Braconi", augments = { 'Mag. Acc.+10 "Mag.Atk.Bns."+10', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +9', } },
        feet = { name = "Telchine Pigaches", augments = { 'Mag. Acc.+24', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +9', } },
        neck = "Incanter's Torque",
        waist = "Embla Sash",
        left_ear = "Andoaa Earring",
        right_ear = "Loquac. Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Kishar Ring",
        back = "Perimede Cape",
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing, {
        --neck="Nodens Gorget",
        waist = "Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing, {
        --head="Amalric Coif +1",
        --feet="Inspirited Boots",
        waist = "Gishdubar Sash",
        back = "Grapevine Cape",
    })
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing, {
        sub = "Ammurapi Shield",
        -- head="Amalric Coif +1",
        hands = "Geo. Mitaines +2", --hands="Regal Cuffs",
        --waist="Emphatikos Rope",
    })

    sets.midcast['Absorb-TP'] = {
        main = "Idris",
        sub = "Ammurapi Shield",
        ammo = { name = "Ghastly Tathlum +1", augments = { 'Path: A', } },
        head = "Azimuth Hood +3",
        hands = "Agwu's Robe",
        legs = "Azimuth Tights +3",
        feet = { name = "Agwu's Pigaches", augments = { 'Path: A', } },
        neck = "Erra Pendant",
        waist = { name = "Acuity Belt +1", augments = { 'Path: A', } },
        left_ear = "Malignance Earring",
        right_ear ="Azimuth Earring +1",
        left_ring = "Stikini Ring +1",
        right_ring = "Kishar Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Fast Cast"+10', } },
    }

    sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling, {
        main="Idris",
        sub = "Ammurapi Shield",
        head = "Bagua Galero +3",
        body = "Geomancy Tunic +3",
        hands = "Geo. Mitaines +2",
        legs = "Geomancy Pants +2",
        feet = "Agwu's pigaches",
        neck = "Erra Pendant",
        --ear1="Hirudinea Earring",
        --ear2="Mani Earring",
        ring1 = "Evanescence Ring",
        ring2 = "Archon Ring",
        back = "Aurist's Cape +1",
        waist = "Fucho-no-Obi",
    })

    sets.midcast["Aspir"] = sets.midcast["Drain"]
	sets.midcast["Aspir III"] = sets.midcast["Drain"]

    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
        main = "Daybreak",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = { name = "Vanya Hood", augments = { 'MP+50', '"Fast Cast"+10', 'Haste+2%', } },
        body = "Azimuth Coat +3",
        hands = { name = "Telchine Gloves", augments = { 'Mag. Acc.+19', '"Fast Cast"+5', 'Enh. Mag. eff. dur. +10', } },
        legs = "Azimuth Tights +3",
        feet = "Agwu's pigaches",
        neck = "Incanter's Torque",
        waist = "Luminary Sash",
        left_ear = "Mendi. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Lebeche Ring",
        right_ring = "Menelaus's Ring",
        back = "Solemnity Cape",
    })

    -- main="Daybreak",
    -- sub="Sors Shield",
    -- ammo="Esper Stone +1",
    -- head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    -- body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    -- hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    -- legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    -- feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    -- neck="Incanter's Torque",
    -- waist="Luminary Sash",
    -- left_ear="Mendi. Earring",
    -- right_ear="Meili Earring",
    -- left_ring="Menelaus's Ring",
    -- right_ring={name="Stikini Ring +1", bag="wardrobe2"},
    -- back="Tempered Cape +1",
    -- })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {

    })
    sets.midcast.regen = set_combine(sets.midcast.enhancing, {
        main = "Bolelabunga",
        sub = "Ammurapi Shield",
    })

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, { main = "Daybreak", sub = "Ammurapi Shield" })

    sets.midcast.Impact = {
        main = "",
        sub = "",
        head = empty,
        ammo = "Pemphredo Tathlum",
        body = "Twilight Cloak",
        hands = "Agwu's Robe",
        legs = "Perdition Slops",
        feet = { name = "Agwu's Pigaches", augments = { 'Path: A', } },
        neck = "Lissome Necklace",
        waist = "", --Oneiros Rope
        left_ear = "Cessance Earring",
        right_ear = "Digni. Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Crepuscular Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } },
    }

    sets.midcast.Impact.Occult = {
        main = "",
        sub = "",
        head = empty,
        ammo = "Pemphredo Tathlum",
        body = "Twilight Cloak",
        hands = "Agwu's Robe",
        legs = "Perdition Slops",
        feet = { name = "Agwu's Pigaches", augments = { 'Path: A', } },
        neck = "Lissome Necklace",
        waist = "", --Oneiros Rope
        left_ear = "Cessance Earring",
        right_ear = "Digni. Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Crepuscular Ring",
        back = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } },
    }
    ------------
    -- Aftercast
    ------------

    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_midcast(spell, action, spellMap, eventArgs)
    -- handle occult acumen
    if state.ImpactMode.value == 'Occult Acumen' and spell.english == 'Impact' then
        equip(sets.midcast.Impact.Occult)
        return
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- handle occult acumen
    if state.ImpactMode.value == 'Occult Acumen' and spell.english == 'Impact' then
        equip(sets.midcast.Impact.Occult)
        return
    end
end
