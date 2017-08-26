DEBUG_MODE =false
TOUCH_MODE= true
XXT_MODE =false
XXT_DAQU = 1

local choose_flag = false

if TOUCH_MODE == true then
	require("TSLib")
end

local open_app
local front_app
local mmsleep
local init_screen
local init_log
local wt_log,wx_log

local log_file = "chuanqishijie"

local multi_col
local press
local before_game = 'Y'
local beibao_flag = 'N'
local bag_is_full = false
local main_task = true
local mail_get =false
local bag_clean = false

local bag_full = false  

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
	local ret, input1
	if TOUCH_MODE == true then		
		ret, input1 =  showUI(json_str)
	elseif XXT_MODE == true then
		ret, input1 = 1, XXT_DAQU
	end	
	return  ret, input1
end 

function run_app_first(...)

	if front_app() == "com.tencent.xin" then
		wwlog("74 微信程序ing...")
	elseif  front_app() ~= "com.tencent.cqsj" then
		mmsleep(200)
		open_app("com.tencent.cqsj")
		wwlog("game start")
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
		before_game = 'Y'
	end
end



function choose_fuwuqi(...)

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
	ret, input1 = showuii(MyJsonString);
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

	--tap(tab_left[idx_left][1],tab_left[idx_left][2])

	mmsleep(2000)

	tap(tab_right[idx_right][1],tab_right[idx_right][2])

	mmsleep(2000)
	return fuwuqi
	-- body
end

function check_bag(...)
	wwlog("215 检测背包忽大忽小图标")
	--local ret = false
	local ret2 = false		
	mmsleep(80)
	--for i = 1 ,5,1 do
	--wwlog("220 第一遍检测忽大忽小图标")
	--mmsleep(200)
	--keepScreen(true)

	if multi_col({
			{  586,  476, 0x1c0e08},
			{  579,  488, 0x170c07},
			{  593,  487, 0xd49956},
			{  589,  502, 0xa95c30},
			}) then
		ret2 = true		
	elseif multi_col({
			{  621,  482, 0x22130a},
			{  625,  502, 0x140a06},
			{  615,  496, 0xfffbba},
			{  603,  493, 0xffecae},
			}) then
		ret2= true
	elseif multi_col({
			{  591,  487, 0xe4b16e},
			{  610,  487, 0xc48858},
			{  592,  497, 0xdda55a},
			{  600,  504, 0xbb5c2c},
			})then
		ret2 =true
	elseif multi_col({
			{  587,  482, 0x1e1009},
			{  590,  491, 0xd49958},
			{  583,  489, 0x170c07},
			{  612,  505, 0xded1bd},
			})then
		ret2= true
	elseif multi_col({
			{  596,  489, 0xfbeece},
			{  608,  489, 0xedc471},
			{  593,  495, 0xe4ad66},
			{  607,  501, 0x7a361f},
			}) then
		ret2 = true
	elseif multi_col({
			{  586,  477, 0x140b06},
			{  589,  477, 0x1b0e08},
			{  589,  481, 0x201109},
			{  584,  485, 0x1a0d07},
			})then
		ret2 = true
	end
	return ret2
end

function check_bag3(...)
	wwlog("215 检测背包忽大忽小图标")
	local ret = false
	local ret2 = false		
	mmsleep(80)
	--for i = 1 ,5,1 do
	wwlog("220 第一遍检测忽大忽小图标")
	mmsleep(200)
	--keepScreen(true)

	if multi_col({
			{  586,  476, 0x1c0e08},
			{  579,  488, 0x170c07},
			{  593,  487, 0xd49956},
			{  589,  502, 0xa95c30},
			}) then
		ret2 = true		
	elseif multi_col({
			{  621,  482, 0x22130a},
			{  625,  502, 0x140a06},
			{  615,  496, 0xfffbba},
			{  603,  493, 0xffecae},
			}) then
		ret2= true
	elseif multi_col({
			{  591,  487, 0xe4b16e},
			{  610,  487, 0xc48858},
			{  592,  497, 0xdda55a},
			{  600,  504, 0xbb5c2c},
			})then
		ret2 =true
	elseif multi_col({
			{  587,  482, 0x1e1009},
			{  590,  491, 0xd49958},
			{  583,  489, 0x170c07},
			{  612,  505, 0xded1bd},
			})then
		ret2= true
	elseif multi_col({
			{  596,  489, 0xfbeece},
			{  608,  489, 0xedc471},
			{  593,  495, 0xe4ad66},
			{  607,  501, 0x7a361f},
			}) then
		ret2 = true
	elseif multi_col({
			{  586,  477, 0x140b06},
			{  589,  477, 0x1b0e08},
			{  589,  481, 0x201109},
			{  584,  485, 0x1a0d07},
			})then
		ret2 = true
		--[[
		elseif multi_col({
				{  518,  478, 0x1e1009},
				{  551,  483, 0x1e1009},
				{  542,  490, 0xedc57b},
				{  520,  490, 0xd49757},
				}) then
			ret2 = true
			--x,y = findMultiColorInRegionFuzzy( 0x1e1009, "33|5|0x1e1009,24|12|0xedc57b,2|12|0xd49757", 90, 0, 0, 1135, 639)
		elseif multi_col({
				{  517,  479, 0x1c0f08},
				{  514,  486, 0x1e1009},
				{  522,  491, 0xc68449},
				{  523,  505, 0xf1e4ce},
				}) then
			ret2 = true	
			--x,y = findMultiColorInRegionFuzzy( 0x1c0f08, "-3|7|0x1e1009,5|12|0xc68449,6|26|0xf1e4ce", 90, 0, 0, 1135, 639)
		elseif multi_col({
				{  521,  488, 0xd49154},
				{  537,  487, 0xecc067},
				{  521,  496, 0xd99e56},
				{  540,  495, 0xeec170},
				{  549,  483, 0x22130a},
				}) then
			ret2 = true
			--x,y = findMultiColorInRegionFuzzy( 0xd49154, "16|-1|0xecc067,0|8|0xd99e56,19|7|0xeec170,28|-5|0x22130a", 90, 0, 0, 1135, 639)
		elseif multi_col({
				{  518,  480, 0x201209},
				{  520,  488, 0xd8995c},
				{  520,  501, 0xb76832},
				{  510,  489, 0x100804},
				})then
			ret2 = true
			--x,y = findMultiColorInRegionFuzzy( 0x201209, "2|8|0xd8995c,2|21|0xb76832,-8|9|0x100804", 90, 0, 0, 1135, 639)
		elseif multi_col({
				{  550,  483, 0x22130a},
				{  549,  476, 0xd4ab75},
				{  544,  488, 0xfddf99},
				{  554,  492, 0x1b0e08},
				}) then
			ret2 =true
			--x,y = findMultiColorInRegionFuzzy( 0x22130a, "-1|-7|0xd4ab75,-6|5|0xfddf99,4|9|0x1b0e08", 90, 0, 0, 1135, 639)
		]]--
	end
	--keepScreen(false)
	--[[
		if ret2 == true then
			break
		end	
		]]--
	--end
	mmsleep(80)
	if ret2 == true then
		ltap(602,  491)
		mmsleep(1000)
		if multi_col({
				{  937,  574, 0xe6e5e4},
				{  944,  574, 0xe6e5e4},
				{  943,  579, 0xc7c4c3},
				{  941,  582, 0xe4e3e2},
				{  953,  574, 0xd7d5d3},
				{  949,  578, 0xe2e1e1},
				{  956,  583, 0xe7e7e7},
				{  954,  588, 0xd6d6d6},
				{  951,  588, 0xd7d6d6},
				}) then
			ret = true
		end
		ltap( 1010,   64) --关闭背包
		-- body		
	end
	return ret
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
	local ret =0
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
		wwlog("272 点击红篮球，复位底部任务栏")
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
		wwlog("复位顶部活动栏")
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
	end
	return  ret
	-- body
