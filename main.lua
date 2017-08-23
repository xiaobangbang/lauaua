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
	-- body
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

function get_locked_red(...)
		local ret = false
		x,y = findMultiColorInRegionFuzzy( 0xc53838, "-21|9|0x6b3d07,-25|7|0xab7108,-12|20|0xcecece,-13|-4|0xffffff", 85,  243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1001 点击背包中红色药水")
			--cangku_red ='N'				
		end
		-- body
		return ret
	end


	function get_locked_blue(...)
		local ret = false
		--x,y = findMultiColorInRegionFuzzy( 0xeffaef, "-3|5|0x3838c1,5|-1|0x504a94,-9|6|0xefac0b,-11|13|0xc78609", 85,  243,  105, 1010,  474)
		x,y = findMultiColorInRegionFuzzy( 0xe8f7fc, "-2|4|0x363bbd,-9|6|0xcb8a07,-10|13|0xb47707", 85,  243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1016 点击背包中蓝色药水")
			--cangku_red ='N'
		end
		
		mmsleep(100)
		x,y = findMultiColorInRegionFuzzy( 0x393ac1, "0|2|0x4046cc,-7|2|0xa76f06,-8|9|0xb67607", 90, 243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1027 点击背包中蓝色药水")
			--cangku_red ='N'
		end
		
		mmsleep(100)
		x,y = findMultiColorInRegionFuzzy( 0x3d44c4, "4|-1|0xecedef,2|4|0x322287,-7|2|0xba7e07", 90, 0, 0, 1135, 639)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("372 点击背包中蓝色药水")
			--cangku_red ='N'
		end
		
		-- body
		return ret
	end

	function get_locked_gold(...)
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
		x,y = findMultiColorInRegionFuzzy( 0x3332aa, "5|5|0x4433bb,-14|19|0xdedddd,-25|-12|0xd6d6d6,4|-47|0xfcfcfc", 85,  243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1008 点击背包中蓝色药水")
			--find_red ='Y'
		end
		-- body
		return ret
	end

	function get_unlocked_red(...)
		local ret = false
		x,y = findMultiColorInRegionFuzzy( 0xbb4447, "8|0|0xf1e3e3,1|4|0xbb3333,34|-5|0xc3c3c3,4|-21|0x431111", 85,  243,  105, 1010,  474)
		mmsleep(80)
		if x~= -1 and y ~= -1 then
			ret = true
			ltap(x,y)
			wwlog("1059 点击背包中红色药水")
			find_red ='Y'
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
			wwlog("1071 点击仓库中的太阳神水")			
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
			wwlog("1084 点击仓库中的蓝色药水")			
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
			wwlog("1098 点击仓库中的红色药水")			
		end
		return ret
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

	dialog_flag =find_dialog()

	while (before_game == 'Y') do
		mmsleep(1000)
		wwlog("252 before log in game"..before_game)
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
			--[[
	elseif multi_col({
			{  253,  869, 0xffffff},
			{  273,  881, 0xffffff},
			{  284,  884, 0x04be02},
			{  306,  878, 0xffffff},
			{  340,  877, 0xecfaec},
			{  343,  885, 0x04be02},
			{  373,  879, 0xffffff},
			})then
		ltap(373,  879)
		wwlog("308 竖屏 微信确认登陆")
	]]--	
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
			--[[
		elseif multi_col({
				{  844,  573, 0xaa2a19},
				{ 1012,  572, 0x9c0e0d},
				{  879,  573, 0xcfab68},
				{  964,  575, 0xc8a76a},
				{  928,  574, 0x571212},
				{  923,  569, 0xe7c071},
				}) then
			ltap(923,  569)
			before_game = 'N'
			wwlog("360 直接点击开始游戏")	
		]]--	
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
		wwlog("232 配置完天雷技能之前的任务"..tianlei_flag)	
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
			--before_game = 'N'
		elseif multi_col({
				{  928,  249, 0x1b1f33},
				{  938,  261, 0x222251},
				{  933,  290, 0x538bda},
				{  934,  321, 0x5a76a6},
				{  915,  328, 0x6084bb},
				{  934,  308, 0x300e0d},
				})then
			ltap(932,  401) --点击天雷咒
			mmsleep(1500)
			ltap(  564,  573) --点击红蓝球
			mmsleep(1500)
			ltap(  251,  575) --点击技能书图标
			mmsleep(1500)
			ltap(  1057,  297) --点击设置标签
			mmsleep(1500)
			ltap( 455,  212) --点击天雷咒技能
			mmsleep(1500)
			ltap( 722,  423) --点击第一个技能槽
			tianlei_flag = 'Y'
			mmsleep(1500)	
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
			if sleep_cnt  >10 then
				ltap(60,  195)
				wwlog("786 长时间没有响应，点击左侧任务栏")
				sleep_cnt =1
			end
		end

		sleep_cnt =sleep_cnt + 1

	end

	----------------------------------------------------------------------
	----------------------------------------------------------------------

	--设置，买药，领取奖励
	while (tianlei_flag=='Y' and yaoshui_shezhi == 'N' and dialog_flag =='N') do
		mmsleep(1000)
		wwlog("622药水设置")
		if multi_col({
				{  962,  566, 0xcf9966},
				{  976,  569, 0xe19f65},
				{  976,  587, 0x8a4927},
				{  961,  588, 0xb06a38},
				{  968,  577, 0x333322},
				}) then
			ltap(968,  577)
			wwlog("610 点击设置按钮")

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
			dialog_flag = 'N'
			break
		elseif multi_col({
				{ 1049,  157, 0x4e0b05},
				{ 1057,  170, 0xeaba87},
				{  903,  182, 0xb68a5c},
				{  902,  191, 0x6d4d37},
				{  838,  186, 0x546722},
				}) then
			ltap(835,  188)
			wwlog("620 关闭红色药水")
		elseif multi_col({
				{ 1054,  159, 0x650904},
				{ 1063,  197, 0xf7ce96},
				{  904,  481, 0xc09564},
				{  898,  491, 0x6f4e39},
				{  836,  487, 0x546722},
				}) then
			ltap(837,  484)
			wwlog("629 关闭蓝色药水")
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
		wwlog("设置药水")
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
			ltap(401,  173)
			wwlog("731 签到领取5w金币")
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

	wwlog(kuangqu_flag)
	mmsleep(200)
	local kuang_qu_flag1 = 'N'
	local shua_guai_dian ='N'
	local shua_guai_time = 0
	------------------------------区落霞岛刷装备-------------------------------------
	while ( kuangqu_flag =='N' and dialog_flag =='N') do
		mmsleep(1000)
		shua_guai_time = shua_guai_time +1
		wwlog("893 进入落霞岛刷装备")
		if multi_col({
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
		resethome()
		-- body
	end

	

-----------------------------------------自动买药水-----------------------------
	
	local find_red='N'
	local find_blue='N'
	local cangku_red = 'N'
	local buy_cnt = 0
	while (beibao_flag =='N' ) do
		wwlog("1000 购买药水")
		dialog_flag =find_dialog()
		mmsleep(1500)

		--[[
		if find_red == 'N' then
			x,y = findMultiColorInRegionFuzzy( 0x3332aa, "5|5|0x4433bb,-14|19|0xdedddd,-25|-12|0xd6d6d6,4|-47|0xfcfcfc", 85,  243,  105, 1010,  474)
			mmsleep(80)
			if x~= -1 and y ~= -1 then
				ltap(x,y)
				wwlog("1008 点击背包中蓝色药水")
				find_red ='Y'
			end
		end

		wwlog("find_red"..find_red)
		if find_red == 'N' then
			x,y = findMultiColorInRegionFuzzy( 0xbb4447, "8|0|0xf1e3e3,1|4|0xbb3333,34|-5|0xc3c3c3,4|-21|0x431111", 85,  243,  105, 1010,  474)
			mmsleep(80)
			if x~= -1 and y ~= -1 then
				ltap(x,y)
				wwlog("1018 点击背包中红色药水")
				find_red ='Y'
			end
		end
		]]--

		mmsleep(80)
		--wwlog("cangku_red"..cangku_red)
		--点击购买的绑定药水
		--if cangku_red =='Y' then

		--end
		if multi_col({
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
	end	
	mmsleep(80)
	wwlog("1216 从仓库中多点取色，找到药水，并点击")
	
	if more_flag == 'N' then
		ltap(1011,   65)
		wwlog("1208 关闭仓库")
		beibao_flag = 'Y'
	end 
	
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
			find_red = 'N'
			cangku_red = 'N'
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
			for i=1,3,1 do -- 测试，先一组买2个太阳神水,以免金币花光，无法测试
				mmsleep(200)
				ltap(690,  366)
			end			
			ltap(659,  545) --弹出的购买窗口，点击确认，买一组太阳水
			mmsleep(1000)
			ltap(1011,   67) --点击关闭
			wwlog("1150 关闭药品商城")
			--wwlog("1138 药品商城")
			buy_cnt =buy_cnt +1
			cangku_red = 'Y'
			find_red = 'Y'
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
				}) --and dialog_flag=='N' 
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
			wwlog("1327 点击背包")
		elseif multi_col({
	{ 1080,  349, 0xd9c9b9},
	{ 1104,  353, 0xcdc2b1},
	{ 1108,  356, 0xe1d1c2},
	{  510,  576, 0xf8f294},
	{  625,  577, 0xf0e88a},
}) then
			ltap(  564,  579) --点击红篮球
			mmsleep(2000)
			ltap(338,  575 ) --点击背包
			wwlog("1339 点击红篮球 准备点击背包")	
		elseif multi_col({
				{  447,  244, 0xaa222f},
				{  458,  246, 0xbe3335},
				{  421,  151, 0xe4bc89},
				{  662,  546, 0x57291a},
				})then
			ltap(662,  546)
			mmsleep(80)
			wwlog("1108 购买一个红药水")
			cangku_red = 'Y'
			find_red = 'N'
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
	run_app()

	--长时间没有响应，点击左侧任务栏
	wwlog("583 大循环")

end  -- end while


if TOUCH_MODE == true1 then
	close_log(log_file)		
end	

wwlog("脚本结束")