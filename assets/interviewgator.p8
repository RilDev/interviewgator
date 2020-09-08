pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--game loops
function _init()
	--configuration
	cam={x=0,y=0}        --camera options
	cam_speed=5
	is_beep_played=false --false: play beep
end

function _update()
	scroll()
end

function _draw()
	cls()	              --reset
	log_offset=2        
	log_count=0
	success_count=0
	camera(cam.x,cam.y) --move camera
	
	--add functions bellow this comment
	--[[
	info("test")
	test(2,4)
	test(2,8)
	
	info("test2")
	test2(1,2,3)
	test2(1,2,4)
	--]]
	
	--add functions above this comment
	print_success_count(success_count,log_count)
 beep(success_count==log_count)
end
-->8
--workspace

--[[
function test(input,expected)
	local result=expected
	log(input,expected,result)
end

function test2(a,b,expected)
	local result=a+b
	log({a,b},expected,result)
end
--]]
-->8
--utils

-- converts anything to string, even nested tables
function tostring(any)
  if (type(any)~="table") return tostr(any)
  local str = "{"
  for k,v in pairs(any) do
    if (str~="{") str=str..","
    str=str..tostring(k).."="..tostring(v)
  end
  return str.."}"
end
-->8
--game functions

--log results on the screen
function log(input,expected,result)
	--is success?
	local result_color=8  --red
	if result==expected then 
		result_color=11      --green
		success_count+=1
	end
	log_count+=1
	
	--number of line in the log
	local line_count=3
	
	print("input: "..tostring(input),10,log_offset,7)
	print("expected: "..tostring(expected),10,7+log_offset,7)
	print("result: "..tostring(result),10,14+log_offset,result_color)
	
	--update log_offset
	log_offset+=8*line_count
end

--log info
function info(text)
	--number of line in the log
	local line_count=1
	
	print(text,10,2+(log_offset),5)
		
	--update log_offset
	log_offset+=8*line_count
end

--log print_success_count
function print_success_count(success_count,log_count)
	--define color
	local print_color=11
	if (success_count<log_count) print_color=8
	--format success_count before display
	local print_success_count=success_count
	if (print_success_count<10) print_success_count=" "..print_success_count
	
	print(print_success_count.."/"..log_count,cam.x+105,cam.y+120,print_color)
end

--move the camera
function scroll()
	--navigate ⬆️⬇️⬅️➡️ the logs
	if (btn(0) and cam.x>0) cam.x-=cam_speed
	if (btn(1)) cam.x+=cam_speed
	if (btn(2) and cam.y>0) cam.y-=cam_speed
	if (btn(3)) cam.y+=cam_speed
	
	--reset scroll with ❎ (z)
	if (btn(4)) cam.x=0 cam.y=0
end

--sound effect
function beep(success)
	if not is_beep_played then
		if success then
			sfx(1)
		else
			sfx(0)
		end
	end
	
	is_beep_played=true
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000b000005050040000505005050050501500016000180001a0001b000160001e0000f000200000a00008000070002400027000260002a000350001e0001e0001a00018000180000000000000000000000000000
001000002605029050290500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