end

function find_dialog(...)
	local ret = 'N'
	if multi_col({
			{ 1000,   58, 0x64151a},
			{ 1000,   72, 0x52271a},
			{ 1021,   71, 0xa36737},
			{ 1019,   56, 0xe0b760},
			{ 1012,   63, 0xd6aa6b},
			}) then
		ret = 'Y'
	end
	return ret
	-- body
end

function find_lock_icon_inbag(...)
	mmsleep(80)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0x1c1713, "-17|-7|0x423f3a,4|-3|0x43403b,-4|12|0x1d1a15,-14|12|0x3e3b36", 90, 239,  101, 990,  473)
	if x~= -1 and y ~= -1 then
		ret = true	
		wwlog("617  背包到底了，不用往下拉拉")
		--cangku_red ='N'				
	else 
		wwlog("620 没有到底，继续往下拉")
	end
	return ret
	-- body
end

function find_lock_icon_in_warehouse(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0x1c1713, "-17|-7|0x423f3a,4|-3|0x43403b,-4|12|0x1d1a15,-14|12|0x3e3b36", 90, 642,  134, 1005,  534)
	if x~= -1 and y ~= -1 then
		ret = true	
		wwlog("631  仓库到底了，不用往下拉拉")
		--cangku_red ='N'				
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x44413c, "21|0|0x44413c,14|12|0x44413c,13|18|0x1d1a15", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true	
			wwlog("640  仓库到底了，不用往下拉拉")
			--cangku_red ='N'				
		end
	end

	return ret
	-- body
end

function get_locked_red_bak(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0xc53838, "-21|9|0x6b3d07,-25|7|0xab7108,-12|20|0xcecece,-13|-4|0xffffff", 85,  243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1001 点击背包中红色药水")		
	end
	-- body
	return ret
end

function get_locked_red(...)
	mmsleep(500)
	local ret = false
	local x,y
	x,y = findMultiColorInRegionFuzzy( 0xc53838, "-21|9|0x6b3d07,-25|7|0xab7108,-12|20|0xcecece,-13|-4|0xffffff", 85,  243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		--ltap(x,y)
		--wwlog("659 点击背包中红色药水")		
	end
	mmsleep(500)
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbd3335, "7|-1|0xac3340,4|-4|0xfffcfc,-8|1|0x9d6a05,-7|8|0xbb7d0a", 90, 243,  105, 1010,  474)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("669 点击背包中红色药水")			
		end	
	end 
	mmsleep(80)
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbc4447, "-5|0|0xffffff,-2|5|0x8e2222,-17|5|0x9f6b06,-17|12|0xb87907", 90, 243,  105, 1010,  474)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("680 点击背包中红色药水")			
		end	
	end 

	mmsleep(80)
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbd7c08, "4|0|0xd19213,19|-11|0xd5434a,13|-13|0xffffff,22|-34|0x400f11", 90, 243,  105, 1010,  474)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("680 点击背包中红色药水")			
		end	
	end 


	if ret == false then
		wwlog("672 not found locked red")
		mmsleep(200)
		if not find_lock_icon_inbag() then 
			mmsleep(80)
			moveTo(860,  446,860,  235,3)	
			mmsleep(1000)
			return get_locked_red()
		end
	end	
	-- body
	return ret,x,y
end

--仓库中取出红色药水
function fetch_locked_red(...)
	mmsleep(500)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0xc53838, "-21|9|0x6b3d07,-25|7|0xab7108,-12|20|0xcecece,-13|-4|0xffffff", 85,  642,  134, 1005,  534)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("693 点击仓库中红色药水")
		--cangku_red ='N'					
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbd3335, "7|-1|0xac3340,4|-4|0xfffcfc,-8|1|0x9d6a05,-7|8|0xbb7d0a", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("703 点击仓库中红色药水")
			--cangku_red ='N'		
		end	
	end 
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x9f2525, "3|-1|0xddacb4,3|4|0x863838", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("713 点击仓库中红色药水")
			--cangku_red ='N'		
		end	
	end 

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbb444f, "-5|0|0xeeeeee,1|4|0xc73944", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("724 点击仓库中红色药水")
			--cangku_red ='N'		
		end	
	end 
	mmsleep(80)
	if ret == false then
		wwlog("730 not found locked red")
		if not find_lock_icon_in_warehouse() then 
			mmsleep(80)
			moveTo(775,  503,774,  240,5)	
			mmsleep(1000)
			return fetch_locked_red()
		end
	end	
	-- body
	return ret
end


