pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--flags
-- 0=minigame initiator
-- 3=textbox
-- 4=wall
-- 5=minigame1

function _init()
 ititle()
 iplayer()
 isel()
 iintropage()
 iptypes()
 inamingpage()
 icutscene()
 img1()
 
 musicnum=11
 music(musicnum)
 current_music=musicnum
 
 state="title"
 
 title_timer=0
 title_color=1
 
 csnum=0
end

function _update()
 --title screen
 if state=="title" then
  utitle()
 end

 if state=="controls" then
  ucontrols()
 end

 if state=="intro" then
  uintropage()
 end
 
 if state=="discovery methods" then
  udiscoverymethods()
 end
 
 if state=="ptypes" then
 	uptypes()
 end
 
 if state=="naming" then
  unamingpage()
 end
 --play
 if state=="play" then
  uplayer()
  if current_music~=0 then
   current_music=0
   music(0)
  end
 end
 
 if state=="selectionbox" then
  usel()
 end
 
 if state=="cutscene" then
  ucutscene()
 end
 
 if state=="mg1" then
  umg1()
 end
 
 if state=="mg2b" then
  umg2b()
 end
 
 if state=="mg2s" then
  umg2s()
 end
 
 if state=="mg2a" then
  umg2a()
 end
 
end

function _draw()
 if state=="play" then
  cls(0)
  map()
  dplayer()
 elseif state=="title" then
  dtitle()
 elseif state=="controls" then
  dcontrols()
 elseif state=="intro" then
  dintropage()
 elseif state=="discovery methods" then
  ddiscoverymethods()
 elseif state=="ptypes" then
 	dptypes()
 elseif state=="naming" then
  dnamingpage()
 elseif state=="minigame" then
  cls(5)
  print("minigame screen",35,50,7)
 elseif state=="selectionbox" then
  dsel()
 elseif state=="cutscene" then
  dcutscene()
 elseif state=="mg1" then
  dmg1()
 elseif state=="mg2b" then
  dmg2b()
 elseif state=="mg2s" then
  dmg2s()
 elseif state=="mg2a" then
  dmg2a()
 elseif state=="ptypes" then
  dptypes()
 end
end
-->8
--player functions
function iplayer()
 player={
  x=10,
  y=110,
  spd=1,
  sprite=72
 }
 
 guidetxt={
  x=0,
  y=0,
  active=false,
  clr=7
 }
 
 sprcounter=0
 spranim=0
end

function uplayer()
 local ptx=(player.x+8)/8
 local pty=(player.y+8)/8

 
 if btn(⬆️) or btn(⬇️) or btn(➡️) or btn(⬅️) then
  sprcounter+=.1
  if flr(sprcounter)%2==0 then
   spranim=0
  else spranim=1 end
 end
 if btn(⬆️) then
  player.y-=player.spd
  if fget(mget(ptx,pty),4) then
   player.y+=player.spd
  end
  if spranim==1 then
  	player.sprite=76
  else player.sprite=78 end
 end
 if btn(⬇️) then
  player.y+=player.spd
  if spranim==1 then
   player.sprite=72
  else player.sprite=74 end
 end
 if btn(➡️) then
  player.x+=player.spd
  if spranim==1 then
   player.sprite=64
  else player.sprite=66 end
 end
 if btn(⬅️) then
  player.x-=player.spd
  if spranim==1 then
 	 player.sprite=68
 	else player.sprite=70 end
 end

 if fget(mget(ptx,pty),5) or fget(mget(ptx,pty),6)  then
  guidetxt.active=true
  guidetxt.x=player.x+16
  guidetxt.y=player.y+8
 else
  guidetxt.active=false
 end
 
 if fget(mget(ptx,pty),5) then
  csnum=1
  if btnp(🅾️) then
   state="selectionbox"
  end
 end
 
 if fget(mget(ptx,pty),6) then
  csnum=2
  if btnp(🅾️) then
   state="selectionbox"
  end
 end
end

function dplayer()
 spr(player.sprite,player.x,player.y,2,2)
 if guidetxt.active then
  rectfill(guidetxt.x-1,guidetxt.y-1,guidetxt.x+31,guidetxt.y+5,5)
  print("press 🅾️",guidetxt.x,guidetxt.y,7)
 end
end
-->8
--planettypes

function iptypes()
 btncd=5
 
 textnum=1
 ptext={
  "gas giant planets (left) are often larger than jupiter",
  "terrestrial planets (top-right) are earth-sized or smaller",
  "neptune-like planets (middle) have hydrogen or helium-dominated atmospheres",
  "super-earth planets (bottom-right) are typically terrestrial or rocky"
 }
end

function uptypes()
 if btnp(➡️) then
  textnum+=1
 elseif btnp(⬅️) and textnum>1 then
  textnum-=1
 end
 
 if textnum>4 then
  state="naming"
 end
end

function draw_parabolabigy()
	// big yellow planet
    for x = 0, 39 do
        -- calculate y as a function of x (a simple parabola)
        local y = 80 - (x - 64)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 1, 40 do
        -- calculate y as a function of x (a simple parabola)
        local y = 64 - (x - 64)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 2, 40 do
        -- calculate y as a function of x (a simple parabola)
        local y = 63 - (x - 64)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
     for x = 0, 36 do
        -- calculate y as a function of x (a simple parabola)
        local y = 90 - (x - 64)^2 / 110
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 0, 36 do
        -- calculate y as a function of x (a simple parabola)
        local y = 91 - (x - 64)^2 / 110
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = 0, 36 do
        -- calculate y as a function of x (a simple parabola)
        local y = 80 - (x - 64)^2 / 110
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = 0, 29 do
        -- calculate y as a function of x (a simple parabola)
        local y = 100 - (x - 64)^2 / 150
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = 0, 29 do
        -- calculate y as a function of x (a simple parabola)
        local y = 101 - (x - 64)^2 / 150
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = 0, 28 do
        -- calculate y as a function of x (a simple parabola)
        local y = 102 - (x - 64)^2 / 150
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = 0, 36 do
        -- calculate y as a function of x (a simple parabola)
        local y = 87 - (x - 64)^2 / 150
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 0,20 do
        -- calculate y as a function of x (a simple parabola)
        local y = 110 - (x - 64)^2 / 190
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 0,19 do
        -- calculate y as a function of x (a simple parabola)
        local y = 111 - (x - 64)^2 / 190
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 0,15 do
        -- calculate y as a function of x (a simple parabola)
        local y = 114 - (x - 64)^2 / 190
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = 0,7 do
        -- calculate y as a function of x (a simple parabola)
        local y = 115 - (x - 64)^2 / 300
        pset(x, y, 7) -- plot the point in white (color 7)
    end
end




function draw_parabola()

    for x = (74-19), (74+17) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 64 - (x - 64)^2 / 100
        pset(x, y, 6) -- plot the point in white (color 7)
    end
    
    for x = (74-17), (74+7) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 57 - (x - 50)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    
    for x = (74-19), (74+12) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 64 - (x - 50)^2 / 100
        pset(x, y, 6) -- plot the point in white (color 7)
    end
    
    for x = (74-19), (74+12) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 66 - (x - 50)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = (74-19), (74+14) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 67 - (x - 50)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    
    for x = (74-19), (74+19) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 70 - (x - 74)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
        for x = (74-19), (74+19) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 72 - (x - 74)^2 / 100
        pset(x, y, 6) -- plot the point in white (color 7)
    end
    
    for x = (74-16), (74+16) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 78 - (x - 74)^2 / 100
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = (74-7), (74+15) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 84 - (x - 60)^2 / 130
        pset(x, y, 7) -- plot the point in white (color 7)
    end
end

