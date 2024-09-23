function get_sets()
	send_command("bind f9 gs c toggle TP set")
	send_command("bind f10 gs c toggle Idle set")
	send_command("bind ^f9 gs c equip TP set")
	send_command("bind ^f10 gs c equip DT set")

send_command('wait 6;input /lockstyleset 104')
send_command('input /macro book 17')
	
	function file_unload()
		send_command("unbind ^f9")
		send_command("unbind ^f10")
		send_command("unbind ^f11")
		send_command("unbind ^f12")
		send_command("unbind ^`")

		send_command("unbind !f9")
		send_command("unbind !f10")
		send_command("unbind !f11")
		send_command("unbind !f12")

		send_command("unbind f9")
		send_command("unbind f10")
		send_command("unbind f11")
		send_command("unbind f12")
	end

	--Idle Sets--
	sets.Idle = {}

	sets.Idle.index = {"Standard", "DT"}
	Idle_ind = 1
	

	sets.Idle.Standard = {
		ammo ="Aurgelmir Orb",
		head="Malignance Chapeau",
		neck = "Sanctity Necklace",
		ear1 = "Eabani Earring",
		ear2 = "Infused Earring",
		body = "Ashera Harness",
		hands="Malignance Gloves",
		ring1 = "Defending ring",
		ring2 = "",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist = "Moonbow Belt +1",
		legs="Malignance Tights",
		feet = "Herald's Gaiters"
	}

	sets.Idle.DT = {
		ammo = "Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck = "Loricate Torque +1",
		ear1 = "Eabani Earring",
		ear2 = "Infused Earring",
		body = "Ashera Harness",
		hands="Malignance Gloves",
		ring1 = "Defending ring",
		ring2 = "",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist = "Moonbow Belt +1",
		legs="Malignance Tights",
		feet = "Malignance Boots"
	}
	--TP Sets--
	sets.TP = {}

	sets.TP.index = {"Standard", "AccuracyFull", "DT", "DTAccuracy", "Hybrid", "Counter"}
	--1=Standard, 2==AccuracyFull, 3=DT, 4=DTAccuracy,5=Hybrid, 6=Counter

	TP_ind = 1
	sets.TP.Standard = {
		ammo ="Aurgelmir Orb",
		head ="Adhemar Bonnet +1",
		body ="Ken. Samue +1",
		hands = "Adhemar Wristbands +1",
		legs = "Bhikku Hose +3",
		feet="Anchorite's Gaiters +3",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Schere Earring",
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}


	sets.TP.AccuracyFull = {
		ammo ="Aurgelmir Orb",
		head = "Ken. Jinpachi +1",
		body = "Bhikku Cyclas +3",
		hands = "Adhemar Wristbands +1",
		legs = "Bhikku Hose +3",
		feet = "Anchorite's Gaiters +3",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		rright_ear = "Schere Earring",
		left_ring = "Regal Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.TP.DT = {
		ammo = "Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Bhikku Hose +3",
		feet="Bhikku Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.TP.DTAccuracy = {
	ammo ="Aurgelmir Orb",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
	left_ear = "Sherida Earring",
	right_ear = "Schere Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP.Hybrid ={
		ammo ="Aurgelmir Orb",
		head="Bhikku Crown +3",
		body = "Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs = "Bhikku Hose +3",
		feet = "Nyame Sollerets",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Schere Earring",
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	
	}
	sets.TP.Counter ={
		ammo ="Coiste Bodhar",
		head="Bhikku Crown +3",
		body = "Mpaca's Doublet",
		hands="Malignance Gloves",
		legs = "Bhikku Hose +3",
		feet = "Bhikku Gaiters +3",
		neck = "Bathy Choker +1",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Bhikku Earring +2",
		left_ring = "Defending Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	
	}

	--Weaponskill Sets--
	sets.WS = {}

	sets.WS.VS = {
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		body = "Ken. Samue +1",
		hands = "Ryuo Tekko +1",
		legs = "Mpaca's Hose",
		feet="Mpaca's Boots",
		neck = "Fotia Gorget",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Odr Earring",
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.WS.SS = {
		ammo = "Crepuscular Pebble",
		head = "Hes. Crown +1",
		body = "Mpaca's Doublet",
		hands = "Ryuo Tekko +1",
		legs = "Ken. Hakama +1",
		feet="Nyame Sollerets",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = {name = "Moonshade Earring", augments = {"Attack+4", "TP Bonus +250"}},
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	sets.WS.AF = {
		ammp = "Coiste Bodhar",
		head = "Hes. Crown +1",
		neck = "Mnk. Nodowa +2",
		ear1 = {name = "Moonshade Earring", augments = {"Attack+4", "TP Bonus +250"}},
		ear2 = "Telos Earring",
		body = "Mpaca's Doublet",
		hands = "Adhemar Wristbands +1",
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist = "Sailfi Belt +1",
		legs = "Samnuha Tights",
		feet = "Nyame Sollerets"
	}

	sets.WS.RF = {
		ammo = "Crepuscular Pebble",
		head = "Hes. Crown +1",
		Body = "Nyame Mail",
		hands = "Adhemar Wristbands +1",
		legs = "Ken. Hakama +1",
		feet="Nyame Sollerets",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = {name = "Moonshade Earring", augments = {"Attack+4", "TP Bonus +250"}},
		left_ring = "Gere Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	}

	sets.WS.HF = {
		ammo = "Knobkierrie",
		head = "Adhemar Bonnet +1",
		body = "Ken. Samue +1",
		hands = "Adhemar Wristbands +1",
		legs = "Ken. Hakama +1",
		feet="Nyame Sollerets",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = {name = "Moonshade Earring", augments = {"Attack+4", "TP Bonus +250"}},
		left_ring = "Regal Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	}

	sets.WS.TK = {
		ammo = "Knobkierrie",
		head = "Hes. Crown +1",
		body = "Ken. Samue +1",
		hands = "Adhemar Wristbands +1",
		legs = "Ken. Hakama +1",
		feet = "Anchorite's Gaiters +3",
		neck = "Mnk. Nodowa +2",
		waist = "Moonbow Belt +1",
		left_ear = "Sherida Earring",
		right_ear = {name = "Moonshade Earring", augments = {"Attack+4", "TP Bonus +250"}},
		left_ring = "Regal Ring",
		right_ring = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	}

	--Ninja Magic Sets--
	sets.NINMagic = {}

	sets.NINMagic.Nuke = {
		head = "",
		neck = "Sanctity Necklace",
		ear2 = "Friomisi earring",
		ear1 = "Hecate's Earring",
		body = "Samnuha Coat",
		hands = "Leyline Gloves",
		ring1 = "",
		ring2 = "",
		waist = "Eschan Stone",
		back = "",
		legs = "",
		feet = ""
	}

	sets.NINMagic.Utsusemi = {
		head = "",
		neck = "Loricate Torque +1",
		ar1 = "Brutal Earring",
		ear2 = "Sherida Earring",
		body = "Ashera Harness",
		hands = "",
		ring1 = "Chirich Ring +1",
		ring2 = "Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist = "Carrier's Sash",
		legs = "",
		Feet = "Nyame Sollerets",
	}

	--Utility Sets--
	sets.Utility = {}

	sets.Utility.Sleeping = {neck = "Opo-Opo Necklace"}

	--sets.Utility.Weather = {waist = "Hachirin-no-obi", back = ""}

	--sets.Utility.MB = {
		--head = "",
		--body = "",
		--ear1 = "",
		--ring1 = "Locus Ring",
		--ring2 = "Mujin Band"
	--}
	sets.Utility.Steps = {
		ammo = "Falcon Eye",
		head = "Adhemar Bonnet +1",
		body = "Mpaca's Doublet",
		hands = "",
		legs == "Samnuha Tights",
		feet="Nyame Sollerets",
		neck = "",
		waist = "Chaac Belt",
		left_ear = "Brutal Earring",
		right_ear = "Dignitary's Earring",
		left_ring = "Yacuruna Ring",
		right_ring = "Epona's Ring",
		back = ""
	}

	sets.Utility.Doomed = {waist = "Gishdubar Sash", ring1 = "Eshmun's Ring"}

	--Job Ability Sets--

	sets.JA = {}

	sets.JA.Footwork = { feet ="Bhikku Gaiters +3"}

	sets.JA.Counterstance = {feet = "Hesychast's Gaiters +3"}

	sets.JA.ChiBlast = {waist = "Chaac Belt", Hands = "", Legs =""}
	
	sets.JA.Chakra = {waist = "Chaac Belt", Hands = "", Legs =""}

	--Precast Sets--
	sets.precast = {}

	sets.precast.FC = {}

	sets.precast.FC.Standard = {
		ammo = "Sapience Orb",
		head = "",
		body = {name = "Adhemar Jacket +1", augments = {"HP+105", '"Fast Cast"+10', "Magic dmg. taken -4"}},
		hands = {name = "Leyline Gloves", augments = {"Accuracy+14", "Mag. Acc.+13", '"Mag.Atk.Bns."+13', '"Fast Cast"+2'}},
		legs = "",
		feet = "",
		neck = "Orunmila's Torque",
		waist = "Moonbow Belt +1",
		left_ear = "Etiolation Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Rahab Ring",
		right_ring = "Defending Ring",
		back = ""
	}
end

function precast(spell)
	
	if spell.english =="Dodge" then
		equip({feet="Anchorite's Gaiters +3"})
	end
	if spell.english =="Boost" then
		equip({hands="Anchorite's Gloves +1"})
	end
	if spell.english =="Focus" then
		equip({head="Anchorite's Crown +1"})
	end
	if spell.action_type =="Magic" then
		equip(sets.precast.FC.Standard)
	elseif spell.english == "Footwork" then
		equip(sets.JA.Footwork)
	elseif spell.english == "Counterstance" then
		equip(sets.JA.Counterstance)
	elseif spell.english == "Chi Blast" then
		equip(sets.JA.ChiBlast)
	elseif spell.english == "Victory Smite" then
		equip(sets.WS.VS)
		if buffactive["Impetus"] then
			equip({Body = "Bhikku Cyclas +3", right_ear ="Brutal Earring"})
		end
	elseif spell.english == "Chakra" then
		equip(sets.JA.Chakra)
	elseif spell.english == "Shijin Spiral" then
		equip(sets.WS.SS)
	elseif spell.english == "Asuran Fists" then
		equip(sets.WS.AF)
	elseif spell.english == "Raging Fists" then
		equip(sets.WS.RF)
	elseif spell.english == "Howling Fist" then
		equip(sets.WS.HF)
	elseif spell.english == "Tornado Kick" then
		equip(sets.WS.TK)
	elseif spell.english == "Box Step" then
		equip(sets.Utility.Steps)
	elseif spell.type == "WeaponSkill" then
		equip(sets.WS.HF)
	end
end

function midcast(spell, act)
	if spell.english == "Utsusemi: Ichi" then
		equip(sets.NINMagic.Utsusemi)
		if buffactive["Copy Image (3)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image (2)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image (1)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
	end
	if spell.english == "Utsusemi: Ni" or spell.english == "Utsusemi: San" then
		equip(sets.NINMagic.Utsusemi)
	end
end

function aftercast(spell)
	if player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buffactive["Impetus"] then
			equip({Body = "Bhikku Cyclas +3"})
		end
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	if buffactive["doom"] or buffactive["curse"] then
		equip(sets.Utility.Doomed)
	end
	if buffactive["terror"] or buffactive["stun"] or buffactive["sleep"] then
		equip(sets.TP.DT)
	end
end

function status_change(new, old)
	if player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buffactive["Impetus"] then
			equip({Body = "Bhikku Cyclas +3"})
		elseif buffactive["Footwork"] then
			equip({Feet = "Bhikku Gaiters +3"})
		end
		
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function self_command(command)
	if command == "toggle TP set" then
		TP_ind = TP_ind + 1
		if TP_ind > #sets.TP.index then
			TP_ind = 1
		end
		send_command("@input /echo <----- TP Set changed to " .. sets.TP.index[TP_ind] .. " ----->")
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == "toggle Idle set" then
		Idle_ind = Idle_ind + 1
		if Idle_ind > #sets.Idle.index then
			Idle_ind = 1
		end
		send_command("@input /echo <----- Idle Set changed to " .. sets.Idle.index[Idle_ind] .. " ----->")
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == "equip TP set" then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command =="equip DT set" then
		equip (sets.TP.DT)
	elseif command == "equip Idle set" then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

