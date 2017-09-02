DEBUG_MODE =false
TOUCH_MODE= true
XXT_MODE =false
XXT_DAQU = 1

if TOUCH_MODE == true then
	require("TSLib")
end

local sleep_cnt = 1
local renwu_flag = 1

local level = 1
--local jineng_flag ='N'
local tianlei_flag = 'N'
local yaoshui_shezhi = 'N' --暂时不进行药水的设置
local fuli_flag = 'N'
local in_game = 'N'
local kuangqu_flag = 'N'
--local dialog_flag = 'N'
local buy_3_first = false

local choose_flag = false

local open_app
local front_app
local mmsleep
local init_screen
local init_log
local wt_log,wx_log
local log_file = "chuanqishijie"
local multi_col
--local press
local before_game = 'Y'
--local beibao_flag = 'N'
--local bag_is_full = false
local main_task = true
local mail_get =false
local bag_clean = false
local bag_full = false  
--local luoxia_shua_guai = false
local jiaoyi_flag ='N'
local only_once1 = true
local first_mail = false
local bag_is_ready = false
--local flag1 = true

local tab_cangku = {
	{  684,  180, 0x7c8a98},
	{  777,  179, 0x251007},
	{  872,  179, 0x251007},
	{  965,  178, 0x251007},
	{  682,  275, 0x251007},
	{  777,  276, 0x251007},
	{  874,  276, 0x251007},
	{  970,  275, 0x251007},
	{  683,  367, 0x251007},
	{  778,  366, 0x251007},
	{  872,  368, 0x251007},
	{  966,  368, 0x251007},
	{  680,  464, 0x251007},
	{  779,  463, 0x251007},
	{  873,  462, 0x251007},
	{  968,  461, 0x251007},
	{  681,  203, 0x251007},
	{  778,  203, 0x251007},
	{  869,  202, 0x251007},
	{  969,  201, 0x251007},
	{  681,  295, 0x251007},
	{  782,  298, 0x251007},
	{  871,  298, 0x251007},
	{  965,  297, 0x251007},
	{  680,  395, 0x251007},
	{  777,  392, 0x251007},
	{  871,  392, 0x251007},
	{  966,  393, 0x251007},
	{  681,  487, 0x251007},
	{  778,  487, 0x251007},
}

local tab_yaopin={
	{  675,  155, 0xbb6674},
	{  772,  157, 0xb34b5a},
	{  863,  156, 0x383030},
	{  960,  156, 0x524141},
}

local tab_qita = {
	{  294,  154, 0x8754ba},
	{  386,  154, 0xff4459},
}


local tab_line = {
	{  329,  202, 0x68351b},
	{  440,  203, 0xc3976a},
	{  329,  260, 0x724024},
	{  444,  260, 0x643219},
	{  332,  317, 0x7e4f30},
	{  445,  316, 0x613118},
	{  330,  373, 0x653319},
	{  441,  373, 0x996844},
	{  328,  428, 0xf3c992},
	{  443,  428, 0x763c1d},
}