function draw_left_half_circle()
    local h = 93 -- x-coordinate of the center
    local k = 20 -- y-coordinate of the center
    local r = 3 -- radius of the circle

    for y = k - r, k + r do
        -- calculate x for the left half of the circle
        local x = h - sqrt(r^2 - (y - k)^2)
        pset(x, y, 10) -- plot the point in white (color 7)
    end
end





function draw_parabola2()
				
				for x = (90-5), (90+8) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 10 + (x - 60)^2 / 130
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = (90-5), (90+8) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 11 + (x - 60)^2 / 130
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = (90-7), (90+7) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 12 + (x - 60)^2 / 115
        pset(x, y, 10) -- plot the point in white (color 7)
    end
    
    for x = (90-8), (90+5) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 15 + (x - 60)^2 / 109
        pset(x, y, 7) -- plot the point in white (color 7)
    end
    
    for x = (90-8), (90+1) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 19 + (x - 60)^2 / 100
        pset(x, y, 10) -- plot the point in white (color 7)
    end
 
end

function draw_parabola3()

//(100, 99, 10, 3)
    for x = (100-6), (100+10) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 115 - (x - 60)^2 / 150
        pset(x, y, 11) -- plot the point in white (color 7)
    end
    
    for x = (100-3), (100+10) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 115 - (x - 60)^2 / 220
        pset(x, y, 11) -- plot the point in white (color 7)
    end
    
    for x = (100-3), (100+8) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 116 - (x - 60)^2 / 220
        pset(x, y, 11) -- plot the point in white (color 7)
    end
    
    
    for x = (100-10), (100+8) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 100 - (x - 60)^2 / 400
        pset(x, y, 11) -- plot the point in white (color 7)
    end
    
    for x = (100-10), (100+10) do
        -- invert the quadratic equation to make the parabola face upwards
        local y = 103 - (x - 60)^2 / 395
        pset(x, y, 11) -- plot the point in white (color 7)
    end
end

function dptypes()
    cls()
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 20 + (x - 64)^2 / 100
        pset(x, y, 1) -- plot the point in white (color 7)
    end
    
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 15 + (x - 64)^2 / 250
        pset(x, y, 1) -- plot the point in white (color 7)
    end
    
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 10 + (x - 64)^2 / 250
        pset(x, y, -15) -- plot the point in white (color 7)
    end
    
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 130 - (x - 64)^2 / 250
        pset(x, y, -15) -- plot the point in white (color 7)
    end
    
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 130 - (x - 64)^2 / 200
        pset(x, y, -15) -- plot the point in white (color 7)
    end
    
    for x = 0, 127 do
        -- calculate y as a function of x (a simple parabola)
        local y = 115 - (x - 64)^2 / 300
        pset(x, y, -15) -- plot the point in white (color 7)
    end
    
    pset(45, 90, 12)
    pset(46, 92, 12)
    pset(45, 95, 12)
    pset(40, 100, 2)
    pset(46, 100, 2)
    circ(40, 100, 3, 2)
    
    
    circfill(0, 64, 48, 1)
    circfill(0, 64, 44, 13)
    circfill(0, 64, 42, 10)
    circfill(0, 64, 41, 2)
    circfill(0, 64, 40, 9) -- big yellow planet at side

    
    circfill(90, 20, 17, 1)
    circfill(90, 20, 12, 13)
    circfill(90, 20, 10, 10)
    circfill(90, 20, 9, 2)
    circfill(90, 20, 8, 9) -- small yellow planet
    
    circfill(100, 99, 15, 1)
    circfill(100, 99, 12, 13)
    circfill(100, 99, 11, 0)
    circfill(100, 99, 10, 3) -- green planet
    
    
    circfill(74, 65, 29, 1)
    circfill(74, 65, 22, 13)
    circfill(74, 65, 21, 12)
    circfill(74, 65, 20, 0)
    circfill(74, 65, 19, 12) -- blue planet
				
			 pset(100, 50, 6)
			 pset(104, 55, 6)
			 pset(98, 50, 12)
			 pset(92, 50, 12)
			 pset(99, 55, 12)
			 pset(99, 40, 7)
			 circ(98, 50, 3, 12)
			 
			 pset(13, 20, 7)
			 pset(13, 15, 7)
			 pset(10, 15, 12)
			 circ(11, 10, 3, 12)
			 circ(11, 10, 1, 12)
			 
			 circ(40, 10, 1, 12)
			 pset(47, 12, 7)
			 pset(47, 16, 7)
			 pset(43, 12, 7)
			 
			 

				draw_parabola()
				draw_parabola2()
				draw_parabola3()
    draw_parabolabigy() -- draw the parabola
 
 
 local wrapped_text = wrap_text(ptext[textnum], 90)
 local box_height = calc_box_height(wrapped_text)
 
 rectfill(1, 90, 90, 90 + box_height, 7)
 rect(0, 89, 90, 91 + box_height, 1)
 spr(7,1,73,2,2)
 local y_offset = 101
 for line in all(wrapped_text) do
  print(line, 2, y_offset-10, 1)
  y_offset += 8
 end
 
 print("➡️", 81, y_offset-11)
 print("⬅️", 3, y_offset-11)
 
end


-->8
--selection box functions

function isel()
 seltable={"yes","no"}
 selected=1
end

function usel()
 if btnp(➡️) then
  if selected==1 then
   selected+=1
  end
 elseif btnp(⬅️) then
  if selected==2 then
   selected-=1
  end
 end
 
 if (selected==1 and btnp(❎)) then
  img1()
  state="cutscene"
  
 elseif (selected==2 and btnp(❎)) then
  state="play"
 end
end

function dsel()
 rectfill(30,60,98,92,7)
	rect(30,60,98,92,1)
	rectfill(24+22*selected,78,40+22*selected,86,13)
	for i=1,#seltable do
	 print(seltable[i],27+22*i,80,1)
	end
	print("start minigame?",35,68,1)
end
-->8
function wrap_text(text, width)
 local wrapped_text = {}
 local line = ""
 
 for word in all(split(text, " ")) do
  local test_line = line == "" and word or line.." "..word
  if print(test_line, 0, -10) > width then
   add(wrapped_text, line)
   line = word
  else
   line = test_line
  end
 end
 if #line > 0 then
  add(wrapped_text, line)
 end
 
 return wrapped_text
end

function calc_box_height(wrapped_text)
 return 5 + #wrapped_text * 8
end

--cutscene functions
function icutscene()
 parts = {}
 starfield = {}
 startimer = 0

	-- todo: uncomment after test
 text1 = {
--  "greetings rover,",
--  "for this mission, you will help me discover an exoplanet using the transit method.",
--  "the transit method is done by observing the brightness of stars.",
--  "when a planet passes in front of a star, the star's light levels dip briefly for the observer.",
--  "consistent dips in light suggest the presence of a planet orbiting the star.",
--  "now lets use this to discover some exoplanets of our own.",
--  "in this minigame, you'll be looking at some stars.",
--  "only 3 of these stars will have an exoplanet orbiting them.",
--  "your job is to figure out which 3 stars have an exoplanet.",
--  "stars with exoplanets will get dimmer and brighter at a constant rate.",
--  "to switch between the star you are observing,         use ⬅️ and ➡️.",
--  "to select a star you think has an exoplanet, press 🅾️.",
--  "once you have selected 3 stars, use ❎ to check if you are correct.",
--  "good luck!",
 }
 
 -- todo: uncomment after test
 text2 = {
  "welcome back rover, ready to discover another exoplanet?",
  "sometimes, exoplanets can be hard to see because of the light from nearby stars.",
  "to make the exoplanets more visible, scientists block the light coming from the star so that they can see the exoplanet better.",
  "this technique is called the direct imaging method.",
  "for this mission, we will be using direct imaging to discover a new exoplanet.",
  "i already set up a camera facing a star.",
  "there are some asteroids flying around. your job is to take a picture when an astroid is blocking the light from the star.",
  "once you are ready to take the picture, press ❎.",
  "then we will be able to see if the star has an exoplanet orbiting it.",
  "good luck rover!",
 }
 
 msgindex = 1
