require("TSLib")
mSleep(1000)
init(1)
mSleep(1000)

w,h = getScreenSize();--此段代码仅供演示用，不可复制粘贴直接运行
MyJsonString = [[
{
  "style": "default",
  "width": ]]..w..[[,
  "height": ]]..h..[[,
  "config": "save_111.dat",
  "timer": 15,
  "views": [
    {
      "type": "Label",
      "text": "设置",
      "size": 25,
      "align": "center",
      "color": "0,0,255"
    },
    {
      "type": "Edit",
      "prompt": "输入服务器对应的数字",
      "text": "1",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    },   
  ]
}
]]
ret, input1 = showUI(MyJsonString);

--nLog(ret)
--nLog(input1)
local fuwuqi
if ret == 1 then
	fuwuqi = input1	
end
nLog(fuwuqi)

tab_right = {
	{  415,  150, 0x452e20},
	{  655,  150, 0x452e20},
	{  895,  150, 0x452e20},
	{  415,  225, 0x452e20},
	{  655,  225, 0x452e20},
	{  895,  225, 0x452e20},
	{  415,  305, 0x452e20},
	{  655,  305, 0x452e20},
	{  895,  305, 0x452e20},
	{  415,  395, 0x452e20},
}

tab_left ={
	{  205,  210, 0xdbb27c},
	{  205,  280, 0x493b31},
	{  205,  350, 0x453a2f},
	{  205,  420, 0x4b3f32},
	{  205,  490, 0x463a30},
	{  205,  560, 0x493b31},
}

---
-- @function: 打印table的内容，递归
-- @param: tbl 要打印的table
-- @param: level 递归的层数，默认不用传值进来
-- @param: filteDefault 是否过滤打印构造函数，默认为是
-- @return: return

--PrintTable(tab_10)

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end
--print_r(x)
--print_r(tab_10)

--local fuwuqi = 21

local idx_left = math.ceil(fuwuqi/10)
print(idx_left)

local idx_right = fuwuqi%10
if idx_right == 0 then
	idx_right = 10
end
print(idx_right)

print_r(tab_left[idx_left])

print_r(tab_left[idx_left][1])

if tonumber(fuwuqi) > 50 then
	moveTo(205,  560,205,  490)
	mSleep(2000)
end

local x1,y1 = tab_left[idx_left][1],tab_left[idx_left][2]
if multiColor({
	{  165,  197, 0x765122},
	{  186,  214, 0x63431c},
	{  191,  208, 0xd7ae78},
	{  219,  208, 0xe9c089},
	{  240,  211, 0xd5ae7a},
	{  209,  207, 0x835924},
}) or ({
	{  164,  198, 0x493f2f},
	{  182,  208, 0xceac7d},
	{  243,  208, 0xae916c},
	{  221,  209, 0xcdab7e},
	{  210,  209, 0x4a3e31},
}) then
	y1 = y1 + 70
end

tap(x1,y1)

mSleep(2000)


print_r(tab_right[idx_right])

tap(tab_right[idx_right][1],tab_right[idx_right][2])
