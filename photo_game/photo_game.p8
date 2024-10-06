pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- init func --
function _init()
	reset_game()
end

function reset_game()
	state = "before"
	
	ibefore()
	isnap()
	iafter()
end

-- update func --
function _update()
	if state == "before" then
		ubefore()
	elseif state == "snap" then
		usnap()
	elseif state == "after" then
		uafter()
	end
end


-- draw func ---
function _draw()
 cls()
 
 draw_entities()
 
 if state == "before" then
 	dbefore()
 elseif state == "snap" then
 	dsnap()
 elseif state == "after" then
 	dafter()
 end
end

-->8
-- draw entities
function draw_entities()
	draw_particles(stars)
	draw_particles(flares)
	circfill(64, 64, main_radius, 10) -- main star
 
 for circle in all(circles) do
 	circfill(circle.x, circle.y, circle.radius, circle.clr)
	end
end

--------------------------------

-- adds randomized circle to table of circles
function spawn_circle()

	local x, y = choose_spawn()

	-- 1/3 passes over sun
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
	
	local clr_list = {7, 9, 12}
	
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
  add(stars, {
  	x=rnd(128+64),
   y=rnd(128),
   dx=rnd(0.5)+0.5,
   dy=rnd(2)-1,
   radius=0,
   timer=20,
   clr=7})
 end
   
 for p in all(stars) do
  p.x -= p.dx
  p.timer -= 1
 	if (p.timer < 0) del(stars, p)
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
function ibefore()
	circles = {}
	stars = {}
	flares = {}
	spawn_timer = 15
	spawn_delay = 120
	main_radius = 10
	expanding = true
	pulsate_speed = 0.0125
end


function ubefore()
	create_stars()
	create_flares()
	
	if expanding then
		main_radius += pulsate_speed
		if (main_radius >= 11) expanding=false
	else
		main_radius -= pulsate_speed
		if (main_radius <= 9) expanding=true
	end

	if (btnp(❎)) state="snap"

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


function dbefore()
end
-->8
function isnap()
	shutter_radius = 1
	speed = 6
	is_closing = true
end

function usnap()
	if is_closing then
		shutter_radius += speed
		if (shutter_radius >= 65) is_closing=false
		
	else
		shutter_radius -= speed
		if (shutter_radius <= 1) state="after"
	end
end

function dsnap()

	local clr = 7
	rectfill(-1, -1, 128, shutter_radius, clr)
	rectfill(-1, 128, 128, 128 - shutter_radius, clr)
	rectfill(-1, -1, shutter_radius, 128, clr)
	rectfill(128, -1, 128 - shutter_radius, 128, clr)
end
-->8
function iafter()
	counter = -30
	show_banner = false
	show_message = false
	covered = false
end

--------------------------------
function uafter()
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
function dafter()
	
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
			if (btnp(❎)) state="---" -- todo
		else
			print(message, 50, 64, clr) 
			rectfill(34, 76, 96, 84, 0)
			print("❎ to try again", 36, 78, 6)
			if (btnp(❎)) reset_game()
		end
	end
	
	
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