end

function ucutscene()
 startimer += 1
 if startimer > 2 then
  add(starfield, {
   x = rnd(128),
   y = -10,
   c = 7,
   speed = .3 + rnd(2)
  })
  startimer = 0
 end

 for s in all(starfield) do
  s.y += s.speed
  if s.y > 128 then
   del(starfield, s)
  elseif s.speed < 2 and s.speed > 1 then
   s.c = 6
  elseif s.speed <= 1 then
   s.c = 5
  end
 end

 for i = 1, 4 do
  add(parts, {
   x = 58 + rnd(12),
   y = 86 + rnd(5),
   r = 2 + rnd(2),
   c = 10,
   speed = 1 + rnd(2)
  })
 end

 for p in all(parts) do
  p.y += p.speed
  p.r -= .1
  if p.r < 0 then
   del(parts, p)
  end
  if p.r > 3 then
   p.c = 10
  elseif p.r <= 3 and p.r > 1 then
   p.c = 9
  elseif p.r <= 1 then
   p.c = 5
  end
 end

 if btnp(➡️) then
  msgindex += 1
 end
 
 if csnum==1 then
  if current_music~=9 then
   current_music=9
   music(9)
  end
 elseif csnum==2 then
  if current_music~=7 then
   current_music=7
   music(7)
  end
 end
end

function dcutscene()
 cls()
 for p in all(parts) do
  circfill(p.x, p.y, p.r, p.c)
 end
 
 for s in all(starfield) do
  pset(s.x, s.y, s.c)
 end
 
 spr(128, 48, 56, 4, 4)

 local current_text = csnum == 1 and text1[msgindex] or text2[msgindex]
 local wrapped_text = wrap_text(current_text, 108)
 local box_height = calc_box_height(wrapped_text)
 
 rectfill(10, 80, 118, 80 + box_height, 7)
 rect(9, 79, 119, 81 + box_height, 1)
 spr(7,10,63,2,2)
 local y_offset = 91
 for line in all(wrapped_text) do
  print(line, 11, y_offset-10, 1)
  y_offset += 8
 end

 if csnum == 1 and msgindex > #text1 then
  state = "mg1"
  msgindex = 1
 elseif csnum == 2 and msgindex > #text2 then
  mg2reset()
  msgindex = 1
 end

 print("➡️", 111, y_offset-11)
end
-->8
--minigame 1 functions

function img1()
				bg_stars_init(3,80)

    star_timer=0
    dim=false

    correct_stars=init_correct_stars()
    win=nil
    
    mg1_star_names={
     "proxima centauri",
     "lalande 21185",
     "gliese 1061",
     "wolf 1061",
     "61 virginis",
     "55 cancri",
     "hd 40307",
     "nu lupi",
     "gj 9827",
    }
    mg1_show_discovery=false
    mg1_spr_idx=0
    mg1_spr_timer=15

    --table containing stars
    mg1_stars={}

    mg1_add_star(10,9)
    mg1_add_star(12,1)
    mg1_add_star(11,3)
    mg1_add_star(14,8)
    mg1_add_star(9,4)
    mg1_add_star(8,2)
    mg1_add_star(7,6)
    mg1_add_star(2,1)
    mg1_add_star(15,4)

    selected_stars={}
    cur_star_i=1
    cur_star=mg1_stars[cur_star_i]
end

function umg1()
    star_timer+=1
    if star_timer>cur_star.freq then
        dim=not dim
        star_timer=0
        if not contains(correct_stars,cur_star_i) then
            change_freq()
        end
    end
    
				mg1_spr_timer -= 1
				if mg1_spr_timer < 0 then
				    mg1_spr_timer=15
				    mg1_spr_idx += 1
				    if (mg1_spr_idx > 2) mg1_spr_idx=0
    end
    
    if btnp(❎) and mg1_show_discovery==true then
    	state="play"
    elseif btnp(❎) and win==true then
    	mg1_show_discovery=true
    end

    if btnp(⬅️) then 
        cur_star_i-=1
        if cur_star_i==0 then cur_star_i=9 end
        cur_star=mg1_stars[cur_star_i]
    end
    if btnp(➡️) then
     cur_star_i+=1
     if cur_star_i==10 then cur_star_i=1 end
        cur_star=mg1_stars[cur_star_i]
    end
    if btnp(🅾️) then
        if not contains(selected_stars,cur_star_i) and #selected_stars<3 then
            add(selected_stars,cur_star_i)
        else
            del(selected_stars,cur_star_i)
        end
    end
    if btnp(❎) and #selected_stars==3 then
        check_win_lose()
    end
end