function trim1(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.split(input, delimiter)
	print("string.split(input, delimiter)")
	input = tostring(input)
	delimiter = tostring(delimiter)
	if (delimiter=='') then return false end
	local pos,arr = 0, {}
	-- for each divider found
	for st,sp in function() return string.find(input, delimiter, pos, true) end do
		table.insert(arr, string.sub(input, pos, st - 1))
		pos = sp + 1
	end
	table.insert(arr, string.sub(input, pos))
	return arr
end

local function split(str, d) --str是需要查分的对象 d是分界符
	print("local function split(str, d) ")
	local lst = { }
	local n = string.len(str)--长度
	local start = 1
	while start <= n do
		local i = string.find(str, d, start) -- find 'next' 0
		if i == nil then 
			table.insert(lst, string.sub(str, start, n))
			break 
		end
		table.insert(lst, string.sub(str, start, i-1))
		if i == n then
			table.insert(lst, "")
			break
		end
		start = i + 1
	end
	return lst
end

function get_cangku_position(j)
	local ret,x,y
	for i,v in ipairs(tab_cangku) do
		if i == j then
			ret = true
			x = v[1]		y = v[2]
			print(i,x,y)
			break		
		end
	end
	return ret,x,y
	-- body
end


function get_yappin_position(j)
	local ret,x,y
	for i,v in ipairs(tab_yaopin) do
		if i == j then
			ret = true
			x = v[1]		y = v[2]
			print(i,x,y)
			break		
		end
	end
	return ret,x,y
	-- body
end


function get_qita_position(j)
	local ret,x,y
	for i,v in ipairs(tab_qita) do
		if i == j then
			ret = true
			x = v[1]		y = v[2]
			print(i,x,y)
			break		
		end
	end
	return ret,x,y
	-- body
end


function get_line_xy(j)
	local ret,x,y
	for i,v in ipairs(tab_line) do
		if i == j then
			ret = true
			x = v[1]		y = v[2]
			--print(i,x,y)
			--wwlog("199x:"..x.."xxx")
			break		
		end
	end
	--wwlog("203j:"..j.."jjj")
	return ret,x,y
	-- body
end


if TOUCH_MODE == true then
	open_app= runApp
	front_app = frontAppBid
	mmsleep = mSleep
	init_screen = init
	init_log = initLog
	wt_log= wLog
	close_log = closeLog
	multi_col = multiColor
	ltap = tap
elseif XXT_MODE ==true then
	open_app= app.run
	front_app = app.front_bid
	mmsleep = sys.msleep
	init_screen = screen.init
	wx_log= sys.log
	multi_col = screen.is_colors
	ltap = touch.tap	
end

if TOUCH_MODE == true then
	init_log(log_file, 1)
end	

function wwlog(msg)
	if TOUCH_MODE == true then		
		wt_log(log_file,msg)
	elseif XXT_MODE == true then
		wx_log(msg)
	end	
	nLog(msg)
end

init_screen(1)
--app.front_bid() ~= "com.tencent.smoba" then	

mmsleep(200)

function showuii(json_str)
	local ret, input1,input2,input3
	if TOUCH_MODE == true then		
		ret, input1,input2,input3 =  showUI(json_str)
	elseif XXT_MODE == true then
		ret, input1,input2,input3 = 1, XXT_DAQU,"555 555",5
	end	
	return  ret, input1,input2,input3
end 

function run_app_first(...)

	if front_app() == "com.tencent.xin" then
		wwlog("74 微信程序ing...")
	elseif  front_app() ~= "com.tencent.cqsj" then
		mmsleep(200)
		open_app("com.tencent.cqsj")
		wwlog("game start")
		mmsleep(7000)
		ltap( 565,  332) --点击跳过动画
		wwlog("93 --点击跳过动画")
		mmsleep(2000)
		before_game = 'Y'
	end
end

function run_app(...)

	if front_app() == "com.tencent.xin" then
		wwlog("74 微信程序ing...")
	elseif  front_app() ~= "com.tencent.cqsj" then
		mmsleep(30000)
		open_app("com.tencent.cqsj")
		wwlog("game start")
		mmsleep(2000)
		--before_game = 'Y'
		while true do
			if login() then
				break
			end
		end
		mmsleep(1000)
	end
end
local jy_x
local jy_y
local line = 4
function check_right_corder(...)
	local ret = false
	mmsleep(500)
	local ret = false
	wwlog("2490 检查右上角 ，判定角色是否移动")
	x, y = findImageInRegionFuzzy("right_corner.png", 90,  1011,   26,  1129,   64,0,2);
	if x ~= -1 and y ~= -1 then        --如果在指定区域找到某图片符合条件
		--ltap( 87,  197) 
		ret = true
		wwlog("1639 点击左侧任务栏，让角色动起来 ")   
	else                               --如果找不到符合条件的图片
		wwlog("1641 任务-跑腿中")   
	end
	return ret
	-- body
end

function choose_fuwuqi(...)

	w,h = getScreenSize();--此段代码仅供演示用，不可复制粘贴直接运行
	MyJsonString = [[
{
  "style": "default",
  "width": ]]..w..[[,
  "height": ]]..h..[[,
  "config": "save_111.dat",
  "timer": 20,
  "views": [
    {
      "type": "Label",
      "text": "设置",
      "size": 30,
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
	{
      "type": "Edit",
      "prompt": "输入落霞岛右上角小地图中的合法坐标，需要自己来截图，用空格来分割",
      "text": "367 440",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    },  
	{
      "type": "Edit",
      "prompt": "输入线路 1-10",
      "text": "5",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    },   
  ]
}
]]
	ret, input1,input2,input3 = showuii(MyJsonString);
	local fuwuqi
	local zuobiao 
	--local line
	if ret == 1 then
		fuwuqi = input1	
		zuobiao = input2
		line = input3
	end
	wwlog(fuwuqi)
	wwlog("363 交易坐标:"..zuobiao)	
	wwlog("364 所选线路:"..line)
	--local ret, x_line,y_line = get_line_xy(tonumber( line))
	--wwlog("369x_line:"..x_line.."x_line")
	local zuobiao1 =string.gsub(trim1(zuobiao), " ", "," ) 
--local tab_zuobiao = split(zuobiao1,',')
--print( tab_zuobiao[1],tab_zuobiao[2])
	local tab_zuobiao2 = string.split(zuobiao1,',')
	nLog( tab_zuobiao2[1].." "..tab_zuobiao2[2])	

	jy_x = trim1(tab_zuobiao2[1])
	jy_y = trim1(tab_zuobiao2[2])

	--ltap(jy_x,jy_y)
	nLog( jy_x.." "..jy_y)	

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

	local idx_left = math.ceil(fuwuqi/10)
	local idx_right = fuwuqi%10
	if idx_right == 0 then
		idx_right = 10
	end

	if tonumber(fuwuqi) > 50 then
		moveTo(205,  560,205,  490)
		mmsleep(2000)
		ltap(  205,  563) --点击左侧最下边的区域
	end

	local x1,y1 = tab_left[idx_left][1],tab_left[idx_left][2]
	if multi_col({
			{  208,  152, 0x65441e},
			{  206,  205, 0xe6c08c},
			{  206,  209, 0xe5bf8c},
			{  212,  211, 0xe7c18d},
			{  223,  204, 0xe6c08c},
			{  223,  214, 0xe5bf8c},
			{  224,  210, 0x483b31},
			})then 
		wwlog("167 此微信号第一次登陆此游戏，")
	else
		if multi_col({
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
	end

	tap(x1,y1)	

	mmsleep(2000)

	tap(tab_right[idx_right][1],tab_right[idx_right][2])

	mmsleep(2000)
	return fuwuqi
	-- body
end


function check_zhuangbei_hongbao(...)
	local ret = false
	wwlog("214 看是否有红包和可以穿的装备")
	mmsleep(500)
	if multi_col({
			{  982,  257, 0xde9f26},
			{ 1001,  238, 0xac282a},
			{ 1019,  255, 0xde9f26},
			{  998,  282, 0xde9f26},
			{ 1000,  302, 0x9f2123},
			})then
		ltap(998,  282)
		wwlog("224 打开红包")
		ret = true
	elseif multi_col({
			{  507,  198, 0x291d19},
			{  546,  202, 0x604c3f},
			{  627,  411, 0x6a341a},
			{  638,  414, 0xd0a273},
			{  669,  416, 0xd5ab7b},
			{  692,  418, 0xf3ca93},
			{  744,  200, 0xe5c87f},
			}) then
		ltap(744,  200)
		wwlog("关闭战斗日志")
		ret = true
	elseif multi_col({
			{  952,  158, 0xad8a50},
			{  961,  154, 0x9b6d37},
			{  967,  154, 0xffbb10},
			{  956,  155, 0xf8c16f},
			{  955,  166, 0xff0600},
			{  960,  161, 0xf72b03},
			}) then
		ltap(960,  161)
		wwlog("关闭活动窗口")
		ret = true
	elseif multi_col({
			{ 1035,  192, 0xdbaf6e},
			{  870,  243, 0x34100d},
			{  988,  254, 0x2f0e0d},
			{  993,  203, 0x572120},
			{  881,  203, 0x562120},
			}) then
		ltap(933,  400)
		wwlog("233 立即装备")
		ret = true
	elseif multi_col({
			{  676,  480, 0x007aff},
			{  665,  506, 0x007aff},
			{  663,  502, 0xe4e4e4},
			{  671,  438, 0x007aff},
			{  667,  403, 0x007aff},
			})then
		ltap(667,  403)
		wwlog("305 不在提示")
		ret = true
	elseif multi_col({
			{  510,  203, 0x3c2e27},
			{  626,  202, 0x362720},
			{  558,  204, 0xebc48f},
			{  644,  413, 0x71371f},
			{  673,  419, 0xefc58f},
			}) then
		ltap(673,  419)
		wwlog("466 断线点击确定")
	elseif multi_col({
			{  522,   65, 0x751c15},
			{  521,   73, 0x531010},
			{  531,   65, 0xf0c58f},
			{  561,   69, 0xf0c590},
			{  606,   64, 0xe1ad7e},
			}) then
		ltap(606,   64)
		wwlog("245 跳过引导")
		ret = true
	end	
	-- body
	return ret
end

function check_hongbao(...)
	local ret = false
	wwlog("214 看是否有红包和元宝商城")
	mmsleep(500)
	if multi_col({
			{  982,  257, 0xde9f26},
			{ 1001,  238, 0xac282a},
			{ 1019,  255, 0xde9f26},
			{  998,  282, 0xde9f26},
			{ 1000,  302, 0x9f2123},
			})then
		ltap(998,  282)
		wwlog("458 打开红包")
		ret = true

	elseif multi_col({
			{ 1035,  192, 0xdbaf6e},
			{  870,  243, 0x34100d},
			{  988,  254, 0x2f0e0d},
			{  993,  203, 0x572120},
			{  881,  203, 0x562120},
			}) then
		ltap(933,  400)
		wwlog("469 立即装备")
		ret = true
	elseif multi_col({
			{  676,  480, 0x007aff},
			{  665,  506, 0x007aff},
			{  663,  502, 0xe4e4e4},
			{  671,  438, 0x007aff},
			{  667,  403, 0x007aff},
			})then
		ltap(667,  403)
		wwlog("479 不在提示")
		ret = true
		--[[
	elseif multi_col({
			{  510,  203, 0x3c2e27},
			{  626,  202, 0x362720},
			{  558,  204, 0xebc48f},
			{  644,  413, 0x71371f},
			{  673,  419, 0xefc58f},
			}) then
		ltap(673,  419)
		wwlog("466 断线点击确定")
	--]]	

	end	
	-- body
	return ret
end

function  get_tianlei_flag(...)
	local ret = 'N'
	mmsleep(200)
	if multi_col({
			{  921,  572, 0x2d476a},
			{  933,  573, 0xc9d0f9},
			{  932,  586, 0xdcdcfc},
			{  920,  594, 0x3b86cd},
			})then
		ret = 'Y'
	elseif multi_col({
			{  927,  569, 0xc2d2fa},
			{  928,  579, 0xfffef5},
			{  930,  606, 0xfcf34a},
			}) then
		ret = 'Y'
	elseif multi_col({
			{  364,  114, 0x48150c},
			{  384,  120, 0xf4e472},
			{  412,  113, 0xf1e172},
			{  425,  125, 0x330e0c},
			{  433,  118, 0xfdef78},
			}) then
		ret = 'Y'
	elseif multi_col({
			{ 1039,   31, 0xf3c892},
			{ 1048,   32, 0xe2b184},
			{ 1062,   30, 0xf6cd95},
			{ 1062,   37, 0xdeac7f},
			{ 1059,   37, 0x883433},
			}) then
		ret = 'Y'
	elseif multi_col({
			{ 1004,   57, 0xebca77},
			{ 1018,   57, 0xf6d67f},
			{ 1006,   63, 0x591617},
			{ 1010,   63, 0xc69c63},
			}) then
		ret = 'Y'
	end

	return ret
end

function  getcurlevel(...)
	local ret =1
	if multi_col({
			{   15,   73, 0x958a8a},
			{   18,   74, 0xe6c192},
			{   20,   82, 0xcda276},
			{   13,   80, 0xc99f76},
			{   15,   82, 0xeac08c},
			{   18,   76, 0xd6b287},
			{   18,   83, 0xdaae7f},
			{   16,   84, 0x430302},
			})then
		ret = 4
		wwlog("228 4级")
	elseif multi_col({
			{   14,   75, 0xe1bc8e},
			{   15,   74, 0xe0bc90},
			{   17,   74, 0xd6b58d},
			{   17,   78, 0xc9a37b},
			{   17,   80, 0xc59b73},
			{   17,   85, 0xc4936b},
			{   11,   79, 0x4d2a2a},
			})then
		ret = 1
		wwlog("239 1级")
	end
	return ret
	-- body
end

function resethome(...)
	if multi_col({
			{  961,  567, 0xca9663},
			{  979,  572, 0xb98552},
			{  967,  578, 0x333322},
			{  970,  580, 0x332722},
			{  631,  585, 0xf6ec9e},
			}) then
		ltap(562,  577)
		wwlog("581 点击红篮球，复位底部任务栏")
	end
	mmsleep(2000)

	if multi_col({
			{ 1008,   17, 0xcc3422},
			{ 1007,   26, 0xda1100},
			{  994,   32, 0xeedf88},
			{  989,   39, 0xfff999},
			{  994,   50, 0x794927},
			}) then
		ltap(994,   50)
		wwlog("593 复位顶部活动栏")
		-- body
	end
end

function is_in_game(...)
	local ret = 'N'
	if multi_col({
			{   30,  123, 0x992222},
			{   40,  133, 0xaa2223},
			{   41,  132, 0x6d2424},
			{   52,  128, 0xdf5248},
			{   65,  136, 0xb63232},
			}) then
		ret = 'Y'
		wwlog("650 is in game")
	end
	return  ret
	-- body
end


function check_bag2(...)
	wwlog("645 检测背包是否已满，打开背包是否等于76")
	local ret =  false
	for i = 1 , 1, 1 do 
		mmsleep(1000)
		if multi_col({
				{  511,  576, 0xfaf8a0},
				{  511,  597, 0xa77443},
				{  625,  577, 0xefe588},
				{  624,  595, 0x7f5934},
				}) then
			ltap(  564,  579) --点击红篮球
			mmsleep(2000)
			ltap(338,  575 ) --点击背包
			wwlog("1498 点击红篮球 准备点击背包")	
		elseif multi_col({
				{  322,  564, 0x553333},
				{  362,  568, 0x443333},
				{  332,  604, 0xf8f6ec},
				{  359,  604, 0xe8e7de},
				}) then
			ltap(314,  595)
			wwlog("670 点击背包")
		end		

		mmsleep(3000)

		if multi_col({
				{  954,  574, 0xcfccca},
				{  950,  574, 0x716762},
				{  949,  577, 0xe7e6e5},
				{  949,  580, 0xd0cecd},
				{  956,  583, 0xe7e7e7},
				{  948,  582, 0xdedddc},
				{  949,  584, 0xc0bebc},
				{  937,  574, 0xe6e5e4},
				{  943,  574, 0xe6e5e4},
				{  939,  587, 0xe4e4e4},
				}) then
			ret = true
			ltap(1010,   64) --关闭背包
			wwlog("1126 背包已满")
			break
		end
		mmsleep(100)
		ltap(1010,   64)
	end
	return ret
end

function safe_place(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0x65f663, "-2|5|0x5cd457,3|5|0x65e95f,-4|11|0x61ec60", 90, 0, 0, 1135, 639)
	if x~= -1 and y ~= -1 then
		mmsleep(100)
		if multi_col({
				{ 1102,  304, 0xbc9977},
				{ 1107,  316, 0xd3c2a7},
				{ 1089,  304, 0xab8d6c},
				{ 1085,  314, 0xe2d0bf},
				{ 1095,  297, 0xf8f7f0},
				}) then
			ltap(1085,  314)
			wwlog("780 停止攻击，现在是安全的")
		end 
	end
	-- body
end

function fenjie_1(...)		
	wwlog("1333 分解装备 ")	
	mmsleep(1000)

	if multi_col({
			{  510,  575, 0xfff798},
			{  510,  578, 0xf9e28e},
			{  508,  582, 0xedcd7a},
			{  625,  575, 0xfff599},
			{  628,  582, 0xebd17d},
			})then
		ltap(565,  576)
		wwlog("1461 点击红篮球，展开底部按钮栏")
	end			
	mmsleep(2000)
	ltap(  341,  579) --点击背包
	mmsleep(500)
	ltap(473,  510) --点击分解
	mmsleep(1000)
	if multi_col({
			{  520,  391, 0x604d31},
			{  510,  402, 0x130b07},
			{  504,  408, 0x100906},
			{  498,  400, 0x130b07},
			})then 
		ltap(506,  401)	 --勾选白色装备
	end	
	mmsleep(1000)
	if multi_col({
			{  682,  392, 0x56442c},
			{  666,  408, 0x100906},
			{  660,  398, 0x130b07},
			}) then	
		ltap(667,  397)	 --勾选绿色装备
	end		
	mmsleep(1000)
	if multi_col({
			{  844,  391, 0x403220},
			{  828,  408, 0x100906},
			{  822,  399, 0x130b07},
			}) then
		ltap(830,  399)	 --勾选蓝色装备
	end	
	mmsleep(200)
	ltap(865,  530) --开始分解
	mmsleep(3000)			
	ltap(953,   80) --点击关闭分解窗口
	mmsleep(1000)
	--ltap(928,  507) --点击背包的整理按钮----
	--mmsleep(1000)
	ltap(1010,65 ) --关闭背包对话框
	mmsleep(2000)
	-- body
end		

function change_line(...)
	mmsleep(1000)
	wwlog("757 换线")
	local cnt_1 = 0
	while (not multi_col({
				{  315,  123, 0xdfba87},
				{  289,  125, 0xf1c993},
				{  342,  126, 0xf1c992},
				{  365,  133, 0xc9a779},
				})) do
		-- body
		mmsleep(1000)
		if multi_col({
				{  212,   80, 0xb7ae98},
				{  212,   83, 0xb5ad98},
				{  212,   87, 0xb5ad98},
				{  237,   77, 0xc0b8a1},
				}) then
			ltap(212,   80)
			wwlog("847 点击换线")

		end
		mmsleep(500)
		cnt_1 =cnt_1 +1
		if cnt_1 >10 then
			ltap(212,   80) --点击换线
			wwlog("854 点击换线")
			break
		end
	end
	mmsleep(3000)
	local ret, x_line,y_line = get_line_xy(tonumber(line))
	--ltap(426,  130) --点击推荐线路
	ltap(x_line,y_line)
	--wwlog("787 点击推荐线路")
	wwlog("863 点击所选线路")
	mmsleep(200)
end

function login(...)
	local ret = false
	mmsleep(1000)
	wwlog("876 before login game")
	if multi_col({
			{  919,   75, 0x9d702a},
			{  922,   95, 0xdbb16a},
			{  923,  116, 0xfada80},
			{  891,   99, 0xa97144},
			{  886,   96, 0xae8050},
			{  882,   95, 0x4f1415},
			})then
		ltap(882,   95)
		wwlog("1286 点击公告")
	elseif multi_col({
			{  211,  516, 0x82d943},
			{  226,  524, 0xeff3f3},
			{  238,  514, 0x415f2b},
			{  282,  509, 0x43642c},
			{  298,  518, 0xdedfdc},
			}) then
		ltap(298,  518)
		wwlog("1295 点击微信")
		mmsleep(5000)
		--break

	elseif multi_col({
			{  874,  379, 0x04be02},
			{  876,  349, 0xfbfefb},
			{  876,  339, 0x04be02},
			{  879,  332, 0xf0fbf0},
			{  877,  302, 0xe9f9e9},
			{  878,  271, 0xffffff},
			{  892,  285, 0x04be02},
			})then
		ltap(892,  285)
		wwlog("1309 微信确认登陆")
		--[[
		elseif multi_col({
				{  676,  480, 0x007aff},
				{  665,  506, 0x007aff},
				{  663,  502, 0xe4e4e4},
				{  671,  438, 0x007aff},
				{  667,  403, 0x007aff},
				})then
			ltap(667,  403)
			wwlog("305 不在提示")
			]]--	
	elseif multi_col({
			{  390,  372, 0xd1daee},
			{  407,  371, 0x007aff},
			{  407,  381, 0x007aff},
			{  443,  369, 0x007aff},
			{  457,  380, 0x007aff},
			{  449,  374, 0xd5daec},
			})then
		ltap(449,  374)
		wwlog("1330 打开微信")
	elseif multi_col({
			{  664,  476, 0xf5c26a},
			{  684,  479, 0xf4b75e},
			{  703,  476, 0xd9c06d},
			{  721,  479, 0xbc8946},
			{  507,  550, 0x681912},
			{  549,  552, 0xe6be00},
			{  569,  549, 0xb28209},
			}) then
		if choose_flag == true then
			ltap(564,  557) --点击进入游戏				
			wwlog("1342 点击进入游戏")			
		else
			ltap(692,  480) --点击换服
			mmsleep(1000)
			v_choose = choose_fuwuqi()
			mmsleep(1000)
			if v_choose ~= nil then
				choose_flag = true
			end
			wwlog("1351 点击换服")
		end
	elseif multi_col({
			{  509,  201, 0x30231d},
			{  626,  201, 0x362720},
			{  637,  411, 0x6b341b},
			{  665,  416, 0xecc38e},
			}) then
		ltap(665,  416)
		wwlog("775 更新游戏")
	elseif multi_col({
			{  543,  409, 0x6a341a},
			{  547,  423, 0x5a2718},
			{  557,  419, 0xf2c892},
			{  581,  418, 0xf3ca93},
			{  570,  419, 0x582818},
			})then
		ltap(570,  419)
		wwlog("1361 角色名称重复 ,点击确定")
	elseif multi_col({
			{  698,  575, 0xce9c61},
			{  698,  586, 0xba703c},
			{  700,  578, 0x221108},
			{  706,  578, 0x231108},
			{  928,  576, 0x601213},
			}) then
		ltap(928,  576)
		before_game = 'N'
		wwlog("1371 直接点击开始游戏")
		--break
		ret = true
	elseif multi_col({
			{  677,  564, 0xba901e},
			{  694,  566, 0xc38a0d},
			{  685,  579, 0xaa7c00},
			{  865,  569, 0x6c1c13},
			{  929,  573, 0x561311},
			}) then
		mmsleep(200)
		local fashi_flag = 'N'
		if multi_col({
				{   80,  221, 0x2a1c0d},
				{   90,  227, 0xcaad7d},
				{   96,  243, 0xe4cb96},
				{   93,  288, 0xf3da9a},
				{   99,  286, 0x644d26},
				})then
			ltap(753,  343)
			wwlog("382 战士转法师")
			mmsleep(1000)
			fashi_flag = 'Y'
		elseif multi_col({
				{   80,  229, 0x90d072},
				{  101,  230, 0x85c75c},
				{   90,  278, 0xb0e481},
				{   90,  298, 0xadd887},
				})then
			ltap(378,  320)
			wwlog("382 道士转法师")
			mmsleep(1000)
			fashi_flag = 'Y'
		end
		mmsleep(200)
		if multi_col({
				{  115,  218, 0x9d5685},
				{   83,  232, 0xac6ca2},
				{   99,  284, 0xde9fce},
				}) or fashi_flag == 'Y' then
			ltap(677,  564) --点击色子
			mmsleep(1000)
			ltap(929,  573) --点击开始游戏
			wwlog("396 点击色子，更换名字，然后点击开始游戏，直到成功开始游戏")
		end
	elseif multi_col({
			{  910,  608, 0xfbfbfa},
			{  924,  611, 0xfdfdfd},
			{  941,  608, 0xfbfbfb},
			{  961,  610, 0xfdfdfd},
			{  989,  609, 0xfbfbfa},
			}) then
		ltap(989,  609)
		wwlog("1015 请点击继续")
		before_game = 'N'
	elseif multi_col({
			{  518,  175, 0x816856},
			{  539,  177, 0xeac38f},
			{  369,  438, 0x652f1b},
			{  416,  439, 0x67311c},
			})then
		ltap(416,  439)
		wwlog("1024 回城复活")			
	end	
	return ret
	-- body
end

run_app_first()


--local check_bag = 'N'
--启动游戏并进入游戏
-----------------------------------------------------------------------------------------
while (true) do 
	renwu_flag = renwu_flag +1
	mmsleep(500)
	resethome()
	mmsleep(500)
	--level =getcurlevel()
	mmsleep(500)
	in_game = is_in_game()
	mmsleep(500)

	--[[
	if tianlei_flag =='N' then
		tianlei_flag =get_tianlei_flag()
	end
	--]]

	if  in_game =='Y' then
		before_game = 'N'
	end 	

	if before_game =='N' then
		if check_bag2() then
			tianlei_flag ='Y'
			yaoshui_shezhi = 'Y'
			fuli_flag= 'Y'
			first_mail = true
			bag_is_ready = true

			bag_full = true
		end
	end

	mmsleep(200)

	while (before_game == 'Y') do
		if login() then
			break
		end
	end
	-----------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------
	mmsleep(2000)
	local v_cnt1 = 0
	while (not multi_col({
				{ 1039,   37, 0x66332e},
				{ 1053,   31, 0xf3c892},
				{ 1030,   51, 0x63d25b},
				}) ) do
		wwlog("1038 等待游戏主界面")
		mmsleep(1000)
		v_cnt1 = v_cnt1 +1

		if v_cnt1 >30 then
			-- body			
			break
		end	
	end


	function before_tianlei(...)
		-- body
	end    

	local run_cnt1 = 0
	while tianlei_flag =='N' do
		run_cnt1 = run_cnt1 +1
		wwlog("1054 配置完天雷技能之前的任务")	
		snapshot("right_corner.png", 1036,   29,  1125,   59)
		mmsleep(1000)
		if only_once1 ==true then
			mmsleep(5000)
			ltap(79,  196) --第一次点击任务
			wwlog("1060 第一次点击任务")
			only_once1 = false
		end
		mmsleep(1000)
		if multi_col({
				{  928,  249, 0x1b1f33},
				{  938,  261, 0x222251},
				{  933,  290, 0x538bda},
				{  934,  321, 0x5a76a6},
				{  915,  328, 0x6084bb},
				{  934,  308, 0x300e0d},
				})then
			ltap(932,  401) --点击天雷咒
			mmsleep(2000)
			if multi_col({
					{  510,  575, 0xfff798},
					{  510,  578, 0xf9e28e},
					{  508,  582, 0xedcd7a},
					{  625,  575, 0xfff599},
					{  628,  582, 0xebd17d},
					})then
				ltap(  564,  573) --点击红蓝球
			end
			mmsleep(3000)
			if multi_col({
					{  510,  575, 0xfff798},
					{  510,  578, 0xf9e28e},
					{  508,  582, 0xedcd7a},
					{  625,  575, 0xfff599},
					{  628,  582, 0xebd17d},
					})then
				ltap(  564,  573) --点击红蓝球
			end

			mmsleep(2000)
			ltap(  251,  575) --点击技能书图标
			mmsleep(2000)
			ltap(  1057,  297) --点击设置标签
			mmsleep(2000)
			ltap( 455,  212) --点击天雷咒技能
			mmsleep(2000)
			ltap( 722,  423) --点击第一个技能槽
			tianlei_flag = 'Y'
			mmsleep(2000)	
			ltap( 1012,   64) --技能设置--关闭
			mmsleep(1000)
			break
		elseif multi_col({
				{  398,  371, 0xbd56e2},
				{  398,  403, 0xb955df},
				{  398,  436, 0xba56e0},
				{  464,  370, 0xe068ec},
				{  761,  402, 0x362720},	
				})then
			ltap(839,  401)
			wwlog("340 完成任务2")
		elseif multi_col({
				{  498,  370, 0x68a5ec},
				{  566,  370, 0x5781c1},
				{  498,  438, 0x4a7ac3},
				{  498,  403, 0x588fe6},
				}) then
			ltap(832,  404)
			wwlog("395 完成任务")
		elseif multi_col({
				{  598,  370, 0xce6adb},
				{  598,  393, 0xb85fd8},
				{  598,  438, 0x9f53ba},
				{  664,  370, 0xdf68ec},	
				})then
			ltap(834,  403)
			wwlog("403 接受任务3")
		elseif multi_col({
				{  498,  370, 0xdc68ec},
				{  498,  402, 0xc15ae8},
				{  498,  436, 0xbe59e5},
				{  562,  370, 0xd768ec},	
				}) then
			ltap(835,  404)
			wwlog("412 接受任务2")
		elseif multi_col({
				{  426,  352, 0x130b07},
				{  438,  352, 0x130b07},
				{  425,  365, 0x130b07},
				{  672,  401, 0x783e1b},
				}) then
			ltap(672,  401)
			wwlog("1018 保持流畅模式")
		elseif multi_col({
				{  910,  608, 0xfbfbfa},
				{  924,  611, 0xfdfdfd},
				{  941,  608, 0xfbfbfb},
				{  961,  610, 0xfdfdfd},
				{  989,  609, 0xfbfbfa},
				}) then
			ltap(989,  609)
			wwlog("1147 请点击继续")			

		elseif multi_col({
				{  521,   58, 0x7f2314},
				{  547,   58, 0x7e2214},
				{  529,   71, 0xf6cd95},
				{  574,   71, 0xe8bc89},
				{  566,   71, 0x651414},
				})then
			ltap(566,   71) --跳过引导
			mmsleep(200)
			ltap(  932,  401) --点击天雷咒
			mmsleep(200)
			wwlog("309 跳过引导")
		elseif multi_col({
				{ 1035,  192, 0xdbaf6e},
				{  870,  243, 0x34100d},
				{  988,  254, 0x2f0e0d},
				{  993,  203, 0x572120},
				{  881,  203, 0x562120},
				}) then
			ltap(933,  400)
			wwlog("833 立即装备")
		elseif multi_col({
				{  848,  205, 0x4f1e1d},
				{  846,  234, 0x4c1d1c},
				{  846,  346, 0x4a1c1b},
				{ 1037,  184, 0x8a2121},
				{ 1035,  191, 0xd7bc7a},
				{ 1027,  198, 0xba733f},
				{ 1031,  272, 0x4a211c},
				{ 1013,  393, 0x461a19},
				})then
			ltap(938,  398)
			wwlog("1061 立即装备")
		elseif multi_col({
				{  475,  381, 0xc3bcb7},
				{  495,  382, 0xeadb6f},
				{  511,  372, 0xf2e473},
				{  532,  375, 0xebdc70},
				}) then
			wwlog("1068 第一次出现任务面板")
			ltap(123,  191)
		elseif multi_col({
				{   24,  190, 0xd5b381},
				{   24,  200, 0xd2b07f},
				{   33,  197, 0xb89b6f},
				{   94,  194, 0xf1f1f1},
				{   84,  193, 0xe2e2e1},
				})  then
			mmsleep(5000)
			ltap(83,  197)
			wwlog("1079 第一次点击任务面板--对话村长")
			mmsleep(5000)
			--flag1 = false			
		end	
		mmsleep(200)
		if run_cnt1%5 ==0 and check_right_corder() then			
			ltap(60,  195)
			wwlog("1205 别傻站着，点击左侧第一个任务")
		end		
		mmsleep(1000)
		run_app()
		mmsleep(1000)
		
	end

	resethome()
	function set_up_first(...)
		-- body
	end
	--设置，
	while (yaoshui_shezhi == 'N' ) do
		mmsleep(1000)
		wwlog("1112 初始设置")

		if check_zhuangbei_hongbao() then
			wwlog("1227 检测红包，跳过向导")
		elseif multi_col({
				{  962,  566, 0xcf9966},
				{  976,  569, 0xe19f65},
				{  976,  587, 0x8a4927},
				{  961,  588, 0xb06a38},
				{  968,  577, 0x333322},
				}) then
			ltap(968,  577)
			wwlog("1252 点击设置按钮")
			mmsleep(3000)
			ltap(1059,  526) --点击系统设置tab
			mmsleep(2000)
			local flag4 = false
			if multi_col({
					{  397,  225, 0x130b07},
					{  385,  234, 0x120a07},
					{  378,  226, 0x130b07},
					}) then 
				ltap(387,  222)  --点击流畅模式
				wwlog("1134 点击流畅模式")
				flag4 = true
			end	
			mmsleep(2000)

			if flag4 == true then
				moveTo(565,  541,565,  180,1)
				mmsleep(3000)

				ltap(176,  369) --屏蔽全屏玫瑰
				mmsleep(1000)
				ltap(388,  366) --屏蔽红包特效
				mmsleep(1000)
				ltap(388,  438) --屏蔽主播送花
				mmsleep(1000)
				ltap(177,  437) --屏蔽技能特效
				mmsleep(1000)
			end

			ltap( 1011,   63) --关闭设置窗口
			yaoshui_shezhi = 'Y'
			--[[
		elseif multi_col({
				{  184,  178, 0xc48a53},
				{  178,  189, 0xbf7f49},
				{  164,  192, 0xd19d62},
				{  181,  566, 0xc0844e},
				{  173,  575, 0xbc834e},
				{ 1011,   64, 0xab7c4d},
				}) then
			ltap(1011,   64)
			wwlog("621 关闭设置窗口")
			yaoshui_shezhi = 'Y'
			--dialog_flag = 'N'
			break
			--]]	
			--[[
		elseif multi_col({
				{ 1049,  157, 0x4e0b05},
				{ 1057,  170, 0xeaba87},
				{  903,  182, 0xb68a5c},
				{  902,  191, 0x6d4d37},
				{  838,  186, 0x546722},
				}) then
			ltap(835,  188)
			wwlog("1579 关闭红色药水")
		elseif multi_col({
				{ 1054,  159, 0x650904},
				{ 1063,  197, 0xf7ce96},
				{  904,  481, 0xc09564},
				{  898,  491, 0x6f4e39},
				{  836,  487, 0x546722},
				}) then
			ltap(837,  484)
			wwlog("1588 关闭蓝色药水")
			mmsleep(500)
			ltap(1011,   64)
			wwlog("621 关闭设置窗口")
			yaoshui_shezhi = 'Y'
			break
			--]]	
			--[[
		elseif multi_col({
				{  845,  191, 0x444444},
				{  900,  190, 0x201410},
				{  845,  487, 0x545454},
				{  909,  485, 0x20140f},
				{ 1058,  299, 0x3f251c},
				}) then
			ltap(1058,  299)
			wwlog("638 药水设置完毕，点击拾取设置")
		elseif multi_col({
				{ 1049,  263, 0x4b0b05},
				{ 1058,  292, 0xf1c58f},
				{  168,  194, 0x130b07},
				{  174,  191, 0x130a06},
				{  177,  183, 0x130a06},
				}) then
			ltap(168,  183)
			wwlog("647 自动拾取白色药水")
		elseif multi_col({
				{  164,  565, 0x130c08},
				{  194,  565, 0x362720},
				{  193,  574, 0x362923},
				{  145,  568, 0x362821},
				{  171,  568, 0x130c08},
				}) then
			ltap(171,  568)
			wwlog("656 自动拾取金币")
			--]]	
		elseif multi_col({
				{  507,  583, 0xeece79},
				{  507,  593, 0x784827},
				{  627,  580, 0xf0df88},
				{  626,  598, 0x9a7138},
				})then
			ltap(569,  575)
			wwlog("609 点击红篮球")
		end 
	end	

	----------------------------------------领取福利-------------------------------------------
	function get_award(...)
		-- body
	end
	mmsleep(1000)
	local yaoshui_cnt =0
	while (fuli_flag =='N' ) do
		wwlog("1330 领取福利")
		yaoshui_cnt = yaoshui_cnt +1
		mmsleep(500)
		--[[
		if not multi_col({
				{  896,   11, 0xce4422},
				{  902,    9, 0xdf4422},
				{  897,   18, 0xb91101},
				{  902,   18, 0xb91202},
				}) then
			wwlog("752 没有福利可以领取")
			fuli_flag = 'Y'
			break
		end
		]]--
		mmsleep(500)
		if multi_col({
				{  894,   13, 0xbe3322},
				{  899,   15, 0xaa1100},
				{  861,   44, 0xdd3622},
				})then
			ltap(861,   44)
			wwlog("722 点击福利")
		elseif multi_col({
				{  530,   45, 0x51140f},
				{  555,   42, 0xf3c992},
				{  209,  145, 0x7b5322},
				{  278,  124, 0xaf1600},	
				}) then
			if multi_col({
					{  355,  182, 0x1fb21f},
					{  363,  213, 0x1eb01e},
					{  440,  192, 0x1eaf1e},
					}) then
				ltap( 571,  171)
				wwlog("1391 金币已领取，领取第二个奖励")
			else
				ltap(401,  173)
				wwlog("731 签到领取5w金币")
			end	
		elseif multi_col({
				{  264,  348, 0x6a4519},
				{  282,  335, 0xb11600},
				{  902,  221, 0x6e371c},
				{  931,  220, 0x7b3d1d},
				}) then
			ltap(358,  133) --点击第一天
			mmsleep(1000)
			ltap(931,  220)
			wwlog("739 领取七日盛典第一天的礼包")
		elseif multi_col({
				{  227,  339, 0x594a3b},
				{  284,  334, 0xaf1600},
				{  259,  356, 0x40342a},
				}) then
			ltap(259,  356)
			wwlog("746 点击七日盛典")
		elseif multi_col({
				{  532,   47, 0x4c1311},
				{  281,  192, 0xc73216},
				{  209,  217, 0x473a30},
				}) then
			ltap(209,  217)
			wwlog("754 点击在线礼包")
		elseif multi_col({
				{  522,   49, 0x4a1414},
				{  228,  197, 0x976729},
				{  281,  191, 0xb71400},
				{  898,  365, 0x70371c},
				{  928,  370, 0x603019},
				}) then
			ltap(928,  370)
			wwlog("740 领取第一个在线礼包")
		elseif multi_col({
				{  527,   41, 0x58180e},
				{  555,   42, 0xf3c992},
				{  282,  191, 0xb71400},
				{  227,  206, 0x4e4231},
				}) then
			ltap(227,  206)
			wwlog("793 点击在线礼包标签")
		elseif multi_col({
				{  210,  203, 0x9a6a27},
				{  279,  194, 0xaf1600},
				{  894,  368, 0x603119},
				{  906,  371, 0x5e2f18},
				}) then
			ltap(928,  370)
			wwlog("779 领取第一个在线礼包")
			--break
		elseif multi_col({
				{  533,   42, 0x57170e},
				{  568,   43, 0x51140f},
				{  286,  332, 0x744e20},
				{ 1011,   64, 0xab7c4d},
				}) or multi_col({
				{  285,  331, 0x4a4131},
				{  286,  193, 0x734c1e},
				{  533,   45, 0x4f130f},
				{ 1012,   64, 0xb88551},
				}) then
			ltap(1011,   64)
			wwlog("771 关闭福利窗口")
			fuli_flag = 'Y'
		elseif multi_col({
				{  523,   39, 0x58180e},
				{  287,  123, 0x744e1e},
				{  286,  192, 0x4a4131},
				{  285,  332, 0x4a4131},	
				}) then
			ltap(1011,   64)
			wwlog("771 关闭福利窗口")
			fuli_flag = 'Y'
			break
		elseif multi_col({
				{  467,  506, 0xfbfbfb},
				{  492,  505, 0xd8d5d4},
				{  522,  505, 0xdad8d6},
				{  547,  504, 0xecebe9},
				{  475,  514, 0xe4e2e1},
				{  493,  509, 0xf8f7f7},
				}) then
			ltap(493,  509)
			wwlog("741 点击屏幕继续--通用")
		elseif multi_col({
				{  531,  309, 0xa74cc9},
				{  531,  338, 0xa74cc9},
				{  589,  292, 0xa84cca},
				}) then
			ltap(589,  292)
			wwlog("738  点击屏幕继续")
		elseif not multi_col({
				{  896,   11, 0xce4422},
				{  902,    9, 0xdf4422},
				{  897,   18, 0xb91101},
				{  902,   18, 0xb91202},
				}) then
			wwlog("752 没有福利可以领取")
			fuli_flag = 'Y'
			break
		end
		if yaoshui_cnt >20 then
			yaoshui_cnt = 0
			break
		end

	end

	function get_first_mail(...)
		-- body
	end

	while first_mail == false do	
		wwlog("3026 领取邮件")
		mmsleep(1000)
		--safe_place()
		mmsleep(100)
		if multi_col({
				{  500,  575, 0xfffe93},
				{  500,  578, 0xfef9ac},
				{  500,  597, 0xa77542},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				}) then
			ltap( 793,  572) --点击社交
			mmsleep(2000)
			ltap(879,  476) --点击邮件
		elseif multi_col({
				{  535,   82, 0x540905},
				{  548,   82, 0xf2c891},
				{  556,   89, 0xf4cb93},
				{  575,   85, 0xf5cc94},
				{  301,  532, 0x652e17},
				{  322,  536, 0xd2a777},
				})then
			ltap(322,  536) --一键领取
			mmsleep(5000)
			ltap(955,   82)  --关闭邮件窗口
			mmsleep(80)
			first_mail = true
			--main_task = true
			wwlog("3054 一键领取")
			break

		elseif multi_col({
				{  511,  576, 0xf8f8a0},
				{  507,  579, 0xfef38e},
				{  510,  598, 0xb9864b},
				{  624,  575, 0xffff92},
				{  624,  599, 0xcc994c},
				}) then
			ltap(568,  578) --点击圆球
			mmsleep(2000)
			ltap( 793,  572) --点击社交
			mmsleep(2000)
			ltap(876,  477) --点击邮件
		else
			ltap(568,  578) --点击圆球			
			-- body
		end		
	end



	function init_bag(...)
		-- body
	end
	--整理背包
	local flag2 = true
	while(bag_is_ready == false) do
		mmsleep(1000)

		if flag2 == true then
			resethome()
			mmsleep(1000)
			fenjie_1()
			mmsleep(1000)
			change_line()
			mmsleep(1000)
			flag2 = false
		end

		wwlog("1237 整理背包，打开新兵礼包")		

		if multi_col({
				{  510,  575, 0xfff798},
				{  510,  578, 0xf9e28e},
				{  508,  582, 0xedcd7a},
				{  625,  575, 0xfff599},
				{  628,  582, 0xebd17d},
				})then
			ltap(565,  576)
			wwlog("1461 点击红篮球，展开底部按钮栏")
		elseif multi_col({
				{  500,  574, 0xfcfc94},
				{  500,  576, 0xfdfc9f},
				{  500,  599, 0xc7964c},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				})then
			wwlog("1471 按钮栏为展开状态，点击背包")
			ltap(338,  576) --点击背包
			mmsleep(2000)
			ltap( 928,  510) --点击整理
			mmsleep(12000)
		elseif multi_col({
				{  291,  152, 0xdd1121},
				{  299,  153, 0xd52122},
				}) then
			ltap(299,  153) --点击新兵礼包
			wwlog("1488 点击新兵礼包")	
			mmsleep(2000)
			ltap(649,  536) --点击使用
			mmsleep(3000)
			ltap(931,  506) --点击整理背包
			mmsleep(12000)

			ltap(  293,  154) --点击第一个格子--邮件赠送的太阳药水
			mmsleep(3000)

			ltap(568,  373) --点击药店
			mmsleep(5000)

			ltap(  596,  160) --点击第一个红药水
			mmsleep(5000)
			ltap(656,  543) --点击确定--购买
			mmsleep(10000)
			ltap(  783,  163) --点击第二个蓝药水
			mmsleep(5000) 
			ltap(656,  543) --点击确定--购买
			mmsleep(10000)
			ltap( 1011,   65) --点击关闭药店
			mmsleep(3000)
			ltap(931,  506) --点击整理背包
			mmsleep(10000)
			ltap(1010,65 ) --关闭背包									
			bag_is_ready = true
		end
	end

	function buy_enough2(...) --左侧函数栏定位函数
		-- body
	end
	while (bag_full == false) do
		mmsleep(1000)
		wwlog("1523 购买药水，以便塞满背包")
		if multi_col({
				{  510,  575, 0xfff798},
				{  510,  578, 0xf9e28e},
				{  508,  582, 0xedcd7a},
				{  625,  575, 0xfff599},
				{  628,  582, 0xebd17d},
				})then
			ltap(565,  576)
			wwlog("1461 点击红篮球，展开底部按钮栏")
		elseif multi_col({
				{  500,  574, 0xfcfc94},
				{  500,  576, 0xfdfc9f},
				{  500,  599, 0xc7964c},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				})then
			wwlog("1471 按钮栏为展开状态")
		end

		mmsleep(3000) --展开按钮栏延迟准备时间

		for j = 1 ,3,1 do --1  开发测试阶段暂时只处理红色药水
			local var_cnt = 30
			local var_cnt1 = 30
			if j==3 then
				var_cnt = 20
				var_cnt1 = 20
			end
			mmsleep(500)
			wwlog(j)
			if multi_col({
					{ 1005,   57, 0xfae18b},
					{ 1017,   58, 0xf5e392},
					{ 1007,   67, 0xd19455},
					{ 1011,   63, 0xe9c77d},
					}) then
				ltap(1010,65) --背包忘关的话，赶紧关了
			end
			mmsleep(200)
			ltap(338,  576) --点击背包
			mmsleep(1000)
			ltap( 1078,  297) --点击仓库
			mmsleep(500)
			--snapshot("abc"..tostring(j)..".png", 0, 0, 1135, 639)						
			local i = 0
			repeat
				mmsleep(200)
				local cang_ku_in_flag = false
				--local get_unlocked ,get_locked				
				if multi_col({
						{  634,  402, 0x7e421e},
						{  643,  415, 0xe8bd89},
						{  667,  413, 0xe9be89},
						{  694,  420, 0xf1c791},
						{  564,  435, 0x604d3f},
						}) then
					ltap(667,  413)
					wwlog("1586 点击我知道了")
					mmsleep(500)
				elseif multi_col({
						{  426,  352, 0x130b07},
						{  438,  352, 0x130b07},
						{  425,  365, 0x130b07},
						{  672,  401, 0x783e1b},
						}) then
					ltap(672,  401)
					wwlog("1594 保持流畅模式")
				elseif multi_col({
						{  426,  352, 0x130b07},
						{  438,  352, 0x130b07},
						{  425,  365, 0x130b07},
						{  672,  401, 0x783e1b},
						}) then
					ltap(672,  401)
					wwlog("1602 保持流畅模式")			
				end
				mmsleep(200)
				local cnt5 = 0
				while (not multi_col({
							{  614,  342, 0x372217},
							{  613,  386, 0x3b2418},
							{  612,  452, 0x3d2418},
							{  629,  390, 0x180f0b},
							})) do
					wwlog("1583 等待出现仓库主界面")
					mmsleep(500)
					cnt5 = cnt5 +1
					if cnt5 >20 then
						wwlog("1588 等待出现仓库主界面 延迟，强制退出")
						break			
					end
					mmsleep(500)
					-- body
				end
				if j == 1 then
					if multi_col({
							{  208,  193, 0x57e459},
							{  214,  193, 0x54dc56},
							{  215,  190, 0x50d552},
							})then
						ltap(183,  164) --点击第一个格子--太阳药水
						wwlog("1584 点击背包第一个格子--太阳药水")
					end
				elseif j == 2 then
					if multi_col({
							{  208,  193, 0x57e459},
							{  214,  193, 0x54dc56},
							{  215,  190, 0x50d552},
							}) then
						ltap(183,  164)--点击第一个格子--太阳药水
						wwlog("1584 点击背包第一个格子--太阳药水")
					end	
				elseif j == 3 then
					if multi_col({
							{  304,  193, 0xdedede},
							{  309,  193, 0xd8d8d8},
							{  310,  190, 0xc6c6c6},
							}) then 
						ltap( 281,  169)--点击第二个格子--蓝药水
						wwlog("1584 点击背包第二个格子--蓝药水")
					end
				end	
				---------------------------------------------------------------------------
				mmsleep(2000)
				local cnt2= 0
				while (not multi_col({
							{  552,  536, 0xedc38e},
							{  555,  539, 0xf3ca92},
							{  563,  532, 0xeec38d},
							{  562,  541, 0xf6cd95},
							})) do
					cnt2 = cnt2 +1
					wwlog("1613 等待放入按钮出现")
					mmsleep(1000)
					if cnt2>20 then
						wwlog("1618  等待放入按钮出现延迟，强制退出")
						break
					end
				end
				mmsleep(500)
				if multi_col({
						{  545,  369, 0x4d3a2b},
						{  566,  372, 0xbd8e6b},
						{  562,  370, 0xa77e5e},
						{  572,  370, 0xbc8d6a},
						{  578,  373, 0xad8262},
						})  then
					ltap(568,  373) --点击药店
					wwlog("1649 红蓝药水-->点击药店")
				elseif multi_col({
						{  553,  391, 0xb78a68},
						{  562,  392, 0xbd8e6b},
						{  566,  400, 0xbd8e6b},
						{  580,  399, 0xba8b69},
						})then
					ltap(568,  373) --点击药店
					wwlog("1649 太阳药水-->点击药店")
				end	

				----------------------------------------------------------------------------

				mmsleep(1000) --进入药店的延迟等待
				local loop_cnt1 = 0
				while not multi_col({
						{  494,  296, 0x5aeb5c},
						{  501,  297, 0x4ecd50},
						{  535,  292, 0x4fb450},
						}) do
					wwlog("1651 进入药品商城出现延迟")
					mmsleep(1000)
					loop_cnt1 = loop_cnt1 + 1
					if loop_cnt1 >10 then
						wwlog("1673 进入药品商城延迟10秒")
						break
					end
				end

				mmsleep(1000)
				if j ==1 then
					if multi_col({
							{  526,  191, 0xdedede},
							{  534,  191, 0xc4c4c4},
							{  534,  183, 0xc3c3c3},
							{  529,  190, 0x7a7775},
							}) then
						ltap(  615,  160) --点击第一个红药水
						wwlog("1712 点击药店第一个红药水")
					end
				elseif j ==2 then
					if multi_col({
							{  815,  186, 0xc9c9c9},
							{  814,  192, 0xc1c1c1},
							{  813,  190, 0x8c8887},
							{  809,  191, 0xdcdcdc},
							} ) then
						ltap(  783,  163) --点击第二个蓝药水
						wwlog("1722 点击药店第二个蓝药水")
					end 
				elseif j ==3 then
					if multi_col({
							{  530,  296, 0x58e55a},
							{  532,  296, 0x56e058},
							{  533,  294, 0x51d653},
							{  534,  293, 0x4dcc4f},
							}) then
						ltap(615,  268) --点击第三个太阳神水
						wwlog("1732 点击药店第三个太阳神水")
					end
				end
				mmsleep(1000)
				-----------------------------------------------------------------------------
				local cnt6 = 0
				while (not multi_col({
							{  689,  355, 0xefbe5c},
							{  690,  373, 0xb9713d},
							{  439,  358, 0xffed9a},
							{  439,  373, 0xb9713c},
							})) do
					wwlog("1813 等待购买药水界面")
					mmsleep(1000)
					cnt6 =cnt6 +1
					if cnt6 >15 then
						wwlog("1747 等待购买药水界面 出现延迟")						
						if j ==1 then					
							ltap(  615,  160) --点击第一个红药水
							wwlog("1712 点击药店第一个红药水")					
						elseif j ==2 then					
							ltap(  783,  163) --点击第二个蓝药水
							wwlog("1640 点击药店第二个蓝药水")					
						elseif j ==3 then					
							ltap(615,  268) --点击第三个太阳神水
							wwlog("1650 点击药店第三个太阳神水")					
						end
						--break
					end
					if cnt6 >20 then
						break
					end
				end
				mmsleep(1000)
				local cnt4 = 0
				--[[
				while (not multi_col({
							{  689,  355, 0xefbe5c},
							{  690,  373, 0xb9713d},
							{  439,  358, 0xffed9a},
							{  439,  373, 0xb9713c},
							})) do
					-- body
					wwlog("1710 等待出现购买物品弹窗")
					mmsleep(500)
					cnt4 = cnt4 + 1
					if cnt4 > 20 then
						wwlog("1715 等待出现购买物品弹窗 出现延迟，强制退出")
						break
					end
				end
				--]]
				mmsleep(500)	
				local buy_cnt =1
				if j ==1 then
					buy_cnt = 4
				elseif j==2 then
					buy_cnt = 2
				elseif j ==3 then
					buy_cnt = 3 
				end
				if multi_col({
						{  687,  355, 0xefbe5c},
						{  691,  373, 0xb9713d},
						{  688,  366, 0x971b19},
						{  698,  365, 0xd2a367},
						}) then
					for i=1,buy_cnt,1 do 
						mmsleep(200)
						ltap(690,  366)
					end	
					wwlog("1666 点击购买多个药品")
				end
				-----------------------------------------------------------------------------
				--end
				mmsleep(500)
				local break1 = 0
				while not multi_col({
						{  468,  185, 0xc2c2c2},
						{  468,  191, 0xc3c3c3},
						{  471,  191, 0xd9d9d9},
						{  468,  132, 0xc3c3c3},
						}) do
					ltap(656,  543) --点击确定--购买
					mmsleep(2000)
					break1 = break1 +1
					if break1 >5 then
						wwlog("1721 购买延迟")
						break
					end
				end	
				mmsleep(500)
				local cnt3 = 0
				while (not multi_col({
							{  526,   36, 0xf7ce96},
							{  553,   35, 0xf6cd95},
							{  575,   36, 0xf6cc94},
							{ 1011,   63, 0xe9c77d},
							{ 1015,   60, 0xe6d490},
							})) do
					wwlog("1741 等待购买完成")
					mmsleep(500)
					cnt3 = cnt3 +1
					if cnt3 >20 then
						wwlog("1747 购买药品出现延迟，强制退出")
						break
					end

					-- body
				end
				-----------------------------------------------------------------------------
				--mmsleep(1000) --购买药水的延迟
				if multi_col({
						{  526,   36, 0xf7ce96},
						{  553,   35, 0xf6cd95},
						{  575,   36, 0xf6cc94},
						{ 1011,   63, 0xe9c77d},
						{ 1015,   60, 0xe6d490},
						}) then
					ltap( 1011,   65) --点击关闭药店
					wwlog("1718 关闭药店")
				end
				-----------------------------------------------------------------------------
				mmsleep(500)
				if j == 1 then
					if multi_col({
							{  400,  193, 0xdbdbdb},
							{  404,  193, 0xd8d8d8},
							{  406,  190, 0xc6c6c6},
							})then
						ltap(376,  166)  --点击第三个格子--红药水
						wwlog("点击背包第三个格子--红药水")
					end	
				elseif j ==2 then
					if multi_col({
							{  304,  193, 0xdedede},
							{  308,  193, 0xd8d8d8},
							{  310,  189, 0xc8c8c8},
							}) then
						ltap( 281,  166)  --点击第二个格子--蓝药水
						wwlog("1737 点击背包第二个格子--蓝药水")
					end
				elseif j ==3 then
					if multi_col({
							{  211,  193, 0x56e158},
							{  214,  193, 0x54dc56},
							{  215,  188, 0x52d854},
							})then
						ltap(184,  166) --点击第一个格子--太阳神水
						wwlog("1745 点击背包第一个格子--太阳神水")
					end
				end	
				-----------------------------------------------------------------------------
				mmsleep(1000)
				if multi_col({
						{  546,  529, 0x6a341a},
						{  550,  534, 0xf5cb94},
						{  555,  539, 0xf3ca92},
						{  579,  533, 0xf7ce96},
						}) then
					ltap(564,  534) --点击放入仓库
					wwlog("1756 点击放入仓库")
					cang_ku_in_flag = true
				end
				-----------------------------------------------------------------------------
				mmsleep(500)	
				if cang_ku_in_flag == false then
					var_cnt = var_cnt +1
				end

				i = i+1
				if i >90 then
					wwlog("1719 循环超过60次，延迟非常严重")
					break
				end						
			until (i >=var_cnt )
			mmsleep(3000)
			wwlog("1909 开始从仓库取药水")
			for i= 1,var_cnt1,1 do 
				local out_flag = false
				mmsleep(1000)
				if  multi_col({
						{  982,  257, 0xde9f26},
						{ 1001,  238, 0xac282a},
						{ 1019,  255, 0xde9f26},
						{  998,  282, 0xde9f26},
						{ 1000,  302, 0x9f2123},
						})then
					ltap(998,  282)
					wwlog("1877 打开红包")
				elseif multi_col({
						{  982,  257, 0xde9f26},
						{ 1001,  238, 0xac282a},
						{ 1019,  255, 0xde9f26},
						{  998,  282, 0xde9f26},
						{ 1000,  302, 0x9f2123},
						})then
					ltap(998,  282)
					wwlog("1886 打开红包")			
				end		

				--mmsleep(1000)
				if i ==17 then
					mmsleep(3000)
					moveTo(968,  500, 968,  125,1)
					mmsleep(3000)
				end	
				local ret ,x,y = get_cangku_position(i)

				--if ret ==  true  then
				mmsleep(1000)
				local flag3 = false
				if multi_col({
						{  600,   43, 0x50130f},
						{ 1077,  297, 0x560b05},
						{  818,  550, 0x763f1b},
						{  686,  548, 0x433429},
						}) then
					wwlog("2012 判断仓库，开始点击药水")
					mmsleep(200)
					if (not isColor( x,  y, 0x251007, 100)) then
						ltap(x,y) --点击药水									
						wwlog("2013 点击仓库药水")
						flag3 = true
					else
						wwlog("2015 仓库颜色没有匹配到,无法取出")
					end
				end	

				if flag3 == false then
					mmsleep(1000)
					ltap(x,y) --点击药水									
					wwlog("2024 颜色判断失败，直接点击仓库药水")
				end
				-----------------------------------------------------------------------------
				mmsleep(2000)
				local cnt1 = 0
				while not multi_col({
						{  551,  529, 0xecc28c},
						{  555,  537, 0xf2c992},
						{  578,  536, 0xf4cb93},
						}) do
					wwlog("2024 等待取出按钮")
					mmsleep(1000)
					cnt1 =cnt1 +1
					if cnt1 >10 then
						wwlog("2028 取药延迟强制退出")
						break
					end
				end
				mmsleep(1000)
				if multi_col({
						{  537,  522, 0x8e4f23},
						{  563,  522, 0x7f431e},
						{  555,  536, 0xf2c992},
						{  578,  536, 0xf4cb93},
						}) then --判定取出按钮
					ltap( 563,  533) --点击取出
					wwlog("2040 从仓库取出药水")
					out_flag = true						
					-----------------------------------------------------------------------------
				end				
				--end	
				--[[
				if out_flag  == false then
					var_cnt = var_cnt +1
				end
				--]]
			end	--end for
		end
		--if check_bag2() ==true then
		bag_full = true
		--end
	end

	resethome()	

	renwu_flag = 1
	local auto_click = false
	while (main_task == true) do
		wwlog("2135 继续做主线任务")
		mmsleep(1000)
		--ltap( 94,  196)
		mmsleep(80)
		snapshot("right_corner.png", 1036,   29,  1125,   59); --以test命名进行截图
		mmsleep(1000)
		renwu_flag = renwu_flag +1

		if multi_col({
				{   14,  162, 0x5de36b},
				{   22,  162, 0x5fe570},
				{   14,  176, 0x58d66b},
				{   35,  169, 0x5ddf71},
				{   41,  169, 0x5cde6e},
				}) then
			auto_click = true
			wwlog("2522 密令任务- 自动点击任务栏")
		elseif multi_col({
				{   19,  162, 0x5ee36e},
				{   24,  167, 0x62f36b},
				{   36,  165, 0x66ff66},
				{   43,  165, 0x64f868},
				}) then
			auto_click = true
			wwlog("2530 狩魔任务--自动点击任务栏")
		elseif multi_col({
				{   19,  161, 0xdd11ed},
				{   19,  170, 0xe10eef},
				{   35,  169, 0xd714eb},
				{   40,  169, 0xd612e8},
				})then
			auto_click = true
			wwlog("1982 紫色诏令--自动点击任务栏")
		elseif multi_col({
				{   18,  165, 0xf0cf6d},
				{   18,  173, 0xebc86a},
				{   41,  164, 0xf8e273},
				{   42,  173, 0xfdec77},
				}) then
			auto_click = false
			wwlog("2100 主线任务关闭自动点击任务栏")
		end
		mmsleep(1000)
		if  multi_col({
				{  982,  257, 0xde9f26},
				{ 1001,  238, 0xac282a},
				{ 1019,  255, 0xde9f26},
				{  998,  282, 0xde9f26},
				{ 1000,  302, 0x9f2123},
				})then
			ltap(998,  282)
			wwlog("341 打开红包")
		elseif multi_col({
				{  528,   59, 0x822414},
				{  531,   65, 0xf0c58f},
				{  540,   68, 0xeec38e},
				{  550,   70, 0xf3c992},
				})then
			ltap(550,   70)
			wwlog("2358 跳过引导")
		elseif multi_col({
				{  521,  556, 0x872814},
				{  529,  573, 0xf1c791},
				{  550,  569, 0xf3c992},
				{  571,  569, 0xf6cc95},
				{  567,  570, 0x571110},
				}) then
			ltap(567,  570)
			wwlog("1655 跳过引导")
		elseif multi_col({
				{   54,  170, 0xc52937},
				{   74,  170, 0xebd26d},
				{   93,  168, 0xf2dd71},
				{   40,  193, 0xdfb986},
				{   76,  190, 0xe9e7e6},
				{   76,  201, 0xd2d1cf},
				}) and mail_get == false then
			wwlog("2445 主线--变身--对话--血煞")
			if mail_get == false then
				main_task = false
				break
			end			
		elseif multi_col({
				{  848,  205, 0x4f1e1d},
				{  846,  234, 0x4c1d1c},
				{  846,  346, 0x4a1c1b},
				{ 1037,  184, 0x8a2121},
				{ 1035,  191, 0xd7bc7a},
				{ 1027,  198, 0xba733f},
				{ 1031,  272, 0x4a211c},
				{ 1013,  393, 0x461a19},
				})then
			ltap(938,  398)
			wwlog("354 立即装备")

		elseif multi_col({
				{  398,  371, 0xbd56e2},
				{  398,  403, 0xb955df},
				{  398,  436, 0xba56e0},
				{  464,  370, 0xe068ec},
				{  761,  402, 0x362720},	
				})then
			ltap(834,  403)
			wwlog("1651 完成任务2")
		elseif multi_col({
				{  507,   85, 0x420a05},
				{  532,   92, 0xefc58f},
				{  574,   90, 0xf6cd95},
				{  476,  546, 0x592819},
				{  662,  545, 0x542617},
				})then
			ltap(476,  546)
			mmsleep(1000)
			ltap(662,  545)
			wwlog("622 点击购买最大药水")
		elseif multi_col({
				{  498,  370, 0x68a5ec},
				{  566,  370, 0x5781c1},
				{  498,  438, 0x4a7ac3},
				{  498,  403, 0x588fe6},
				}) then
			ltap(832,  404)
			wwlog("395 完成任务")
		elseif multi_col({
				{  598,  370, 0xce6adb},
				{  598,  393, 0xb85fd8},
				{  598,  438, 0x9f53ba},
				{  664,  370, 0xdf68ec},	
				})then
			ltap(834,  403)
			wwlog("403 接受任务3")
		elseif multi_col({
				{  350,  338, 0x66fe65},
				{  372,  338, 0x61e95f},
				{  394,  349, 0x65fb64},
				{  402,  345, 0x382820},
				{  415,  347, 0x5bcf56},
				{  424,  351, 0x5eda5a},
				}) then	
			ltap( 802,  405)
			wwlog("接受任务")
		elseif multi_col({
				{  498,  370, 0xdc68ec},
				{  498,  402, 0xc15ae8},
				{  498,  436, 0xbe59e5},
				{  562,  370, 0xd768ec},	
				}) then
			ltap(835,  404)
			wwlog("412 接受任务2")
		elseif multi_col({
				{  672,  508, 0x80431e},
				{  683,  532, 0x4f1f14},
				{  709,  522, 0xe5ba87},
				{  734,  524, 0xedc48e},
				{  734,  530, 0x5b2718},
				}) then
			ltap(734,  530)
			wwlog("333 传送")
		elseif multi_col({
				{  561,  543, 0x7c421f},
				{  571,  565, 0x522317},
				{  588,  554, 0xe5bc89},
				{  608,  557, 0x562719},
				{  644,  555, 0xf2ca94},
				})then
			ltap(644,  555)
			wwlog("342 任务窗口--完成任务")
		elseif multi_col({
				{  562,  544, 0x753f1e},
				{  558,  563, 0x492115},
				{  655,  539, 0x884c22},
				{  662,  566, 0x4d1f15},
				{  610,  540, 0x78411c},
				})then
			ltap(610,  540)
			wwlog("351 任务窗口--立刻前往")
		elseif multi_col({
				{  426,  352, 0x130b07},
				{  438,  352, 0x130b07},
				{  425,  365, 0x130b07},
				{  672,  401, 0x783e1b},
				}) then
			ltap(672,  401)
			wwlog("2181 保持流畅模式")
		elseif multi_col({
				{   25,  122, 0xeee089},
				{   28,  128, 0xfbec95},
				{   28,  132, 0x613f1d},
				{   24,  140, 0xae7f40},
				{   32,  130, 0xaa8c5c},
				}) then
			ltap(32,  130)
			wwlog("点击任务-三角箭头")				
		elseif multi_col({
				{  201,  138, 0x61401a},
				{  652,  306, 0xfdfcfc},
				{  660,  307, 0xfbfbfb},
				{  761,  305, 0xffe72d},
				{  922,  308, 0x633218},
				})then
			ltap(922,  308)
			wwlog("506 膜拜")
		elseif multi_col({
				{  500,   39, 0x57170e},
				{  537,   43, 0xf3ca93},
				{  561,   43, 0xf4cb94},
				{  589,   52, 0x450e11},
				}) then
			local x,y = findMultiColorInRegionFuzzy( 0xff9b00, "18|0|0xffe72d,37|-1|0xffe432,59|0|0xffc615", 90, 694,  155, 864,  522)
			if x~= -1 and y ~= -1 then
				ltap(x+160,y)	
				wwlog("516 日常玩法--王城膜拜")
			end
			wwlog("518 日常玩法")
		elseif multi_col({
				{  910,  608, 0xfbfbfa},
				{  924,  611, 0xfdfdfd},
				{  941,  608, 0xfbfbfb},
				{  961,  610, 0xfdfdfd},
				{  989,  609, 0xfbfbfa},
				}) then
			ltap(989,  609)
			wwlog("2341 请点击继续")
			before_game ='N'
		elseif multi_col({
				{ 1024,  107, 0x5e1612},
				{ 1024,   92, 0x7b2512},
				{ 1056,  108, 0xcfa075},
				{ 1078,  109, 0xd6a77a},
				{ 1091,  109, 0x531110},
				}) then
			ltap(1091,  109)
			wwlog("2351 红色跳过")
		elseif multi_col({
				{ 1032,  106, 0x6c1a14},
				{ 1058,  106, 0xe7b987},
				{ 1066,  105, 0x6b1914},
				{ 1093,  105, 0x711c17},
				})then
			ltap(1093,  105)
			wwlog("462 红色退出")
		elseif multi_col({
				{  518,  175, 0x816856},
				{  539,  177, 0xeac38f},
				{  369,  438, 0x652f1b},
				{  416,  439, 0x67311c},
				})then
			ltap(416,  439)
			wwlog("461 回城复活")	
		elseif multi_col({
				{  540,  202, 0x604c40},
				{  555,  199, 0xf6cd95},
				{  579,  202, 0xf3ca94},
				{  542,  415, 0x6a321c},
				{  564,  415, 0xf6cd96},
				})then
			ltap(564,  415)
			wwlog("470 确定")
		elseif multi_col({
				{  510,  202, 0x281e19},
				{  630,  205, 0x372821},
				{  640,  415, 0x6a321c},
				{  701,  416, 0x512516},
				})then
			ltap(701,  416)
			wwlog("496 确定")
		elseif multi_col({
				{  523,  405, 0x78401c},
				{  520,  426, 0x4b1f14},
				{  555,  419, 0x7c4c34},
				{  599,  420, 0x502416},
				{  572,  421, 0x5e2819},
				}) then
			ltap(572,  421)
			wwlog("558 角色死亡，点击确定")

		elseif multi_col({
				{  545,  492, 0x763c1e},
				{  544,  509, 0x511f14},
				{  567,  500, 0xc39267},
				{  584,  503, 0xf5cc95},
				{  574,  503, 0x5d2919},
				}) then
			ltap(574,  503)
			wwlog("567 领取奖励 --确定")
			mmsleep(1000)
			ltap(574,  503)
		elseif multi_col({
				{  530,  292, 0xb252d7},
				{  531,  313, 0xa74cc9},
				{  558,  292, 0xa64cc9},
				{  558,  324, 0xffff55},
				}) then
			ltap( 88,  195)
			wwlog("577 领取奖励--点击屏幕继续")
		elseif multi_col({
				{  521,  428, 0x733b1c},
				{  522,  448, 0x4c2014},
				{  539,  434, 0xe1b481},
				{  559,  438, 0xd2a778},
				{  567,  442, 0x592a1a},
				})then
			ltap(567,  442)
			wwlog("567 重新登陆游戏，领取奖励")
		elseif multi_col({
				{    2,  138, 0xf8ec8e},
				{    3,  141, 0xf6e68c},
				{    3,  152, 0xfff7b1},
				{    3,  157, 0x6a4626},
				{    9,  159, 0x7a522b},
				{    4,  166, 0x986a38},
				})then
			ltap( 99,  169)
			wwlog("318 副本 向复活点推进")

		elseif multi_col({
				{  530,   48, 0x4a1311},
				{  561,   45, 0xa77556},
				{  257,  275, 0x68461e},
				{  452,  329, 0xf1f0ef},
				{  777,  340, 0xedecec},
				{  792,  330, 0xf8f8f8},
				})then
			--doublePressHomeKey()
			ltap( 1010,   65) --关闭添加好友窗口
			mmsleep(200)
			ltap( 1061,   40) --打开右上角地图
			mmsleep(500)
			ltap( 1060,  302) --点击主城
			mmsleep(500)
			ltap(557,  170) --点击中州主城
			mmsleep(200)
			ltap(  933,  560) --传送前往
			wwlog("616 回到中州主城")
			--closeApp("com.tencent.cqsj")
			--wwlog("758 附近没有其他勇士，不能添加好友，关闭游戏，重新进入")	
		elseif multi_col({
				{  600,   46, 0x470f0f},
				{  259,  279, 0x63421a},
				{  527,  320, 0x2e1f18},
				{  840,  322, 0x5dda59},
				{  849,  322, 0x5fe45c},
				})then
			ltap(849,  322)
			mmsleep(500)
			ltap(  949,  560)
			mmsleep(500)
			ltap( 1011,   63) --关闭
			wwlog("627 添加第三位好友")
		elseif multi_col({
				{  529,   49, 0x461213},
				{  259,  284, 0x5b3c19},
				{  562,  258, 0x302019},
				{  839,  253, 0x66ff66},
				{  861,  253, 0x5dd959},
				}) then
			ltap(861,  253)
			mmsleep(500)
			ltap(  949,  560)
			mmsleep(500)
			ltap( 1011,   63) --关闭
			wwlog("627 添加第二位好友")
		elseif multi_col({
				{  162,  264, 0x7d5624},
				{  156,  292, 0x533718},
				{  184,  279, 0x744f21},
				{  252,  281, 0x5e3f1a},
				{  298,  281, 0xf4de93},
				})then
			ltap(672,  179)
			mmsleep(500)
			ltap(  949,  560)
			--mmsleep(1000)
			mmsleep(500)
			ltap( 1011,   63) --关闭
			wwlog("658 添加好友")
		elseif multi_col({
				{  532,   44, 0xf4cb94},
				{  513,   48, 0x481312},
				{  352,  185, 0xf4cb94},
				{  376,  184, 0xd0ab7c},
				{  540,  198, 0xfbfbfb},
				{  926,  202, 0x754629},
				})then
			ltap(926,  202)
			wwlog("677 王城赐福")
			--[[
		elseif multi_col({
				{  879,  532, 0x773e1d},
				{  878,  555, 0x4a1d14},
				{  905,  542, 0x68311c},
				{  928,  546, 0x572a1a},
				})then
			ltap(928,  546)
			wwlog("685 领取美酒")
			--]]	
		elseif multi_col({
				{  822,   80, 0xdd4422},
				{  831,   80, 0xdd4422},
				{  825,   86, 0xb81100},
				{  828,   90, 0xcc1100},
				}) then
			ltap(798,  109)
			wwlog("2948 点击日常玩法")
		elseif multi_col({
				{  284,  203, 0xffd100},
				{  348,  181, 0xdeb785},
				{  379,  186, 0xd7b181},
				{  464,  184, 0xd5af7f},
				{  538,  201, 0xf5f4f4},
				{  546,  200, 0xfefefe},
				{  923,  201, 0x633219},
				}) then
			ltap(923,  201)
			wwlog("422 第一次膜拜")
		elseif multi_col({
				{  664,  519, 0xd9b472},
				{  693,  522, 0x753b20},
				{  710,  522, 0xf4cb94},
				{  715,  530, 0xc6976d},
				{  734,  521, 0xdaad7c},
				{  734,  529, 0x5c2719},
				})then
			ltap(734,  529)
			wwlog("432 传送")
		elseif multi_col({
				{  620,  405, 0xac814d},
				{  639,  403, 0x6c351d},
				{  658,  403, 0xe9be8a},
				{  663,  409, 0xc89c70},
				{  679,  404, 0xf5cb94},
				{  689,  412, 0xedc38e},
				})then
			ltap(689,  412)
			wwlog("442 点击膜拜按钮")
		elseif multi_col({
				{  291,  522, 0x793619},
				{  305,  536, 0x5b2d18},
				{  323,  533, 0xbca051},
				{  332,  533, 0xaa8844},
				{  343,  532, 0x835329},
				})then
			ltap(343,  532)
			wwlog("451 开始膜拜")
		elseif multi_col({
				{  312,  528, 0x4b4b4b},
				{  333,  530, 0xe2d672},
				{  358,  536, 0x3a3a3a},
				{ 1002,   61, 0x62161a},
				{ 1012,   63, 0xd7ab6c},
				})then
			ltap(1012,   63)
			wwlog("619 关闭膜拜窗口")
		elseif multi_col({
				{  525,  176, 0xe0882e},
				{  542,  182, 0xcd6d29},
				{  606,  183, 0xc76725},
				{  662,  187, 0xaa4d14},
				}) then
			ltap(662,  187)
			wwlog("2571 点击屏幕继续--领取奖励")
		elseif multi_col({
				{    9,   73, 0xc09d76},
				{   14,   75, 0xd4b289},
				{   12,   78, 0xcda77d},
				{   10,   79, 0xecc48f},
				{   14,   82, 0xdeb483},
				{   10,   85, 0xe7bc89},
				})then
			wwlog("2572 30 级了，去交易")
			mmsleep(200)

			if multi_col({
					{ 1011,   60, 0x4c1213},
					{ 1008,   63, 0x401212},
					{ 1013,   61, 0xcfb781},
					{ 1007,   67, 0xd19455},
					})then
				ltap(1013,   61) --有弹窗，则关闭
				wwlog("2582 关闭弹窗")
			end
			mmsleep(5000)
			while not multi_col({
					{  535,   44, 0x501410},
					{  555,   44, 0xf3ca93},
					{  580,   53, 0xebc18d},
					{  581,   38, 0xe9be8a},
					}) do
				ltap( 1069,   43) --点击右上角地图
				wwlog("2592 点击右上角地图")
				mmsleep(2000)
			end	
			mmsleep(1000)
			ltap(1077,  300) --点击主城
			mmsleep(1000)
			ltap( 265,  171)  --点击落霞岛
			mmsleep(500)
			ltap(938,  555) --传送前往
			mmsleep(15000)
			ltap( 1069,   43) --点击右上角地图
			mmsleep(1000)
			--ltap(870,  289) --暂去首饰店老板等待
			ltap(jy_x,jy_y) --点击输入坐标
			mmsleep(30000)
			--ltap(  284,  516) --点击屏幕左下，
			ltap( 1010,   65) --关闭地图			
			jiaoyi_flag = 'S'
			break
		elseif multi_col({
				{  690,  543, 0x773e1c},
				{  700,  555, 0xd1a779},
				{  722,  559, 0xecc38f},
				{  751,  559, 0xefc791},
				{  735,  559, 0x5b2c1c},
				})then
			ltap(735,  559)
			wwlog("749 任务窗口--完成任务")
		elseif multi_col({
				{  506,   47, 0x4f1511},
				{  534,   47, 0xf5cd95},
				{  580,   44, 0xeabf8b},
				{ 1006,   63, 0x591618},
				{ 1011,   64, 0xab7c4d},
				})then
			ltap(1011,   64)
			wwlog("2571 活动大厅，关闭")
		elseif multi_col({
				{  531,   51, 0x451115},
				{  606,  542, 0xb49366},
				{  613,   47, 0x4b1110},
				{ 1012,   70, 0x551617},
				{ 1011,   63, 0xe8c77d},
				})then
			ltap(1011,   63)
			wwlog("575 任务窗口--关闭")
		elseif multi_col({
				{  951,   80, 0xf7e08c},
				{  957,   80, 0x851e1f},
				{  963,   81, 0xf4e191},
				{  962,   91, 0xd1874c},
				{  957,   86, 0xecca7f},
				}) then
			ltap(957,   86)
			wwlog("2244 关闭--传世之路")
		elseif multi_col({
				{  735,  440, 0x2e4889},
				{  762,  322, 0x311813},
				{  836,  516, 0x7b401c},
				{ 1010,   63, 0xc59c63},
				{ 1004,   63, 0x631719},
				})then
			ltap(1004,   63)
			wwlog("690 技能设置窗口--关闭")
		elseif multi_col({
				{  960,  156, 0x7e5429},
				{  953,  160, 0xac894d},
				{  957,  164, 0xfd2402},
				{  964,  164, 0xfa3401},
				{  960,  160, 0xfd9b1d},
				}) then
			ltap(960,  160)
			wwlog("759 关闭活动页面弹窗")
		elseif multi_col({
				{  509,  200, 0x2a1d19},
				{  521,  284, 0xdad7d6},
				{  432,  412, 0x6f371e},
				{  530,  286, 0xd3cfcd},
				{  474,  416, 0xeec48f},
				{  460,  421, 0x632919},
				})then
			ltap(460,  421)
			wwlog("596 寻找 统领")
		elseif multi_col({
				{  785,  389, 0x8f5024},
				{  785,  416, 0x4c1e13},
				{  873,  390, 0x82451e},
				{  879,  413, 0x4b1f14},
				{  833,  411, 0x62291a},
				})then
			ltap(833,  411)
			wwlog("接取任务--shoumo统领")
		elseif multi_col({
				{  531,   83, 0x530905},
				{  548,   83, 0xf3c892},
				{  584,   86, 0xc18e67},
				{  948,   80, 0x641719},
				{  955,   81, 0xd4a567},
				})then
			ltap(955,   81)
			wwlog("815 邮件-关闭")
		elseif multi_col({
				{ 1004,   57, 0xebca77},
				{ 1019,   56, 0xdfb760},
				{ 1019,   72, 0xca7a3a},
				{ 1002,   72, 0xd68240},
				{ 1011,   63, 0xe8c77d},
				}) then
			ltap(1011,   63)
			wwlog("778 技能装备界面--关闭")
		elseif multi_col({
				{  674,  358, 0x773b1c},
				{  690,  364, 0xf2c891},
				{  722,  365, 0xe7bd88},
				{  717,  366, 0x63321a},
				{  707,  366, 0xf0c690},
				})then
			ltap(707,  366)
			wwlog("517 使用镇魔符")
		elseif multi_col({
				{  764,  315, 0xf9be32},
				{  763,  310, 0xf6ef52},
				{  758,  315, 0xf9be32},
				{  769,  316, 0xfab22b},
				{  765,  305, 0x1f110a},
				{  760,  298, 0x20110a},
				})then
			ltap(767,  316)
			wwlog("763 购买药水")
		elseif multi_col({
				{  702,  489, 0xd1d1d1},
				{  703,  489, 0xeaeaea},
				{  703,  491, 0xf2f2f2},
				{  704,  492, 0xd2d2d2},
				{  705,  494, 0xd6d6d6},
				{  705,  486, 0xd3d3d3},
				{  700,  494, 0xd3d3d3},
				}) then
			ltap(700,  494)
			wwlog("2967 使用小飞鞋")

		elseif  check_right_corder() then
			if auto_click == true then
				ltap(60,  195)
				wwlog("3132 非主线模式--点击左侧第一个任务")
			elseif renwu_flag %6 ==0 then
				ltap(60,  195)
				wwlog("2972 主线模式--长时间没有动--点击左侧第一个任务")
			end
		end
		mmsleep(1000)
		run_app()
		mmsleep(1000)
	end

	--清理背包
	while (bag_clean == false) do
		wwlog("2769 准备整理装备")
		mmsleep(1000)
		safe_place()
		mmsleep(100)
		if multi_col({
				{  500,  575, 0xfffe93},
				{  500,  578, 0xfef9ac},
				{  500,  597, 0xa77542},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				}) then
			ltap( 340,  580) --点击背包
			wwlog("2990 点击背包")
		elseif multi_col({
				{  511,  576, 0xf8f8a0},
				{  507,  579, 0xfef38e},
				{  510,  598, 0xb9864b},
				{  624,  575, 0xffff92},
				{  624,  599, 0xcc994c},
				}) then
			ltap(568,  578) --点击圆球
			mmsleep(2000)
			ltap( 340,  580) --点击背包
			wwlog("3001 点击背包")

		elseif multi_col({
				{  527,   39, 0x5b1a0e},
				{  555,   47, 0xc4976e},
				{  557,   38, 0xf5cc94},
				{  583,   37, 0xf6cd95},
				{  446,  507, 0x71381c},
				{  467,  515, 0xeec48e},
				}) then
			ltap( 929,  508)
			wwlog("2803 整理")
			mmsleep(12000)
			ltap(1011,   64) --关闭装备窗口		
			bag_clean = true
			break	
		else
			ltap(568,  578) --点击圆球			
			-- body
		end
		-- body
	end



	--领取邮件
	while (mail_get == false) do
		wwlog("2828 领取邮件")
		mmsleep(1000)
		safe_place()
		mmsleep(100)
		if multi_col({
				{  500,  575, 0xfffe93},
				{  500,  578, 0xfef9ac},
				{  500,  597, 0xa77542},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				}) then
			ltap( 793,  572) --点击社交
			mmsleep(2000)
			ltap(968,  477) --点击邮件
		elseif multi_col({
				{  535,   82, 0x540905},
				{  548,   82, 0xf2c891},
				{  556,   89, 0xf4cb93},
				{  575,   85, 0xf5cc94},
				{  301,  532, 0x652e17},
				{  322,  536, 0xd2a777},
				})then
			ltap(322,  536) --一键领取
			mmsleep(5000)
			ltap(955,   82)  --关闭邮件窗口
			mmsleep(80)
			mail_get = true
			main_task = true
			bag_clean = false
			wwlog("3054 一键领取")
			break

		elseif multi_col({
				{  511,  576, 0xf8f8a0},
				{  507,  579, 0xfef38e},
				{  510,  598, 0xb9864b},
				{  624,  575, 0xffff92},
				{  624,  599, 0xcc994c},
				}) then
			ltap(568,  578) --点击圆球
			mmsleep(2000)
			ltap( 793,  572) --点击社交
			mmsleep(2000)
			ltap(968,  477) --点击邮件
		else
			ltap(568,  578) --点击圆球			
			-- body
		end
	end
	mmsleep(80)
	check_zhuangbei_hongbao()
	mmsleep(100)

	--领完邮件之后，整理装备,把丹放进仓库
	while (bag_clean == false) do
		wwlog("2896 领完邮件之后，整理装备")
		mmsleep(1000)
		safe_place()
		mmsleep(100)
		if multi_col({
				{  500,  575, 0xfffe93},
				{  500,  578, 0xfef9ac},
				{  500,  597, 0xa77542},
				{  635,  575, 0xffff92},
				{  635,  596, 0xa06d43},
				}) then
			ltap( 340,  580) --点击背包
			wwlog("2990 点击背包")
		elseif multi_col({
				{  511,  576, 0xf8f8a0},
				{  507,  579, 0xfef38e},
				{  510,  598, 0xb9864b},
				{  624,  575, 0xffff92},
				{  624,  599, 0xcc994c},
				}) then
			ltap(568,  578) --点击圆球
			mmsleep(2000)
			ltap( 340,  580) --点击背包
			wwlog("3001 点击背包")

		elseif multi_col({
				{  527,   39, 0x5b1a0e},
				{  555,   47, 0xc4976e},
				{  557,   38, 0xf5cc94},
				{  583,   37, 0xf6cd95},
				{  446,  507, 0x71381c},
				{  467,  515, 0xeec48e},
				}) then
			mmsleep(1000)
			ltap( 929,  508)
			wwlog("2977 整理")
			mmsleep(12000)			
			--------------------------------------------------------------------------
			ltap(171,  282)
			wwlog("2981 点击背包左侧药品")
			mmsleep(3000)
			ltap(930,  506)
			wwlog("2942 点击整理")
			mmsleep(12000)


			ltap(865,  153) --点击第一排第7个格子
			wwlog("2927 点击第一排第7个格子")
			mmsleep(3000)
			ltap( 473,  534) --点击更多
			mmsleep(2000)
			ltap(478,  414) --放入仓库 
			mmsleep(3000)
			ltap(958,  156) --点击第一排第8个格子
			wwlog("2988 点击第一排第8个格子")
			mmsleep(3000)
			ltap( 473,  534) --点击更多
			mmsleep(2000)
			ltap(478,  414) --放入仓库

			mmsleep(10000)
			ltap( 168,  351) --点击其他tab
			mmsleep(3000)
			ltap(290,  155)  --点击第一个格子
			mmsleep(3000)
			ltap(479,  534)  --点击更多
			mmsleep(2000)
			ltap(478,  414) --放入仓库
			mmsleep(10000)

			--[[
			for ii = 1 ,4,1 do
				mmsleep(1000)
				local ret11,x11,y11 = get_yappin_position(ii)

			end
			--]]
			--------------------------------------------------------------------------
			ltap(1011,   64) --关闭装备窗口		
			bag_clean = true
			break	
		else
			ltap(568,  578) --点击圆球			
			-- body
		end
		-- body
	end


	while(jiaoyi_flag == 'S' ) do 
		mmsleep(50000)	
		toast("2965 等待交易......")
		if multi_col({
				{  524,  545, 0xf4df00},
				{  552,  548, 0xf3d500},
				{  587,  544, 0xfbe500},
				{  612,  547, 0xf4d700},
				}) then
			wwlog("2972 交易结束，从新开始选区")
			sleep_cnt = 1
			renwu_flag = 1

			level = 1
			tianlei_flag = 'N'
			yaoshui_shezhi = 'N' --暂时不进行药水的设置
			fuli_flag = 'N'
			in_game = 'N'
			kuangqu_flag = 'N'
			buy_3_first = false
			choose_flag = false 
			before_game = 'Y'
			--beibao_flag = 'N'
			--bag_is_full = false
			main_task = true
			mail_get =false
			bag_clean = false
			bag_full = false  
			--luoxia_shua_guai = false
			jiaoyi_flag ='N'
			only_once1 = true
			first_mail = false
			bag_is_ready = false
			--flag1 = true
			mmsleep(10000) 
			break
		elseif multi_col({
				{  525,  176, 0xe0882e},
				{  542,  182, 0xcd6d29},
				{  606,  183, 0xc76725},
				{  662,  187, 0xaa4d14},
				}) then
			ltap(662,  187)
			wwlog("2913 点击屏幕继续--领取奖励")
		end
	end

	mmsleep(5000)
	run_app()

	wwlog("2804 大循环")

end  -- end while


if TOUCH_MODE == true1 then
	close_log(log_file)		
end	

wwlog("2813 脚本结束")