--仓库中取出锁定药水
function fetch_locked(...)
	wwlog("771 取出仓库中的药水")
	mmsleep(500)
	local ret = false
	local x,y

	x,y = findMultiColorInRegionFuzzy( 0xc0c0c0, "-1|4|0xcecece,3|6|0xc2c2c2,6|5|0xdadada", 90, 642,  134, 1005,  534)
	if x~= -1 and y ~= -1 then
		ret = true
		--ltap(x,y)
		--wwlog("779 点击仓库中的锁定药水")	
		x = x + 30
		y = y - 20
		wwlog("781 找白边")
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x4bc64d, "-1|5|0x52d855,3|8|0x53db55,5|9|0x4ac54c", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("779 点击仓库中的锁定药水")		
			x = x + 35
			y = y - 25
			wwlog("781 找绿边")
		end
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xc38407, "-3|7|0x9e6807,5|13|0x764a1c", 90, 642,  134, 1005,  534)	
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("779 点击仓库中的锁定药水")				
		end
	end



	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xca8e10, "-4|0|0xb27408,2|3|0x794a12", 90, 642,  134, 1005,  534)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("789 点击仓库中的锁定药水")			
		end	
	end 

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xbe8107, "-3|7|0x9a6406,3|7|0xb9800e", 90, 642,  134, 1005,  534)		
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("800 点击仓库中的锁定药水")			
		end	
	end 
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xdda10a, "-5|0|0xab7208,-6|-7|0xb67c06", 90, 642,  134, 1005,  534)

		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("811 点击仓库中的锁定药水")			
		end	
	end 


	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x966405, "5|8|0xbb8012,-1|7|0x845606", 90, 642,  134, 1005,  534)

		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("813 点击仓库中的锁定药水")			
		end	
	end  

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x9e6a05, "0|7|0xb47507,6|7|0xf3b60c", 90, 642,  134, 1005,  534)

		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("825 点击仓库中的锁定药水")			
		end	
	end  

	mmsleep(80)
	if ret == false then
		wwlog(100)
		wwlog("797 not found locked ")
		if not find_lock_icon_in_warehouse() then 
			mmsleep(80)
			moveTo(775,  503,774,  280,5)	
			mmsleep(1000)
			return fetch_locked()
		end
	end	
	-- body
	return ret,x,y
end

function check_cangku_scroll(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0x1e1915, "34|1|0x1c1814,29|7|0x494540,8|11|0x3b3833,18|18|0x44413c,21|24|0x1c1914", 90, 640,  105, 1013,  525)
	if x~= -1 and y ~= -1 then
		ret = true
		wwlog("1098 点击仓库中的红色药水")			
	end
	mmsleep(80)
	x,y = findMultiColorInRegionFuzzy( 0x45423d, "-2|14|0x403d38,10|29|0x3c3934,23|16|0x3e3b36,10|8|0x1c1914", 90, 640,  105, 1013,  525)
	if x~= -1 and y ~= -1 then
		ret = true
		wwlog("1098 点击仓库中的红色药水")			
	end
	return ret
end


function get_locked_blue(...)
	local ret = false
	local x,y
	x,y = findMultiColorInRegionFuzzy( 0xe8f7fc, "-2|4|0x363bbd,-9|6|0xcb8a07,-10|13|0xb47707", 85,  243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		--ltap(x,y)
		--wwlog("1016 点击背包中蓝色药水")		
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x393ac1, "0|2|0x4046cc,-7|2|0xa76f06,-8|9|0xb67607", 90, 243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("1027 点击背包中蓝色药水")			
		end
	end
	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x3d44c4, "4|-1|0xecedef,2|4|0x322287,-7|2|0xba7e07", 90, 0, 0, 1135, 639)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("372 点击背包中蓝色药水")			
		end
	end

	if ret == false then
		wwlog("903 not found locked blue")
		mmsleep(5000)
		if not find_lock_icon_inbag() then 
			mmsleep(80)
			moveTo(860,  446,860,  280,3)	
			mmsleep(1000)
			return get_locked_blue()
		end
	end		
	return ret,x,y
end