function dmg1()
    cls()
    
    if mg1_show_discovery==true then
    	mg1_discovery_screen()
    	
    	return
    --win/lose
    elseif win!=nil then
        if win then
            print("★ you win! ★",37,64,10)
        				print("press ❎ to continue", 24, 75, 13)
        else
            print("you lose :(",43,64,8)
        end

        return
    end

    --background
				bg_draw_stars()

    --ui
    print("⬅️",6,61,6)
    print("➡️",115,61,6)
    print(#cur_star.name)
    print(cur_star.name,(129-(#cur_star.name)*4)/2,28,7)

    --selected stars
    for i=1,#selected_stars do
        circfill(5+12*(i-1),5,3,mg1_stars[selected_stars[i]].dim)
        circfill(5+12*(i-1),5,2,mg1_stars[selected_stars[i]].bright)
    end
    if contains(selected_stars,cur_star_i) then
        print("🅾️ to unselect",37,90,7)
    elseif #selected_stars>=3 then
        print("3 stars selected",34,90,7)
    else
        print("🅾️ to select",41,90,7)
    end

    if #selected_stars==3 then
        print("❎ to confirm selection",19,100,11)
    end

    --star
    if dim then
        colour1=cur_star.dim
        colour2=cur_star.bright
        star_size=cur_star.size
    else
        colour1=cur_star.bright
        colour2=cur_star.dim
        star_size=cur_star.size+1
    end
    circfill(64,64,star_size,colour2)
    circfill(64,64,star_size-3,colour1)
end

function mg1_add_star(bright,dim)
    star = {}
    star.name=mg1_star_names[#mg1_stars+1]
    star.bright=bright
    star.dim=dim
    star.size=6+flr(rnd(12))
    star.freq=3+flr(rnd(15))

    add(mg1_stars,star)
end

function change_freq()
        cur_star.freq=3+flr(rnd(15))
end

function contains(a,x)
    for v in all(a) do
        if v==x then return true end
    end
    return false
end

function init_correct_stars()
    correct={}

    while #correct<3 do
        num=flr(rnd(9))+1
        if not contains(correct,num) then
            add(correct,num)
        end
    end

    return correct
end

function check_win_lose()
    win=false
    for v in all(correct_stars) do
        if not contains(selected_stars,v) then
            return
        end
    end
    win=true
    return
end

function mg1_discovery_screen()
--	helper_grid()

	print("you discovered:", 36, 16, 7)

	print("kepler-22 b", 43, 32, 10)

	spr(96 + (mg1_spr_idx * 2), 56, 48, 2, 2)

	print("'AN OCEAN WORLD'", 34, 73, 7)

	local x, clr=4, 5
	print("originally found in 2011, this", x, 86, clr)
	print("exoplanet is classified as a", x, 93, clr)
	print("'super earth'. residing in the", x, 100, clr)
	print("habitable zone, its conditions", x, 107, clr)
	print("allow for liquid water!", x, 114, clr)

	print("❎", 116, 121, 6)
end

-- grid helper
function helper_grid()
	for x = 0, 127, 16 do
  line(x, 0, x, 127, 5)
 end
 line(127, 0, 127, 127, 5)

 for y = 0, 127, 16 do
  line(0, y, 127, y, 5)
	end
	line(0, 127, 127, 127, 5)
end
-->8
function mg2reset()

	state = "mg2b"
	
	img2b()
	img2s()
	img2a()
end


-- draw entities
function draw_entities()
	draw_particles(starlist)
	draw_particles(flares)
	circfill(64, 64, mid(9, main_radius, 10), 10) -- main star
 
 for circle in all(circles) do
 	circfill(circle.x, circle.y, circle.radius, circle.clr)
	end
end

--------------------------------

-- adds randomized circle to table of circles
function spawn_circle()

	local x, y = choose_spawn()

	-- 1/3 passes over main star
	local target_x, target_y, radius
	if rnd(3) < 1 then
		target_x, target_y = 64, 64
		radius = 14 -- radius of 12 is actually tough
	else
		target_x = 64 + (rnd(64) - 32)
		target_y = 64 + (rnd(64) - 32)
		radius = 7 + rnd(5)
	end
	
	local dx, dy = target_x - x, target_y - y
	local dist = sqrt(dx^2 + dy^2)
	
	--	normalize velocity
	dx /= dist
	dy /= dist
	
	-- randomized speed factor -> [2, 4]
	local speed_factor = (2 + rnd(2))
	
	local clr_list = {1, 4, 5, 6, 13}
	
	local circle = {
		x = x,
		y = y,
		radius = radius,
		dx = dx * speed_factor,
		dy = dy * speed_factor,
		clr = flr(rnd(clr_list)) 
	}
	
	add(circles, circle)
end


-- returns randomized x, y value around edges of screens
function choose_spawn()
	local x, y
	local rand = rnd(4)
	
	if rand < 1 then
		x = 0
		y = rnd(128)
	elseif rand < 2 then
		x = 128
		y = rnd(128)
	elseif rand < 3 then
		x = rnd(128)
		y = 0
	else
		x = rnd(128)
		y = 128
	end
	
	return x, y
end

--------------------------------

-- create stars
function create_stars()
 for i=1,1 do
  add(starlist, {
  	x=rnd(128+64),
   y=rnd(128),
   dx=rnd(0.5)+0.5,
   dy=rnd(2)-1,
   radius=0,
   timer=20,
   clr=7})
 end
   
 for p in all(starlist) do
  p.x -= p.dx
  p.timer -= 1
 	if (p.timer < 0) del(starlist, p)
 end
end


-- create sun flares
function create_flares()
 for i=1,2 do
 	add(flares, {
 		x=64,
 		y=64,
   rad=0,
   dx=rnd(2)-1,
   dy=rnd(2)-1,
   timer=15 + rnd(10),
   clr=10,
   gravity=0.001})
 end
        
 for p in all(flares) do
  p.x+=p.dx
  p.y+=p.dy
  p.dy+=p.gravity
  
  if (p.timer < 20) p.clr=9
  if (p.timer < 10) p.clr=10
        
  p.timer -= 1
  if (p.timer < 0) del(flares, p)
 end
end

-- particle drawer
function draw_particles(prt)
    for p in all(prt) do
        circfill(p.x,p.y,p.radius,p.clr)
    end
end
-->8
function img2b()
	circles = {}
	starlist = {}
	flares = {}
	spawn_timer = 15
	spawn_delay = 120
	main_radius = 10
	expanding = true
	pulsate_speed = 0.3
end


function umg2b()
	create_stars()
	create_flares()
	
	if expanding then
		main_radius += pulsate_speed
		if (main_radius >= 11) expanding=false
	else
		main_radius -= pulsate_speed
		if (main_radius <= 8) expanding=true
	end

	if (btnp(❎)) state="mg2s"

	spawn_timer += 1
	if (spawn_timer > spawn_delay) spawn_timer=rnd(15) spawn_circle()
	
	for circle in all(circles) do
		circle.x += circle.dx
		circle.y += circle.dy
		
		-- remove circles that are off-screen
		if circle.x > 128 or circle.y > 128 or circle.x < 0 or circle.y < 0 then
			del(circles, circle)
		end
	end
end


function dmg2b()
 cls()
 draw_entities()
end
-->8
function img2s()
	shutter_radius = 1
	speed = 6
	is_closing = true
end

function umg2s()
	if is_closing then
		shutter_radius += speed
		if (shutter_radius >= 65) is_closing=false
		
	else
		shutter_radius -= speed
		if (shutter_radius <= 1) state="mg2a"
	end
end

function dmg2s()
 cls()
 draw_entities()

	local clr = 7
	rectfill(-1, -1, 128, shutter_radius, clr)
	rectfill(-1, 128, 128, 128 - shutter_radius, clr)
	rectfill(-1, -1, shutter_radius, 128, clr)
	rectfill(128, -1, 128 - shutter_radius, 128, clr)
end
-->8
function img2a()
	counter = -30
	show_banner = false
	show_message = false
	covered = false
	
	mg2_show_discovery=false
 mg2_spr_idx=0
 mg2_spr_timer=15
end

--------------------------------
function umg2a()

	mg2_spr_timer -= 1
	if mg2_spr_timer < 0 then
		mg2_spr_timer=15
	 mg2_spr_idx += 1
	 if (mg2_spr_idx > 2) mg2_spr_idx=0
 end

	if covered == false then
		for c in all(circles) do
			if (is_covering(c.x, c.y, c.radius)) covered=true
		end
	end

	counter += 3
	
	if (counter >= 0) show_banner=true
	if (counter >= 72) show_message=true
end

function is_covering(x, y, r)
	local dist = sqrt((64-x)^2 + (64-y)^2)
	return dist + 10 <= r
end

--------------------------------
function dmg2a()
 cls()
	
	if mg2_show_discovery==true then
		mg2_discovery_screen()
		if (btnp(❎)) state="play"
		return
	end
	
	draw_entities()
	
	local message, clr = "success!", 3
	if (not covered) message="missed..." clr=8

	if show_banner == true then
		rectfill(-1, 60, counter, 72, 7)
		rectfill(128, 60, 128-counter, 72, 7)
	
		rectfill(-1, 58, counter, 59, clr)
		rectfill(128, 58, 128-counter, 59, clr)
		rectfill(-1, 73, counter, 74, clr)
		rectfill(128, 73, 128-counter, 74, clr)
	end
	
	if show_message == true then
	 if covered == true then
			print(message, 50, 64, clr)
			rectfill(36, 76, 94, 84, 0)
			print("❎ to continue", 38, 78, 6)
			if (btnp(❎)) mg2_show_discovery=true
		else
			print(message, 50, 64, clr) 
			rectfill(34, 76, 96, 84, 0)
			print("❎ to try again", 36, 78, 6)
			if (btnp(❎)) mg2reset()
		end
	end	
end

function mg2_discovery_screen()
--	helper_grid()

	print("you discovered:", 36, 16, 7)

	print("gj-504 b", 48, 32, 10)

	spr(102 + (mg2_spr_idx * 2), 56, 48, 2, 2)

	print("'A PUFFY PINK PLANET'", 24, 73, 7)

	local x, clr=2, 5
	print("originally found in 2013, this", x, 86, clr)
	print("exoplanet is classified as a", x, 93, clr)
	print("'gas giant'. glowing from the", x, 100, clr)
	print("heat of its formation, it emits", x, 107, clr)
	print("a dark cherry blossom hue.", x, 114, clr)

	print("❎", 116, 121, 6)
end

-->8
--title functions

function ititle()
 bg_stars_init(5,120)
end

function bg_stars_init(freq,life)
 stars_timer=0
 stars_freq=freq
 star_life=life
 stars={}
end

function utitle()
 if (btnp(❎) or btnp(🅾️)) then
  state="controls"
 end
end

function dtitle()
 cls(0)
 
 bg_draw_stars()
 
 chars={32,34,36,38,40,36,42,44,42}
 
 drawx=4+sin(t())
 drawy=52+2*sin(t()/3)
 
 for v in all(chars) do
  draw_char(v,drawx,drawy)
  drawx+=13
 end
 
 print("press z or x to start",20,84,6)
end

function draw_char(char,x,y)
 spr(char,x,y)
 spr(char+1,x+8,y)
 spr(char+16,x,y+8)
 spr(char+17,x+8,y+8)
end

function bg_draw_stars()
	if stars_timer>stars_freq then
  stars_timer=0
  add_star(flr(rnd(127)),flr(rnd(127)))
 end
 stars_timer+=1
 
 draw_stars()
end

function add_star(x,y)
 star={
  x=x,
  y=y,
  life=star_life+flr(rnd(star_life/4)),
 }
 
 add(stars,star) 
end

function draw_stars()
 for star in all(stars) do
  if star.life>16 then
   pset(star.x,star.y,6)
  else
   pset(star.x,star.y,5)
  end
  star.life-=1
  if star.life<=0 then
   del(stars,star)
  end
 end
end
-->8
-- initialize controls tutorial
function icontrols()
    -- set state to "controls" initially
end

local button_cooldown = 2
-- update function for controls tutorial
function ucontrols()
	if button_cooldown > 0 then
  button_cooldown -= 1
 end
    -- check for button press ❎ (x key)
 if (btnp(❎) or btnp(🅾️)) and button_cooldown==0 then
  state = "intro" 
		button_cooldown = 2
	end
end

-- draw function for controls tutorial
function dcontrols()
    -- clear the screen
    cls()

    -- dimensions for the text box
    local x0 = 16
    local y0 = 16
    local x1 = 112
    local y1 = 112

    -- draw a large rectangular box centered in the screen
    rectfill(x0, y0, x1, y1, 1)  -- black box
    rect(x0, y0, x1, y1, 7)       -- white border

    -- display the control instructions inside the box
    local text_x = x0 + 8
    local text_y = y0 + 8
    print("general controls", text_x,text_y, 12)
    print("move: arrow keys", text_x, text_y + 48, 7)
    print("🅾️: z", text_x, text_y + 16, 7)
    print("❎: x", text_x, text_y + 24, 7)
    print("➡️: right arrow", text_x,text_y+32, 7)
    print("⬅️: left arrow", text_x,text_y+40, 7)
    print("press ❎ to play", text_x, text_y + 80, 6)
end
-->8
--intro page functions 
function iintropage()
	bg_stars_init(3,80)
 intro_text = {
  "hello there! welcome to the 3xoplorers program, rover.",
  "my name is pubert, chief 3xoplerer.",
  "our vast galaxy is filled with planets outside our solar system, called exoplanets.",
  "most exoplanets orbit another star, light years away from earth.",
  "we need your help to learn more about the billions we're yet to discover.",
  "how can we begin looking for new exoplanets? there are 5 main ways.",
 }

 intromsgindex=1
end

function uintropage()
 if btnp(➡️) then
  intromsgindex += 1
 end
end

function dintropage()
	cls()
	bg_draw_stars()
 local current_text = intro_text[intromsgindex]
 local wrapped_text = wrap_text(current_text, 108)
 local box_height = calc_box_height(wrapped_text)
 
 rectfill(10, 80, 118, 80 + box_height, 7)
 rect(9, 79, 119, 81 + box_height, 1)
 spr(7,10,63,2,2)
 local y_offset = 91
 for line in all(wrapped_text) do
  print(line, 11, y_offset-10, 1)
  y_offset += 8
 end

 if intromsgindex > #intro_text then
  state = "discovery methods"
  intromsgindex = 1
 end

 print("➡️", 111, y_offset-1)
end

-->8
-- single large text box for all discovery methods
function ddiscoverymethods()
    -- full text to display, breaking up long descriptions as needed
    local all_text = {
        {"exoplanet discovery methods", 0},
        {"1. radial velocity:", 1, "   wobbling stars", 5},
        {"2. transit:", 1,"   shadows over stars", 5},
        {"3. direct imaging:", 1, "   blocked starlight", 5},
        {"4. gravitational microlensing", 1, "   light bent by gravity", 5},
        {"5. astrometry:", 1, "   star position shifts", 5}
    }

    -- determine box dimensions
    local box_width = 120  -- wider box width
    local x_pos = (128 - box_width) / 2
    local y_pos = 8
    local box_height = 110  -- adjusted height for longer text

    -- draw the text box in the center
    rectfill(x_pos, y_pos, x_pos + box_width, y_pos + box_height, 7)  -- white box background
    rect(x_pos - 1, y_pos - 1, x_pos + box_width + 1, y_pos + box_height + 1, 1)  -- black border

    -- print the title and discovery methods inside the box
    local y_offset = y_pos + 6
    for entry in all(all_text) do
        -- print title or label
        if entry[1] ~= "" then
            print(entry[1], x_pos + 4, y_offset, entry[2])
            y_offset += 8
        end

        -- print description if available
        if entry[3] then
            print(entry[3], x_pos + 8, y_offset, entry[4])
            y_offset +=10
        end
    end

    -- display navigation prompt at the bottom
    print("❎ continue", x_pos + box_width - 50, y_pos + box_height - 6, 0)
end

-- handle navigation for the discovery methods text
function udiscoverymethods()
    if btnp(❎) then  -- ❎ button to continue
        state = "ptypes"  -- transition to the next game state as needed
    end
end

-->8
-- initialize naming page
function inamingpage()
				bg_stars_init(3,80)
    naming_text = {
        {"exoplanet nomenclature", 0}, -- color for the title
        {"1. the telescope or survey \n that discovered it", 1},
        {"2. the numerical order in \n which the planet's host star was cataloged", 1},
        {"3. the alphabetic proximity \n order of the planet from its \n host star (starting from b)", 1},
    }

    naming_intro_text = "exoplanet names follow a logical cataloging system, based on three facts:"
    example_text = "for example, kepler-16 b is the closest planet to the 16th star cataloged by the kepler telescope."
				game_start_text = "now that you're equipped with some exoplanet basics, you're ready to be an 3xoplorer, rover!"
				naming_index = 0
end

-- update function for naming page
function unamingpage()
				if naming_index ==0 then
					naming_index = 1
    elseif naming_index==5 then
    	state="play"
    elseif btnp(➡️) and (naming_index==1 or naming_index>2) then  -- ❎ button to continue
    	naming_index += 1
    elseif btnp(❎) and naming_index==2 then
   		naming_index +=1
   	end
end

-- draw function for naming page
function dnamingpage()
    cls()  -- clear the screen
				bg_draw_stars()
				if naming_index==1 then
					local current_text = naming_intro_text
 				local wrapped_text = wrap_text(current_text, 108)
 				local box_height = calc_box_height(wrapped_text)
 
 				rectfill(10, 80, 118, 80 + box_height, 7)
 				rect(9, 79, 119, 81 + box_height, 1)
 				spr(7,10,63,2,2)
 				local y_offset = 91
 				for line in all(wrapped_text) do
  				print(line, 11, y_offset-10, 1)
  				y_offset += 8
 				end
 				print("➡️", 111, y_offset-1)
 			end
 			if naming_index==2 then
					local box_width = 120  -- wider box width
    	local x_pos = (128 - box_width) / 2
    	local y_pos = 8
    	local box_height = 110  -- adjusted height for longer text

    -- draw the text box in the center
    	rectfill(x_pos, y_pos, x_pos + box_width, y_pos + box_height, 7)  -- white box background
    	rect(x_pos - 1, y_pos - 1, x_pos + box_width + 1, y_pos + box_height + 1, 1)  -- black border

    -- print the title and discovery methods inside the box
    	local y_offset = y_pos + 6
    	for entry in all(naming_text) do
        -- print title or label
        if entry[1] ~= "" then
            print(entry[1], x_pos + 4, y_offset, entry[2])
            y_offset += 20
        end
    	end

    -- display navigation prompt at the bottom
    print("❎ continue", x_pos + box_width - 50, y_pos + box_height - 6, 0)
				elseif naming_index==3 or naming_index==4 then
					local current_text = naming_index==3 and example_text or game_start_text
 				local wrapped_text = wrap_text(current_text, 108)
 				local box_height = calc_box_height(wrapped_text)
 
 				rectfill(10, 80, 118, 80 + box_height, 7)
 				rect(9, 79, 119, 81 + box_height, 1)
 				spr(7,10,63,2,2)
 				local y_offset = 91
 				for line in all(wrapped_text) do
  				print(line, 11, y_offset-10, 1)
  				y_offset += 8
 				end
 				print("➡️", 111, y_offset-1)
 			end
 		
end

__gfx__
000000006dddddddddddddd66dddddddddddddd60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd0aa000aaa000aa00000000000000000000000000000000000000000000000000000000000000000000000000
00700700dddddddddddddddddddddddddddddddd099a0a999a0a9900000001111110000000000000000000000000000000000000000000000000000000000000
00077000dddddddddddddddddddddddddddddddd0909a99999a90900000016676771000000000000000000000000000000000000000000000000000000000000
00077000dddddddddddddddddddddddddddddddd09009a999a900900000166666667100000000000000000000000000000000000000000000000000000000000
00700700dddddddddddddddddddddddddddddddd09a009aaa900a90000166699aaa6710000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd009aa99999aa900000166999999a710000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd0009449994490000001669999999610000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd000000a9a0000000001d64999999610000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd00000a999a0000000001d6449996100000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd000009999900000000001dd66661000000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd0000092229000000000011166111000000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd0000092229000000000166666666100000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd000004444400000000166666dd66610000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddddddddddd0000000000000000001d6166dd61610000000000000000000000000000000000000000000000000000000000
000000006dddddddddddddd66dddddddddddddd60000000000000000001dd1666661d10000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001111111100000010000000000100000001111111000000000111111110000010000000000000000001111111100000000111111111000000000000000000
00017777777710000171000000001710000017777777100000001777777771000171000000000000000017777777710000001777777777100000000000000000
00177777777771000177100000017710000177777777710000017777777777100177100000000000000177777777771000017777777771000000000000000000
01771111111177100177100000017710001711111111771000171111111177100177100000000000001700000000771000171111111110000000000000000000
01710000000177100017710000177100017710000001771001771000000177100177100000000000017700000000771001771000000000000000000000000000
00100000000177100017771001777100017710000001771001771000000177100177100000000000017700000000771001771000000000000000000000000000
00000011111771000001777117771000017710000001771001771111111171000177100000000000017700000000710001771111111100000000000000000000
00000177777710000000177777710000017710000001771001777777777710000177100000000000017777777777100001777777777710000000000000000000
00000017777710000000177777710000017710000001771001777777777100000177100000000000017777777777100001777777777100000000000000000000
00000001111171000001777117771000017710000001771001771111111000000177100000000000017711111177710001771111111000000000000000000000
00100000000177100017771001777100017710000001771001771000000000000177100000000000017710000017710001771000000000000000000000000000
01710000000177100017710000177100017710000001771001771000000000000177100000000000017710000001771001771000000000000000000000000000
01771111111777100177100000017710017711111111710001771000000000000177111111111000017710000001771000171111111110000000000000000000
00177777777771000177100000017710001777777777100001771000000000000017777777777100017710000001771000017777777771000000000000000000
00017777777710000171000000001710000177777771000001710000000000000001777777777710017100000000171000001777777777100000000000000000
00000000001000000000000000000000000100000000000000000000000000000000100000000000000000000000000000000000000000000000000000010000
00000000015100000000000000100000001510000000000000010000000000000001510000010000000010000000000000000000000100000000100000151000
00000000011110000000000001510000001111000000000000151000000000000001110000151000000151000001000000001000001510000001510000111000
00000000115151000000000001111000001515110000000000111100000000000001511111151000000111000015100000015100001110000001511111151000
00000001444444100000000011515100014444441000000000151511000000000001444444441000000151111115100000015111111510000001444444441000
0000000144444d10000000014444441001d444441000000001444444100000000001d444444d1000000144444444100000014444444410000001444444441000
00000001444444100000000144444d10014444441000000001d444441000000000014444444410000001d444444d100000014444444410000001444444441000
00000000115111000000000144444410001151110000000001444444100000000000115111110000000144444444100000014444444410000000111115110000
00001111115110000000111111511100000151111111000000115111111100000000015111100000000011511111000000001111151100000000011115100000
00114444444441000011444444444100001444444444110000144444444411000001144444411000000114444441100000011444444110000001144444411000
01444444444444100144444444444410014444444444441001444444444444100014444444444100001444444444410000144444444441000014444444444100
01ffffffff44641001ffffffff446410014844ffffffff10014844ffffffff10001f44446484f100001f44446484f100001ffffffffff100001ffffffffff100
01444444444444100144444444444410014444444444441001444444444444100014444444444100001444444444410000144444444441000014444444444100
01651116511165100156111561015610016511165111651001561115611156100011551111551100001166111166110000116611116611000011551111551100
01561015610156100165101651016510015610156101561001651016510165100001661001661000000155100155100000015510015510000001661001661000
01111011110111100111101111011110011110111101111001111011110111100001111001111000000111100111100000011110011110000001111001111000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000002eeee20000000000eeeee20000000000e22ee2000000000000000000000000000000000000
000000c7c7700000000000c7c7700000000000c7c77000000000222e222220000000222e2222200000002e22222e200000000000000000000000000000000000
00000cccccc7000000000cccccc7000000000cccccc70000000e2222222e2e00000e2e222e2eee00000222e22e22220000000000000000000000000000000000
0000ccccccccc0000000ccccccccc0000000ccccccccc000000eeee22eeeee00000eeee2eeeeee00000eeee2eeeeee0000000000000000000000000000000000
000ccccccc66cc000006cccccccc6600000c66cccccccc0000eeeeeeeeeeeee000eeeeeeeeeeeee000eeeeeeeeeeeee000000000000000000000000000000000
000c66cccccccc00000ccc66cccccc00000ccccc66cccc0000eeeeeeee22eee000eeeeeeee2eeee000eeeeeeee2eeee000000000000000000000000000000000
000cccc6cccccc00000cccccc6cccc00000cccccccc6cc000022e2e22e22e22000e2e2e22e22eee00022e2ee2ee2e22000000000000000000000000000000000
0001cc6c6ccccc000001cccc6c6ccc000001cccccc6c6c0000e2222222e2e22000222222e2222220002222222222222000000000000000000000000000000000
0001ccc6ccc66c0000066cccc6ccc6000001cc66ccc6cc0000022e2eeee22e0000022e2eeee22e00000eeeee22222e0000000000000000000000000000000000
00001cccccccc00000001cccccccc00000001cccccccc000000eeeeeeeeeee00000eeeeeeeeeee00000eeeeeeeeeee0000000000000000000000000000000000
000001cccccc0000000001cccccc0000000001cccccc000000002222ee22200000002222eee2200000002eeee2e2200000000000000000000000000000000000
0000001111c000000000001111c000000000001111c00000000000e22220000000000022222000000000002222e0000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007777700000000000000111111111111111111111111112222221111111111111111111111111222222111111111111111122211111122111112
0000000000000777760000000000000011111111111111111222222221111111100000000000000000000000000000011d1111111111111111111111111111d1
00000000000077777660000000000000120000000000000000000000000000011099999999999999999999999999990111100000000000000000000000000111
00000000000077000660000000000000120000000000000000000000000000011099979999999999999999999999990111100767676967626767676767700111
000000000000770006600000000000001206609909906600ddd09292929299011099777999999999999999999997990111107777676967726767677767770111
000000000000700000600000000000001206609909906600ddd09992999299011097979977779777999797777979790111107777677967726777677767770111
000000000005777666650000000000001200000000000000d1d09992999999011097799799997999799999999997990111107777777977727777777777770111
000000000005576666550000000000001209908809909900d1d09999999999011099997999999797999999999999990111106666666966626666666666660111
000000000015755555651000000000001209908809909900d1d00000000000011099979999999977999999999997990111107777777977727777777777770111
000000000115777666651100000000001200000000000000d1d0ddd0ddd088011099979999999779999977797979790111100000000000000000000000000111
0000000111157776666511110000000012099066099099000100d1d0d1d08801209997999997797999999999999799011110c09060000000660880ccc0000111
0000000111757766666571110000000012099066099099007760d9d0dcd088011099977999799799977999999999990111100000000000000000000000000111
0000000117755766665577110000000012000000000000007660d9d0dcd00001109979979799799979979999999799011d1111111111111111111111111111d1
0000000117757555556577110000000012099099099088006660d9d0dcd099011099799979779999799799997979790111100000001111999111111111111111
0000000117757776666577110000000012099099099088000000d9d0dcd09901109799779799999997799999999799011110ccccc01000999000000000000111
000000111765777666657711100000001200000000000000000009000c000001109977999999999999999999999999012210ccccc01111999111111111111112
0000001177657776666577711000000012000000000000000000000000000001109999999999999999999999999999011210ccccc01111111111111111111112
00000111766575766565777711000000122222222225555555555555555555511000000000000000000000000000000112100000001111111111118881111112
000001177665757665657777110000001dddddddddddddddddddddddddddddd11222222222222222222222222222222112106060601000000000008880000112
0000117766657576656577776110000011111111111111111111111111111111111dddddddddddddddddddddddddd11112100000001111111111118881111112
00011177666575766565777661110000100000000000000011111111111111121111dddddddddddddddddddddddd111111106060601111111111111111111112
00111776666575766565776666111000099999999999999901111111111111121111111111111111111111111111111111100000001111111666111111111111
00117776666577666665666666611000099989977797979901111111188111121100000000000000000000000000001111106060601000000666000000000111
00117766666877666668656666611000099878999999999901616161888811121106660606060606060606060606001111100000001111111666111111111111
00117666656886666688656666611000099878979779777901616161888811111100000000000000000000000000001111100000601111111111111111111111
00666655566288888882665556666000098888899999999901111111188111121106606060606060606060660606001111106606601111111111111111111221
00006666666522222225666666600000099999999999999901111111111111111100000000000000000000660000001221100000001111111111111111111121
00006666666576657665666666600000100000000000000011111111111111111106066060666666606060600606001211111111111111111111111111111121
00006666666566656665666666600000110000000000000111111111122221211100000000000000000000000000001211111111111111111122222222211111
00000000000556656655000000000000111111111111111111111122111111111111111111111111111111111111111212221122222222222221111111111111
00000000000055555550000000000000222222211111111111222211222221221111111111111111111111111111111211122221111111111111111111111111
00000000000000000000000000000000111111111111111111111111111111111111122221222222222111211112111211111111111111111111112222222222
111111111111111111111111111111116dddddddddddddd600000000000000000000000000000000000000000000000000000600000000006dddbbbbbbbbddd6
11222211111111111111222221111222dddddddddddddddd0000000000000000000000000000000001000000000000000000676000000000dddbbbbbbbbbbddd
11000000100000000000000000000001dddddddddddddddd0000000000000000000000000001000000000000000000000000060000000000dddbbbbbbbbbbddd
11000000100000000000000000000001dddddddddddddddddddddddd00000000000600000100000000000000000000000000000000000000ddddbbbbbbbbdddd
11000000105555555555555555886601dddddddddddddddddddddddd00000000000000000000000000000000000001110000000000070000ddddddbbbbdddddd
11088880105555555555555558856601dddddddddddddddddddddddd000000000600060000000000000000000001111c1100000000000000dddddddddddddddd
11088880105555555555555558556601dddddddddddddddd11111111000000000000000000111100000000000001111c1100000000000000ddddddd22ddddddd
11000000105555555555555585556601dddddddddddddddd111111110000000000060000010000100000000000111cc11c10000000000000dddddd2222dddddd
11000000105555555555555855566901dddddddddddddddd000000000000000000000000010000100000000000ccc111c11c000000000000ddddd222222ddddd
11099990105555555556558556999601dddddddddddddddd00000000000000000000000001000010000000000011111c111cc00000000000ddddd222222ddddd
11099990105556555556885599966601dddddddddddddddd00000000000000000000000001000010000000000001cc1111ccc00000000000ddddd2d22d2ddddd
11000000105556555568999956666601dddddddddddddddd00000000000000000000000000111100000000000001111111cc000000000000ddddddd22ddddddd
21000000105556555999655556666601dddddddddddddddd0000000000000000000700000000000000600000000001110000000000001110ddddddd22ddddddd
11066660105599999866665566666601dddddddddddddddddddddddd00000000000000000000000660000000000000000000006000001010dddddddddddddddd
11066660109966585566666666666601dddddddddddddddddddddddd00000000000000000000000670000000000000000000000000001110dddddddddddddddd
110000001055668556666666666666016dddddddddddddd6dddddddd000000000000000600000000000000000000000000060000000000006dddddddddddddd6
1100000010888865666666666666660100000000000000000000000000000000000000000000000606000000000000006dddaaaaaaaaddd66dddccccccccddd6
110cccc01066666666666666666666010000000000000000000002222220000000000000000000000006000000000000dddaaaaaaaaaaddddddccccccccccddd
110cccc010666666666666666666660100000000000000000700222dddd2000000000000000000000000000000000000dddaaaaaaaaaaddddddccccccccccddd
110000001000000000000000000000010000000000000000000222d2222d200000000000000000000000000000000000ddddaaaaaaaaddddddddccccccccdddd
110000001000000000000000000000010000000000000000002222d2222d220000000000000000000000000000000000ddddddaaaaddddddddddddccccdddddd
1105555010999999999999999999980100000000000000000222222dddd2222000000000000555560000000000000000dddddddddddddddddddddddddddddddd
110556501099998999999999998998010000000000000000022222222222dd2000000000005555555000000000000000ddddddd22dddddddddddddd22ddddddd
1105566010899989989999989989980100000000000000000222ddd22222d2d000000000055666555500000000000000dddddd2222dddddddddddd2222dddddd
210566601000000000000000000000010000000000000000022d222d2222d2d000000000556555655550000000000000ddddd222222dddddddddd222222ddddd
210666601000000000000000000000010000000000000000022d222d222dd2d000000000556555655560000000000000ddddd222222dddddddddd222222ddddd
210000001dddddddddddddddddddddd100000000000000000222ddd222222d2000000000556555655650000000000000ddddd2d22d2dddddddddd2d22d2ddddd
1111111111dddddddddddddddddddd110000000000000000002222222222220000000000555666556550000000000000ddddddd22dddddddddddddd22ddddddd
111111111111111111111111111111110000000000000000000222222222200000000000055555555600000000000000ddddddd22dddddddddddddd22ddddddd
21111111122211111111111111121111000000000000000000002222d222000000000000005556655000000000000000dddddddddddddddddddddddddddddddd
111111222211122222222212111111110000000000000000000002222220000000000000000565560000000000000000dddddddddddddddddddddddddddddddd
1111111111111111111111111111111100000000000000000000000000000000000000000000000000000000000000006dddddddddddddd66dddddddddddddd6
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000031311010101010101010101000000000000000000000000000002121000000000000000000000000000021210000000000000000000000000000414110101010000000000000000000004141
__map__
0000dd0000000000d800000000dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c8000000e6e700c800d800c800c9ca00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c9ca00f6f7000000cbcc0000d9da00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000d9da0000cd00cd00dbdccd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00e9ea00dacd00c8c9ca00d800cddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f9fac800d800d8d9dadd0000c800d800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d6d6d6d6c6c6c6c6c6c6c6c6d6d6d6d600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8485868788898a8b8c8d8e8fc0c1c2c300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9495969798999a9b9c9d9e9fd0d1d2d300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a4a5a6a7a8a9aaabacadaeafe0e1e2e300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b4b5b6b7b8b9babbbcbdbebff0f1f2f300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cecfc4c5c4c5c4c5eeefc4c5c4c5c4c500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dedfd4d5d4d5d4d5feffd4d5d4d5d4d500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c4c5c4c5c4c5c4c5c4c5c4c5c4c5c4c500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d4d5d4d5d4d5d4d5d4d5d4d5d4d5d4d500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c4c5c4c5c4c5c4c5c4c5c4c5c4c5c4c500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d4d5d4d5d4d5d4d5d4d5d4d5d4d5d4d500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011e00000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023
911e000011000287002b7002d7002d7003070032700327003270013700327000b7003070032700287002b7002d7003070032700187001a7001c7001c7002870028750287402b7502d7502d740307503275032740
011e00000004000040070401004010040070400004000040070400904008040070400004000040070401004010040070400004000040070400904008040070400004000040070401004010040070400004000040
011e00000c0230c6000c0230c0230c0000c0230c0231a8000c0230c0231a8000c0230c023008000c0230c0230c8000c0230c023248000c0230c0231c8000c0230c0230c0000c0230c023000000c0230c02300000
911e0000327503475034740347303775032750327403273032720327103271032710327103271032700327003275034750347403275033750347503775037740377303b7503b7403b73039750347503375034750
011e00000704009040080400704002040020400904011040110400904002040090400e04011040110400204004040040400b04013040130400b04004040040400b04013040130400b04009040090401004018040
901e000034740347303472034710347103471034700377503975030750000003075030740307303072030710307102d7503075032750377503774037730357503775035750347503375034750347403473034720
001e0000180401004009040100401804007040070401804005040050400c04015040150400c04002040020400904011040110400904004040040400b04013040130400b040090401004013040190401904010040
011e0000000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c023000000c0230c0230c0000c0230c023000000c0230c023000000c023
901e00003075030740307302d7502f75030755307503074030730337503275030750327503175032750327403273032720327103271032710327103271000000000002b1002b1202d1202d120301203212032110
011e0000020400204009040110401104009040050400c04011040140401404005040070400c0400e04018030180300e04017030170301702017020170201702000040070400c0401c0201c0201c0200204009040
011e00000c0230c6000c0230c0230c0000c0230c0231a8000c0230c0231a8000c0230c023008000c0230c0230c8000c0230c023248000c0230c0231c8000c0230c0230c0000c0230c023000000c0230c02300000
011e00001300000000000000000000000000000000000000000000000000000000000000000000000001303013030070401303013030130201302013020130200000000000000001802018020180200000000000
901e0000341203012030120321203712032120341203412034120341103411034110341103411034110341003412034120341203212033120341203811038110381103b1103b1103b11039110341203312034120
011e00000e0401d0201d0201d020040400b040100401f0201f0201f02002040090400e0401d0201c0201a020040400b040100401f0201f0200b04004040080400e04020020230201404015040100402402017040
011e0000000001a0201a0201a0200000000000000001c0201c0201c0200000009000000001a02017020150200000000000000001c0201c020000000000000000000001c0201c0200000009040000002102007040
901e000034120341203411034110341103411034110371203912030120000002f12030120301203012030110000002d1202f12032120371103711037110351103711035110341103411034110391103411032110
001e0000170300e040180300c0401504024020240201a040050400c04011040210202102018030050400b040130401d0201f02017040070400e040110401a0301a0201a0201c0301c0201c020210302102021020
011e000007040000000604000000000001502015020110400000000000000001d0201d020000000000000000000001a0201a020000000000000000000001703017020170201803018020180201e0301e0201e020
901e000030120301202b1202d1202f120301253012030120301103312032120301253012030120301103011030110301103011030110301100010000100001000010000100001000010000100001000010000100
011e0000050400c04011040210201f0201d0201c0201a030180301404013040140401f0101f0101f0101d0101d0101f0101d0101d0101d0101c0101c0101c0150000000000000000000000000000000000000000
001e00000c0230c6000c0230c0230c0000c0230c0231a8000c0230c0231a8000c0230c023008000c0230c0230c8000c0230c023248000c0230c0231c8000c0230c0230c0000c0230c000000000c0230c0230c023
011e00000000000000000001d0200000000000000000000000000050400c0401104000020000200002011010110100e0100001000010000100000000000000000000000000000000000000000000000000000000
492000001f0001f055280552b0552905500000280550000026055000002505526040260302602026010260000000024055210551f055230552405526055000002804028030280202801028012280120000000000
012000000c0550c0051305513005070550c00513055130050e055000051505500005090550000515055000001105500000180550000013055000001a055000000c05500000130550000007055000001305500000
492000001f0001f055280552b0552905500000280550000026055000002505526040260302602026010260000000024055210551f055230552405526055000002404024030240202401024012240120000000000
012000000c0550c0051305513005070550c00513055130050e05500005150550000509055000051505500000180301802018010000001a0301a0201a01000000180550000013055000000c0400c0300c0200c000
012000000000000000000000000000000000000000000000000000000000000000000000000000000000000015030150201501000000170301702017010000000000000000000000000000000000000000000000
49280000247401f740247402b7402b7302974029730287402674023740237301f7401f7301f720247001f740237401f74023740287402873026740267302374024740287402873024740247301f740007001f740
012800000c0300c0200c0150c0300c0200c0100c0150c0000703007020070150703007020070100701507000070300702007015070300702007010070150c0000c0300c0200c0150c0300c0200c0100c01507000
9128000018605000050c6350000500005000050c6350000500005000050c6350000500005000050c6350000500005000050c6350000500005000050c6350000500005000050c6350000500005000050c63500005
49280000247401f740247402b7402b7302974029730287402674023740237301f7401f7301f720247001f740237401f74023740287402873026740267302374523740247402473524740247301f7402474028740
__music__
01 0102034d
00 04050044
00 06070844
00 090a0b0c
00 0d0e000f
00 10110812
02 13141516
01 17184344
02 191a1b44
01 1c1d1e44
02 1f1d1e44

