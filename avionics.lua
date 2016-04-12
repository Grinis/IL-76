size = { 2048, 2048 }

-- power for gauges and systems is exist
createProp("sim/custom/xap/gauge_power_avail", "int");  

-- Œœ¿—ÕŒ «≈ÃÀﬂ
-- lamp on image
defineProperty("lightOn", loadImage("l_alt_1/l_alt_1.png"));
-- aircraft radio alt
defineProperty("r_alt", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot"))
-- aircraft gear boolean
defineProperty("gear_b", globalPropertyf("sim/cockpit2/controls/gear_handle_down"))
-- aircraft gear boolean
defineProperty("fpm_f", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot"))

-- Ã¿– ≈–€
-- lamp on image
defineProperty("lightOn1", loadImage("l_mark/l_mark_o.png"));
defineProperty("lightOn2", loadImage("l_mark/l_mark_m.png"));
defineProperty("lightOn3", loadImage("l_mark/l_mark_i.png"));
-- markers vars
defineProperty("mark_o", globalPropertyf("sim/cockpit2/radios/indicators/over_outer_marker"))
defineProperty("mark_m", globalPropertyf("sim/cockpit2/radios/indicators/over_middle_marker"))
defineProperty("mark_i", globalPropertyf("sim/cockpit2/radios/indicators/over_inner_marker"))

-- œ–≈ƒ”œ–≈∆ƒ≈Õ»ﬂ
defineProperty("lightOn4", loadImage("l_warn/l_warn_spoil.png"));
defineProperty("spoil_b", globalPropertyf("sim/cockpit2/annunciators/speedbrake"))
defineProperty("lightOn5", loadImage("l_warn/l_warn_doors.png"));
defineProperty("lightOn6", loadImage("l_warn/l_warn_domkrat.png"));
defineProperty("lightOn7", loadImage("l_warn/l_warn_v.png"));
defineProperty("mach_f", globalPropertyf("sim/flightmodel/misc/machno"))
defineProperty("airspeed_f", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("lightOn8", loadImage("l_warn/l_warn_vpr.png"));
defineProperty("ralt", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot"))
defineProperty("rvpr", globalPropertyf("sim/cockpit/misc/radio_altimeter_minimum"))

-- BUTTONS
defineProperty("but_cargo", loadImage("buttons/cargo.png"));
defineProperty("but_cargo_on", loadImage("buttons/cargo_on.png"));
defineProperty("cargo_b", globalPropertyf("sim/cockpit2/switches/custom_slider_on[2]"))
defineProperty("door1_b", globalPropertyf("sim/cockpit2/switches/custom_slider_on[0]"))
defineProperty("door2_b", globalPropertyf("sim/cockpit2/switches/custom_slider_on[1]"))
defineProperty("adf1_pwr_on", globalPropertyi("sim/cockpit2/radios/actuators/adf1_power"))
defineProperty("nav1_pwr_on", globalPropertyi("sim/cockpit2/radios/actuators/nav1_power"))

-- Pop-up navigator panel
navigatorPanel = subpanel {
    -- default panel position
    position = { 0, 200, 1000, 700 };
    -- disable default background
    noBackground = true;
    -- panel descriptions for shortcuts setup dialog
    description = "Toggle IL-76 navigator panel";

    noClose = true;
    --movable = true;
    --clickable = true;
    --noResize = true;
	--focused = true;

    -- components of panel
    components = {
        -- navigator panel body
        navpanel {  position = { 0, 0, 1024, 768 } };
    };
};

-- 3D cockpit
components = { 

    -- update aircraft logic
	logic { },
	panel_logic {
		panel_20 = navigatorPanel,
	},
    
    -- heading airpeed settings
    -- ap_hdg {  position = { 1920, 390, 149*0.6, 56*0.6 } };
    -- vertical speed settings
    -- ap_vvi {  position = { 1920, 330, 149*0.6, 56*0.6 } };
    -- metric autopilot altitude settings
    -- ap_alt {  position = { 1920, 450, 149*0.6, 56*0.6 } };
    -- metric autopilot airpeed settings
    -- ap_speed {  position = { 1920, 510, 149*0.6, 56*0.6 } };
    
    -- artifical horizon
    agd_1 { position = { 1410, 810, 226, 336 } };
	
	-- artifical horizon
    agd_2 { position = { 914, 718, 256, 396 } };
	
	-- DME 1
    dme { position = { 490, 245, 105, 155 }, },
    
    -- DME 2
    dme { 
        position = { 595, 240, 105, 155 }, 
        distance = globalPropertyf("sim/cockpit/radios/nav2_dme_dist_m");
        hasDistance = globalPropertyf("sim/cockpit/radios/nav2_has_dme");
    },
	
	-- clock
    achs1 { position = { 330, 14, 142, 222 }; };
	
	-- Œœ¿—ÕŒ «≈ÃÀﬂ
    textureLit {
        image = lightOn,
        position = {1695, 1150},
        visible = function() 
		local altt = get(r_alt)
		local gearr = get(gear_b)
		local fpmm = get(fpm_f)
		if altt < 820 and gearr == 0 and fpmm < 1 then return true
			else return false
		end
		end,
    },
	
	-- OUTER Marker
	textureLit {
        image = lightOn1,
        position = {1150, 1065},
        visible = function() 
		if get(mark_o) == 1 then return true
			else return false
		end
		end,},
		
	-- MIDDLE Marker
	textureLit {
        image = lightOn2,
        position = {1216, 1062},
        visible = function() 
		if get(mark_m) == 1 then return true
			else return false
		end
		end,},
		
	-- INNER Marker
	textureLit {
        image = lightOn3,
        position = {1283, 1062},
        visible = function() 
		if get(mark_i) == 1 then return true
			else return false
		end
		end,},	

	-- Speed Brakes On|Off
	textureLit {
        image = lightOn4,
        position = {265, 380},
        visible = function() 
		if get(spoil_b) == 1 then return true
			else return false
		end
		end,},	

	-- Cargo Button
    switch {
        position = { 362, 788};
        -- button cargo
        state = function () return 0 == get(cargo_b); end;

        btnOn = get(but_cargo);
        btnOff = get(but_cargo_on);
    },		
	
	-- Doors Opened|Closed
	textureLit {
        image = lightOn5,
        position = {264, 455},
        visible = function() 
		if get(cargo_b) == 1 or get(door1_b) == 1 or get(door2_b) == 1 then return true
			else return false
		end
		end,},
		
	-- Cargo (domkrat) Opened|Closed
	textureLit {
        image = lightOn6,
        position = {264, 420},
        visible = function() 
		if get(cargo_b) == 1 then return true
			else return false
		end
		end,},
		
	-- œÂ‚˚¯ÂÌËÂ ÒÍÓÓÒÚË
    textureLit {
        image = lightOn7,
        position = {361, 934},
        visible = function() 
		if get(mach_f) > 0.77 or get(airspeed_f) > 308 then return true
			else return false
		end
		end,
    },		
	
	-- ¬œ–
    textureLit {
        image = lightOn8,
        position = {1060, 1250},
        visible = function() 
		local ra = get(ralt)
		if ra > 5 and ra < get(rvpr) + 30 and ra > get(rvpr) - 60 and get(fpm_f) < -1 then return true
			else return false
		end
		end,
    },	
		
    --navpanel {
	--	position = { 0, 400, 1400, 1400 },
	--	visible = function() 
	--	if get(n_panel_b) == 1 then return true
	--		else return false
	--	end
	--	end,
	--},
	
	--navpanel {
	--local p20 = get(navigatorPanel);
	--	position = { 0, 400, 1400, 1400 },
	--	visible = function() 
	--	if get(n_panel_b) == 1 then return true
	--		else return false
	--	end
	--	end,
	--	set(navigatorPanel.visible, false),
	--	visible = true;
	--if get(n_panel_b) == 1 then
	--  set(p20.visible, true)
    --  else
	--  set(p20.visible, false)
    --  end
	--},
	
	--togglePanelButton {
    --    position = { 100, 100, 25, 25 };
     --  panel = navigatorPanel;
    --    image = loadImage("navigation.png");
    --};
	
}


