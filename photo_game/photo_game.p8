pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- init func --
function _init()
	circles = {}
	spawn_timer = 30
	spawn_delay = 120
end


-- update func --
function _update()
	spawn_timer += 1
	if spawn_timer > spawn_delay then
		spawn_timer = rnd(61)
		spawn_circle()
	end
	
	for circle in all(circles) do
		circle.x += circle.dx
		circle.y += circle.dy
		
		if circle.x > 128 or circle.y > 128 or circle.x < 0 or circle.y < 0 then
			del(circles, circle)
		end
	end
end


-- draw func ---
function _draw()
 cls()
 
 circfill(64, 64, 5, 10) -- sun
 
 for circle in all(circles) do
 	circfill(circle.x, circle.y, circle.radius, circle.clr)
	end
end

-->8
-- adds randomized circle to table of circles
function spawn_circle()

	local x, y = choose_spawn()

	-- 1/3 passes over sun
	local target_x, target_y
	if rnd(3) < 1 then
		target_x, target_y = 64, 64
	else
		target_x = 64 + (rnd(64) - 32)
		target_y = 64 + (rnd(64) - 32)
	end
	
	local dx, dy = target_x - x, target_y - y
	local dist = sqrt(dx^2 + dy^2)
	
	--	normalize velocity
	dx /= dist
	dy /= dist
	
	-- randomized speed factor -> [2, 4]
	local speed_factor = (2 + rnd(2))
	
	local circle = {
		x = x,
		y = y,
		radius = 5,
		dx = dx * speed_factor,
		dy = dy * speed_factor,
		clr = 6
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

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
