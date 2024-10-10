
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
send_command('wait 5;input /lockstyleset 21') --40
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
set_macros(10,16) -- Sheet, Book
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
    hands="Acad. Bracers +2",
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
    head="Pedagogy Mortarboard +3", --"Acad. Mortar. +2",
    body= "Zendik Robe", --{ name="Agwu's Robe", augments={'Path: A',}},
    hands="Acad. Bracers +2",
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
    sets.precast["Sublimation"] = {head="Acad. Mortar. +2", body="Peda. Gown +3"}	 

	
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
    right_ear="Regal Earring",
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

	sets.midcast["Sublimation"] = {head="Acad. Mortar. +2", body="Peda. Gown +3",waist="embla sash"}
    
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
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
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
	main= "Mpaca's staff",
	sub="Enki strap",
	head="agwu's cap",
	left_ear="Regal Earring",
    right_ear="Malignance Earring",
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
    head="Acad. Mortar. +2",
    body="Acad. Gown +2",
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs="Arbatel Pants +3",
    feet="Acad. Loafers +2",
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
    head="Acad. Mortar. +2",
    body="Cohort Cloak +1",
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs="Arbatel Pants +3",
    feet="Acad. Loafers +2",
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
    hands="Arbatel Bracers +3",
    legs="Telchine Braconi", --augments={'Enh. Mag. eff. dur. +10',}},
    feet="Telchine Pigaches", --augments={'Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear= "magnetic earring", --"Andoaa Earring",
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
    right_ear="Magnetic Earring",
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
    left_ear="Magnetic Earring",
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
 