function get_locked_gold(...)
	local ret = false
	local x,y
	x,y = findMultiColorInRegionFuzzy( 0xb07709, "3|0|0xc0850f,12|-13|0xfdcd45,12|-18|0xffe766", 90, 243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		--ltap(x,y)
		--wwlog("896 点击背包中太阳神水")		
	end

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x885907, "-4|0|0x734905,12|-2|0xbb5502,17|-7|0xebc95f", 90, 243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("907 点击背包中太阳神水")			
		end
	end	

	if ret == false then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xc6850a, "3|0|0xd19213,16|-3|0xcc9254,16|-12|0xf5cc88", 90, 243,  105, 1010,  474)		
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("907 点击背包中太阳神水")			
		end
	end	

	if ret == false then
		mmsleep(500)		
		x,y = findMultiColorInRegionFuzzy( 0xffbb22, "6|-1|0xdd7700,1|10|0xc57534,7|5|0xedca43", 90, 243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("907 点击背包中太阳神水")			
		end
	end	
	
	if ret == false then
		mmsleep(500)		
		x,y = findMultiColorInRegionFuzzy( 0xd2a533, "8|0|0xb8912e,10|11|0x57e65a,4|4|0xfbe882", 90, 243,  105, 1010,  474)		
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			--ltap(x,y)
			--wwlog("907 点击背包中太阳神水")			
		end
	end	



	if ret == false then
		wwlog("923 not found locked gold")
		mmsleep(5000)
		if not find_lock_icon_inbag() then 
			mmsleep(80)
			moveTo(860,  446,860,  280,3)	
			mmsleep(1000)
			return get_locked_gold()
		end 
	end	

	return ret,x,y
end

function get_locked_gold_back(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0xffd54c, "2|8|0xf7b322,-8|22|0x4f2d09,-12|12|0xce8d07", 85,  243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1030 点击背包中太阳神水")			
	end
	mmsleep(100)
	x,y = findMultiColorInRegionFuzzy( 0xf4d04c, "-1|4|0xc6a328,1|14|0xe0b83c,-11|7|0xa76f06,-11|14|0xbc7e0a", 90, 243,  105, 1010,  474)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1049 点击背包中太阳神水")			
	end
	-- body
	return ret
end

function get_unlocked_blue(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0x3332aa, "5|5|0x4433bb,-14|19|0xdedddd,-25|-12|0xd6d6d6,4|-47|0xfcfcfc", 85, 244,  107, 999,  193)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("979 点击背包中蓝色药水")
		--find_red ='Y'
	end

	if ret == false then
		mmsleep(100)
		x,y = findMultiColorInRegionFuzzy( 0x392e9d, "2|-4|0xf4f4ee,17|-1|0x5577c4", 90, 244,  107, 999,  193)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("989 点击背包中蓝色药水")
			--find_red ='Y'
		end
	end
	-- body
	return ret
end

function get_unlocked_red(...)
	local ret = false
	--x,y = findMultiColorInRegionFuzzy( 0xbb4447, "8|0|0xf1e3e3,1|4|0xbb3333,34|-5|0xc3c3c3,4|-21|0x431111", 85,  243,  105, 1010,  474)
	x,y = findMultiColorInRegionFuzzy( 0xa4383c, "2|-3|0xfcefef,4|0|0xb6414f,-12|8|0x251007", 90, 244,  107, 999,  193)
	mmsleep(80)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1005 点击背包中红色药水")
		--find_red ='Y'
	end
	if ret == false  then
		mmsleep(500)
		x,y = findMultiColorInRegionFuzzy( 0xce4446, "-8|2|0xfff8f8,7|6|0xcf3f44,6|-1|0xf9f6f6", 90, 244,  107, 999,  193)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1014 点击背包中红色药水")
			--find_red ='Y'
		end
	end
	-- body
	return ret
end

function find_locked_gold(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0xd9990a, "-3|-1|0xb87d06,0|11|0x623b11,-6|12|0x52300b", 85,  642,  134, 1005,  534)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1028 点击仓库中的太阳神水")			
	end
	return ret
	-- body
end

function find_locked_blue(...)
	local ret = false
	x,y = findMultiColorInRegionFuzzy( 0xce9009, "-3|-1|0xb67c06,2|7|0xb97e0d,-6|7|0x774706", 85,  642,  134, 1005,  534)

	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1041 点击仓库中的蓝色药水")			
	end
	wwlog("1086 find blue in cangku")
	return ret
	-- body
end


function find_locked_red(...)
	local ret = false

	x,y = findMultiColorInRegionFuzzy( 0xbe8107, "-5|7|0x8e5909,-1|7|0x9f6706,-4|11|0x573209", 85,  642,  134, 1005,  534)
	if x~= -1 and y ~= -1 then
		ret = true
		ltap(x,y)
		wwlog("1056 点击仓库中的红色药水")			
	end
	return ret
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

function debug_func(...)
	if multi_col({
			{   79,  167, 0xd7b362},
			{   50,  169, 0xc02835},
			{   73,  165, 0xf7e574},
			{   98,  168, 0xf0d970},
			{  125,  165, 0xf0dc71},
			{  138,  171, 0xf1df71},
			{  135,  168, 0xd5ba64},
			})then
		wwlog("760 调试模式，设置全局变量")
		beibao_flag = 'Y'
		--main_task = false
	end
	-- body
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

local sleep_cnt = 1
local renwu_flag = 1
run_app_first()
local level = 1
--local jineng_flag ='N'
local tianlei_flag = 'N'
local yaoshui_shezhi = 'N'
local fuli_flag = 'N'
local in_game = 'N'
local kuangqu_flag = 'N'
local dialog_flag = 'N'
--local check_bag = 'N'
--启动游戏并进入游戏
-----------------------------------------------------------------------------------------
while (true) do 
	renwu_flag = renwu_flag +1
	mmsleep(500)
	resethome()
	mmsleep(500)
	level =getcurlevel()
	mmsleep(500)
	in_game = is_in_game()
	mmsleep(500)

	if tianlei_flag =='N' then
		tianlei_flag =get_tianlei_flag()
	end
	if level >0 or tianlei_flag =='Y' or in_game =='Y' then
		before_game = 'N'
	end 

	--[[
	if check_bag() then
		tianlei_flag ='Y'
		yaoshui_shezhi = 'Y'
		kuangqu_flag = 'Y'
	end
	]]--

	if before_game =='N' then
		if check_bag2() then
			tianlei_flag ='Y'
			yaoshui_shezhi = 'Y'
			--kuangqu_flag = 'Y'
			--beibao_flag = 'Y'

			bag_full = true
		end
	end
	--dialog_flag =find_dialog()

	mmsleep(100)
	debug_func()
	mmsleep(100)

	while (before_game == 'Y') do
		mmsleep(1000)
		wwlog("898 before log in game"..before_game)
		if multi_col({
				{  919,   75, 0x9d702a},
				{  922,   95, 0xdbb16a},
				{  923,  116, 0xfada80},
				{  891,   99, 0xa97144},
				{  886,   96, 0xae8050},
				{  882,   95, 0x4f1415},
				})then
			ltap(882,   95)
			wwlog("333 点击公告")
		elseif multi_col({
				{  211,  516, 0x82d943},
				{  226,  524, 0xeff3f3},
				{  238,  514, 0x415f2b},
				{  282,  509, 0x43642c},
				{  298,  518, 0xdedfdc},
				}) then
			ltap(298,  518)
			wwlog("79 点击微信")
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
			wwlog("307 微信确认登陆")
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
			wwlog("353 打开微信")
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
				wwlog("89 点击进入游戏")			
			else
				ltap(692,  480) --点击换服
				mmsleep(1000)
				v_choose = choose_fuwuqi()
				mmsleep(1000)
				if v_choose ~= nil then
					choose_flag = true
				end
				wwlog("175 点击换服")
			end
		elseif multi_col({
				{  543,  409, 0x6a341a},
				{  547,  423, 0x5a2718},
				{  557,  419, 0xf2c892},
				{  581,  418, 0xf3ca93},
				{  570,  419, 0x582818},
				})then
			ltap(570,  419)
			wwlog("350 角色名称重复 ,点击确定")
		elseif multi_col({
				{  698,  575, 0xce9c61},
				{  698,  586, 0xba703c},
				{  700,  578, 0x221108},
				{  706,  578, 0x231108},
				{  928,  576, 0x601213},
				}) then
			ltap(928,  576)
			before_game = 'N'
			wwlog("360 直接点击开始游戏")
			break

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
			wwlog("405 请点击继续")
			before_game = 'N'
		elseif multi_col({
				{  518,  175, 0x816856},
				{  539,  177, 0xeac38f},
				{  369,  438, 0x652f1b},
				{  416,  439, 0x67311c},
				})then
			ltap(416,  439)
			wwlog("368 回城复活")	
		elseif multi_col({
				{  910,  608, 0xfbfbfa},
				{  924,  611, 0xfdfdfd},
				{  941,  608, 0xfbfbfb},
				{  961,  610, 0xfdfdfd},
				{  989,  609, 0xfbfbfa},
				}) then
			ltap(989,  609)
			wwlog("423 请点击继续")
		end	
	end
	-----------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------
	while tianlei_flag =='N' do
		wwlog("1189 配置完天雷技能之前的任务"..tianlei_flag)	
		if level ==1 then
			ltap(79,  196) --第一次点击任务
		end
		mmsleep(1000)

		--[[
		if multi_col({
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
			wwlog("514 立即装备")
			]]--	
		if multi_col({
				{  398,  371, 0xbd56e2},
				{  398,  403, 0xb955df},
				{  398,  436, 0xba56e0},
				{  464,  370, 0xe068ec},
				{  761,  402, 0x362720},	
				})then
			ltap(834,  403)
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
			wwlog("427 保持流畅模式")
		elseif multi_col({
				{  910,  608, 0xfbfbfa},
				{  924,  611, 0xfdfdfd},
				{  941,  608, 0xfbfbfb},
				{  961,  610, 0xfdfdfd},
				{  989,  609, 0xfbfbfa},
				}) then
			ltap(989,  609)
			wwlog("487 请点击继续")			
		elseif multi_col({
				{  928,  249, 0x1b1f33},
				{  938,  261, 0x222251},
				{  933,  290, 0x538bda},
				{  934,  321, 0x5a76a6},
				{  915,  328, 0x6084bb},
				{  934,  308, 0x300e0d},
				})then
			ltap(932,  401) --点击天雷咒
			mmsleep(2000)
			ltap(  564,  573) --点击红蓝球
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

			--[[
			elseif multi_col({
					{   32,  121, 0xaa332e},
					{   40,  127, 0xc6332e},
					{   40,  134, 0xaa2222},
					{   52,  126, 0xdd463f},
					{   51,  134, 0xbd3333},
					{   65,  136, 0xb63232},
					})then
				ltap(88,  202)
				wwlog("849 点击主任务")
				]]--
		end	
		if tianlei_flag =='N' then
			tianlei_flag =get_tianlei_flag()	
			--[[
			if sleep_cnt  >10 then
				ltap(60,  195)
				wwlog("786 长时间没有响应，点击左侧任务栏")
				sleep_cnt =1
			end
			--]]
		end
		sleep_cnt =sleep_cnt + 1
	end

	----------------------------------------------------------------------
	----------------------------------------------------------------------
	dialog_flag =find_dialog()
	wwlog("tianlei_flag:"..tianlei_flag.."yaoshui_shezhi:"..yaoshui_shezhi.."dialog_flag:"..dialog_flag)
	resethome()
	--设置，买药，领取奖励
	while (tianlei_flag=='Y' and yaoshui_shezhi == 'N' 
		--and dialog_flag =='N'
		) do
		mmsleep(1000)
		wwlog("1223 药水设置")

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
	mmsleep(1000)
	local yaoshui_cnt =0
	while (fuli_flag =='N' and yaoshui_shezhi =='Y') do
		wwlog("1330 设置药水")
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
		if yaoshui_cnt >100 then
			yaoshui_cnt = 0
			break
		end

	end


-----------------------------落霞岛药水-------------------------------------
	local cnt1 = 0
	resethome()
	while true do 
		wwlog("1568 打怪刷药水 ")
		cnt1 =cnt1 +1
		mmsleep(1000)
		if multi_col({
				{ 1080,  311, 0xefddca},
				{ 1080,  317, 0xfffedc},
				{ 1113,  312, 0xffffec},
				{ 1112,  321, 0xffffff},
				{ 1096,  311, 0xfdecea},
				}) then
			ltap(1096,  311)
			wwlog("1576 自动攻击")
		end

		if cnt1 > 60 then -- 打怪刷药水 3分钟
			wwlog("1583 打怪刷药水 3分钟")

			ltap(1083,   45) -- 点击右上角落霞岛地图
			mmsleep(500)
			ltap( 876,  454) --点击书店老板
			mmsleep(15000)  --15秒的路程
			ltap(565,  576) --点击屏幕底部，
			mmsleep(100)
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
			mmsleep(300)
			ltap(473,  510) --点击分解
			mmsleep(2000)
			if multi_col({
					{  520,  391, 0x604d31},
					{  510,  402, 0x130b07},
					{  504,  408, 0x100906},
					{  498,  400, 0x130b07},
					})then 
				ltap(506,  401)	 --勾选白色装备
			end	
			mmsleep(2000)
			if multi_col({
					{  682,  392, 0x56442c},
					{  666,  408, 0x100906},
					{  660,  398, 0x130b07},
					}) then	
				ltap(667,  397)	 --勾选绿色装备
			end		
			mmsleep(2000)
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
			mmsleep(100)
			--ltap(928,  507) --点击背包的整理按钮----
			--mmsleep(12000) --整理背包冷却时间
			ltap(1010,65 ) --关闭背包对话框
			mmsleep(200)

			break
		end
	end

	while (bag_full == false) do
		mmsleep(1000)
		wwlog("1452 购买药水，以便塞满背包")
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
		function location(...) --左侧函数栏定位函数
			-- body
		end
		--for j = 1 ,3,1 do --1 ：处理红色药水， 2： 处理蓝色药水，3：处理太阳神水
		for j = 1 ,3,1 do --1  开发测试阶段暂时只处理红色药水	
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
			snapshot("abc"..tostring(j)..".png", 0, 0, 1135, 639)
			--for i=1, 30,1 do --背包的仓库，有30个格子
			for i=1, 30,1 do--暂时开发测试，一遍循环
				mmsleep(200)
				ltap(338,  576) --点击背包
				mmsleep(500)
				local get_unlocked ,get_locked
				if j == 1 then
					get_unlocked = get_unlocked_red
					get_locked = get_locked_red
				elseif j == 2 then
					get_unlocked = get_unlocked_blue
					get_locked = get_locked_blue
				elseif j == 3 then
					get_unlocked = get_unlocked_red --太阳神水没有非绑定的，通过买红进入药店
					get_locked = get_locked_gold
				end	
				if get_unlocked() then
					local ret,x,y
					mmsleep(1000)
					ltap(568,  373) --点击药店
					mmsleep(1000)
					if j ==1 then
						ltap(  596,  160) --点击第一个红药水
					elseif j ==2 then
						ltap(  783,  163) --点击第二个蓝药水
					elseif j ==3 then
						ltap(501,  268)
					end
					mmsleep(1000)
					if j ==3 then
						for i=1,5,1 do -- 测试，先一组买6个太阳神水,以免金币花光，无法测试
							mmsleep(200)
							ltap(690,  366)
						end	
					end
					mmsleep(1000)
					ltap(656,  543) --点击确定--购买
					mmsleep(3000)
					ltap( 1011,   65) --点击关闭药店
					mmsleep(500)
					ret,x,y = get_locked()
					if ret == true then
						ltap(x,y) --点击找到的locked药水坐标	
						mmsleep(1000)
						ltap(478,  534) --点击更多
						mmsleep(500)
						ltap(476,  414) --放仓库
					end					
					mmsleep(1000)
					ltap(1010,65 ) --关闭背包
				end
			end
			mmsleep(500)
			ltap(338,  576) --点击背包
			mmsleep(500)
			ltap(1079,  292) --点击仓库
			mmsleep(500)
			for i= 1,30,1 do 
				mmsleep(1000)
				local ret ,x,y = fetch_locked()

				if ret ==  true  then
					mmsleep(500)
					ltap(x,y) --点击药水
					mmsleep(500)
					ltap( 563,  533) --点击取出
				else
					wwlog("1632 仓库没有药水了")
					mmsleep(200)
					ltap(1010,65 ) --关闭背包
					break
				end	
			end
			if j ==3 then
				bag_full = true
			end
		end

		if bag_full == true then
			break
		end
	end

	--[==[
	wwlog(kuangqu_flag)
	mmsleep(200)
	local kuang_qu_flag1 = 'N'
	local shua_guai_dian ='N'
	local shua_guai_time = 0
	------------------------------区落霞岛刷装备-------------------------------------
	while ( kuangqu_flag =='N' --and dialog_flag =='N'
		) do
		mmsleep(1000)
		shua_guai_time = shua_guai_time +1
		wwlog("893 进入落霞岛刷装备")
		mmsleep(80)
		if check_bag()==true then

			ltap(602,  491)
			mmsleep(1000)
			if multi_col({
					{  937,  574, 0xe6e5e4},
					{  944,  574, 0xe6e5e4},
					{  943,  579, 0xc7c4c3},
					{  941,  582, 0xe4e3e2},
					{  953,  574, 0xd7d5d3},
					{  949,  578, 0xe2e1e1},
					{  956,  583, 0xe7e7e7},
					{  954,  588, 0xd6d6d6},
					{  951,  588, 0xd7d6d6},
					}) then				
				wwlog("1264 背包已满")
				kuangqu_flag ='Y'
			end
			ltap( 1010,   64) --关闭背包


		elseif check_zhuangbei_hongbao() then
			wwlog("1091 有装备或者红包")
		elseif multi_col({
				{ 1047,   31, 0xf3c992},
				{ 1058,   31, 0xf3c992},
				{ 1067,   32, 0xeabe8a},
				{ 1089,   31, 0xf6cd95},
				{ 1088,   38, 0xf5ca93},
				{ 1029,   51, 0x65f663},
				}) then
			ltap(1029,   51)
			wwlog("857 点击右上角落霞岛")
		elseif multi_col({
				{ 1097,  319, 0xac9977},
				{ 1079,  332, 0x665844},
				{ 1088,  351, 0xccccbb},
				{ 1105,  350, 0xefdece},
				{ 1113,  353, 0xf3e3d2},
				}) then
			ltap(1113,  353)
			wwlog("1080 点击自动攻击按钮")
		elseif multi_col({
				{  358,  123, 0x360e0c},
				{  379,  114, 0xe9d86e},
				{  420,  122, 0x390f0b},
				{  367,  319, 0x000000},
				{  249,  483, 0xfccb72},
				}) and shua_guai_dian == 'N' then
			ltap(  301,  325)
			mmsleep(2000)
			ltap(1010,   63) --关闭地图
			wwlog("1091 矿区地图，去刷怪点1爆装备")
			shua_guai_dian = 'Y'
			kuangqu_flag= 'Y' --------------------------------------------------
		elseif multi_col({
				{  374,  119, 0x3c100b},
				{  399,  118, 0xe3d069},
				{  421,  115, 0xf9ea76},
				{  620,  306, 0xf4c275},
				{  632,  308, 0x5b3021},
				}) then
			ltap(633,  302)
			wwlog("866 点击落霞岛地图矿区入口")
		elseif multi_col({
				{ 1039,   31, 0xf3c892},
				{ 1048,   37, 0x883333},
				{ 1063,   36, 0xf3c892},
				{ 1067,   37, 0x883333},
				}) and kuang_qu_flag1 =='N' then
			ltap(1067,   37)
			wwlog("920 点击右上角矿区入口")
			kuang_qu_flag1 = 'Y'

		end
		if shua_guai_time >20 then
			shua_guai_dian = 'N'
			shua_guai_time=0
		end 
		mmsleep(80)

		mmsleep(80)
		resethome()		
		-- body
	end
	-----------------------------------------自动买药水-----------------------------

	local find_red='N'
	local find_blue='N'
	local cangku_red = 'N'
	local buy_cnt = 0
	--resethome()
	while (beibao_flag =='N' ) do
		wwlog("1552 购买药水")
		--dialog_flag =find_dialog()
		mmsleep(1500)

		if multi_col({
				{  937,  574, 0xe6e5e4},
				{  944,  574, 0xe6e5e4},
				{  943,  579, 0xc7c4c3},
				{  941,  582, 0xe4e3e2},
				{  953,  574, 0xd7d5d3},
				{  949,  578, 0xe2e1e1},
				{  956,  583, 0xe7e7e7},
				{  954,  588, 0xd6d6d6},
				{  951,  588, 0xd7d6d6},
				}) then
			ltap(1010,   62)
			wwlog("背包已满，关闭窗口")
			beibao_flag ='Y'
			bag_is_full =  true
			break
		elseif check_zhuangbei_hongbao() then
			wwlog("1091 有装备或者红包")		
		elseif multi_col({
				{  525,   40, 0x5b190e},
				{  559,   44, 0xf3ca93},
				{ 1059,  279, 0xb48765},
				{ 1055,  286, 0xb78967},
				{ 1062,  314, 0xb28564},
				}) and buy_cnt >5 then 
			ltap(1062,  314)
			wwlog("1113 批量购买完药水之后，开始从仓库取出")
		elseif multi_col({
				{  599,   90, 0xc52d2c},
				{  610,   90, 0xd22e2e},
				{  540,  531, 0x6f371c},
				{  549,  533, 0xf6cd95},
				{  579,  537, 0xd5ab7b},
				}) then
			ltap(579,  537)
			wwlog("1161 点击取出")
		elseif multi_col({
				{ 1059,  282, 0x780804},
				{ 1063,  289, 0xe7b382},
				{  725,  115, 0x332620},
				{  734,  119, 0xe6bf8c},
				{  734,  126, 0xe4bd8a},
				}) then
			local more_flag = 'N'
			local scroll_flag = 'Y'
			mmsleep(100)
			if find_locked_red() then
				mmsleep(80)
				more_flag = 'Y'
				wwlog("1161")
			elseif find_locked_blue() then
				more_flag = 'Y'
				mmsleep(80)
				wwlog("1163")
			elseif find_locked_gold() then
				more_flag = 'Y'
				mmsleep(80)
				wwlog("1165")
			elseif check_cangku_scroll() then
				scroll_flag ='N'
			end	
			mmsleep(80)
			wwlog("1216 从仓库中多点取色，找到药水，并点击")
			if more_flag == 'N' and scroll_flag =='Y' then 
				moveTo(871,  462,871,  286)
			elseif  more_flag == 'N' then
				ltap(1011,   65)
				wwlog("1208 关闭仓库")
				beibao_flag = 'Y'
				kuangqu_flag ='N' --重新打装备
			end 
			mmsleep(80)			
		elseif multi_col({
				{  449,  533, 0x69311c},
				{  460,  534, 0xe5ba86},
				{  473,  533, 0xefc58f},
				{  443,  417, 0x4e2315},
				{  483,  414, 0xdab07f},
				})then
			ltap(475,  414)
			mmsleep(80)
			wwlog("1068 点击放入仓库")
			--find_red = 'N'
			--cangku_red = 'N'
		elseif multi_col({
				{  601,   84, 0xb52c2a},
				{  598,   90, 0xcc2d2d},
				{  624,   90, 0xc92d2d},
				{  645,   92, 0xc92d2d},
				{  455,  538, 0x522516},
				{  475,  536, 0xf1c891},
				}) then
			ltap(475,  536)
			wwlog("1125 点击--已绑定--更多")
		elseif multi_col({
				{  416,   93, 0xe6be8a},
				{  449,  167, 0xd64146},
				{  610,   90, 0xd22e2e},
				{  478,  537, 0x532617},
				})then
			ltap(478,  537)
			wwlog("1078 点击红色药水--已绑定--更多") --已绑定的取色，放在随身药店上面
		elseif multi_col({
				{  534,   43, 0x52140f},
				{  566,   47, 0x4c110f},
				{  540,  368, 0x4d3a2b},
				{  566,  374, 0xbd8e6b},
				{  578,  372, 0x634b38},
				}) then
			ltap(578,  372)
			wwlog("979 点击随身药店")
		elseif multi_col({
				{  516,   43, 0x51140f},
				{  533,   48, 0xf3cb94},
				{  568,   44, 0x50130f},
				{  787,  172, 0x331255},
				{  567,  250, 0xe9c18c},
				}) and buy_cnt <6 then  --购买次数限制
			ltap(604,  163) --购买红药水
			wwlog("1121 药品商城--点击红药水")
			mmsleep(1000)
			ltap(659,  545) --弹出的购买窗口，点击确认，买一个红药水
			mmsleep(1000)
			ltap(787,  165) --购买蓝药水
			wwlog("1126 药品商城--点击蓝药水")
			mmsleep(1000)
			ltap(659,  545) --弹出的购买窗口，点击确认，买一个蓝药水
			mmsleep(1000)
			ltap(501,  264) --购买太阳神水
			wwlog("1131 药品商城--点击太阳神水")
			mmsleep(1000)
			for i=1,4,1 do -- 测试，先一组买2个太阳神水,以免金币花光，无法测试
				mmsleep(200)
				ltap(690,  366)
			end			
			ltap(659,  545) --弹出的购买窗口，点击确认，买一组太阳水
			mmsleep(1000)
			ltap(1011,   67) --点击关闭
			wwlog("1150 关闭药品商城")
			--wwlog("1138 药品商城")
			buy_cnt =buy_cnt +1
			--cangku_red = 'Y'
			--find_red = 'Y'
		elseif multi_col({
				{ 1004,   57, 0xebca77},
				{ 1015,   59, 0xe0d6a7},
				{ 1003,   71, 0xd68142},
				{ 1011,   64, 0xab7c4d},
				{ 1011,   67, 0x420e10},
				})  and  buy_cnt>5 then
			ltap(1011,   67)
			wwlog("1303 关闭药品商城")
		elseif get_locked_red() then
			mmsleep(100)
			wwlog("1084 把红药水放仓库")
		elseif get_locked_blue() then
			mmsleep(100)
			wwlog("1140 把蓝药水放仓库")
		elseif get_locked_gold() then
			mmsleep(100)
			wwlog("1143 把太阳神水放仓库")
		elseif get_unlocked_red() then
			mmsleep(100)
			wwlog("1146 购买红药水")
		elseif get_unlocked_blue() then
			mmsleep(100)
			wwlog("1149 购买蓝药水")
		elseif multi_col({
		{ 1097,  319, 0xac9977},
		{ 1079,  332, 0x665844},
		{ 1088,  351, 0xccccbb},
	{ 1105,  350, 0xefdece},
	{ 1113,  353, 0xf3e3d2},
}) 
then
	ltap(1113,  353)
	wwlog("912 点击自动攻击按钮")
elseif multi_col({
		{  314,  595, 0x664433},
		{  332,  595, 0x974d33},
		{  350,  603, 0xfffff2},
		{  335,  609, 0xefdcc6},
		{  501,  576, 0xfbf294},
		}) then
	ltap(314,  595)
	wwlog("1576 点击背包")
elseif multi_col({
		{ 1085,  311, 0xead1c0},
		{ 1084,  321, 0xe5d8c1},
		{ 1102,  306, 0xf7f6ee},
		{ 1108,  328, 0xeddbba},
		{  510,  577, 0xf0e88c},
		}) then
	ltap(  564,  579) --点击红篮球
	mmsleep(2000)
	ltap(338,  575 ) --点击背包
	wwlog("1498 点击红篮球 准备点击背包")	
elseif multi_col({
		{  447,  244, 0xaa222f},
		{  458,  246, 0xbe3335},
		{  421,  151, 0xe4bc89},
		{  662,  546, 0x57291a},
		})then
	ltap(662,  546)
	mmsleep(80)
	wwlog("1108 购买一个红药水")
	--cangku_red = 'Y'
	--find_red = 'N'
	mmsleep(500)
	ltap(1011,   64) --关闭药品商城


elseif multi_col({
		{  510,  179, 0x261b17},
		{  539,  177, 0xeac38f},
		{  379,  439, 0x77442b},
		{  387,  439, 0xcfa374},
		{  411,  443, 0xdbb07f},
		}) then
	ltap(411,  443)
	wwlog("1043 回城复活")
	break
end
end

mmsleep(200)
--while (bag_is_full ==true) do
if bag_is_full == true  and multi_col({
		{ 1039,   31, 0xf3c892},
		{ 1046,   32, 0xdfb183},
		{ 1065,   30, 0xf6cd95},
		{ 1062,   37, 0xdeac7f},
		}) then
	mmsleep(100)
	wwlog("1548 背包满了，退出矿区")
	ltap(1070,   43) --点击右上角
	mmsleep(1000)
	ltap(1060,  299) --点击地图右侧--主城
	mmsleep(1000)
	ltap(930,  559) --传送前往落霞岛
	mmsleep(5000)
end
--]==]
	resethome()

	function check_right_corder(...)
		local ret = false
		mmsleep(500)
		local ret = false
		wwlog("1634 检查右上角 ，判定角色是否移动")
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

	renwu_flag = 1
	while (main_task == true) do
		wwlog("2335 继续做主线任务")
		mmsleep(1000)
		--ltap( 94,  196)
		mmsleep(80)
		snapshot("right_corner.png", 1036,   29,  1125,   59); --以test命名进行截图
		mmsleep(1000)
		renwu_flag = renwu_flag +1
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
			wwlog("2389 机关力量--分解装备--领取邮件")
			if mail_get == false then
				main_task = false
				break
			end
		elseif multi_col({
				{   79,  167, 0xd7b362},
				{   50,  169, 0xc02835},
				{   73,  165, 0xf7e574},
				{   98,  168, 0xf0d970},
				{  125,  165, 0xf0dc71},
				{  138,  171, 0xf1df71},
				{  135,  168, 0xd5ba64},
				}) and mail_get == false then

			wwlog("2404 机关力量--分解装备--领取邮件")
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
			wwlog("340 完成任务2")
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
			wwlog("427 保持流畅模式")
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
			wwlog("257 请点击继续")
			before_game ='N'
		elseif multi_col({
				{ 1024,  107, 0x5e1612},
				{ 1024,   92, 0x7b2512},
				{ 1056,  108, 0xcfa075},
				{ 1078,  109, 0xd6a77a},
				{ 1091,  109, 0x531110},
				}) then
			ltap(1091,  109)
			wwlog("452 红色跳过")
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
		elseif multi_col({
				{  879,  532, 0x773e1d},
				{  878,  555, 0x4a1d14},
				{  905,  542, 0x68311c},
				{  928,  546, 0x572a1a},
				})then
			ltap(928,  546)
			wwlog("685 领取美酒")
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
				{    9,   73, 0xc09d76},
				{   14,   75, 0xd4b289},
				{   12,   78, 0xcda77d},
				{   10,   79, 0xecc48f},
				{   14,   82, 0xdeb483},
				{   10,   85, 0xe7bc89},
				})then
			wwlog("30级了，")
			mmsleep(200)
			ltap( 567,  575) --点击底部中间圆球
			mmsleep(2000)
			ltap(968,  573) --点击右侧设置按钮
			mmsleep(2000)
			ltap(1058,  528) --点击右侧系统设置
			mmsleep(2000)
			ltap(877,  246)  --点击切换账号
			mmsleep(2000)
			wwlog("470 成功退出")
			if v_choose ~= nil then
				choose_flag = false
			end
			--dialog("30级了", 60)
			break
			----------------------------bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbreeeeeeeeeeeeeeeeeeeeekkkkkkkkkkkkkkkkkkkkkk------------------------------------------------------------------------------------------	
			--os.exit()				
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
			wwlog("活动大厅，关闭")
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
			wwlog("2181 使用小飞鞋")

		elseif  check_right_corder() then
			if renwu_flag %10 ==0 then
				ltap(60,  195)
				wwlog("2188 点击左侧第一个任务")
			end
		end
	end

	while (bag_clean == false) do
		wwlog("2946 准备整理装备")
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
			wwlog("2259 点击背包")
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
			wwlog("2270 点击背包")

		elseif multi_col({
				{  527,   39, 0x5b1a0e},
				{  555,   47, 0xc4976e},
				{  557,   38, 0xf5cc94},
				{  583,   37, 0xf6cd95},
				{  446,  507, 0x71381c},
				{  467,  515, 0xeec48e},
				}) then
			ltap(467,  515)
			wwlog("2980 整理")
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


	while (mail_get == false) do
		wwlog("2994 领取邮件")
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
			wwlog("2418 一键领取")
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

	mmsleep(10000)

	run_app()

	--长时间没有响应，点击左侧任务栏
	wwlog("583 大循环")

end  -- end while


if TOUCH_MODE == true1 then
	close_log(log_file)		
end	

wwlog("脚本结束")