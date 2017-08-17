DEBUG_MODE =false
TOUCH_MODE= true
XXT_MODE =false

local choose_flag = false

if TOUCH_MODE == true then
	require("TSLib")
end

local open_app
local front_app
local m_sleep
local init_screen
local init_log
local wt_log,wx_log

local log_file = "chuanqishijie"

local multi_col
local press
if TOUCH_MODE == true then
	open_app= runApp
	front_app = frontAppBid
	m_sleep = mSleep
	init_screen = init
	init_log = initLog
	wt_log= wLog
	close_log = closeLog
	multi_col = multiColor
	ltap = tap
elseif XXT_MODE ==true then
	open_app= app.run
	front_app = app.front_bid
	m_sleep = sys.msleep
	init_screen = screen.init
	wx_log= sys.log
	multi_col = screen.is_colors
	ltap = touch.tap	
end

if TOUCH_MODE == true then
		init_log(log_file, 1)
end	

function w_log(msg)
	if TOUCH_MODE == true then		
		wt_log(log_file,msg)
	elseif XXT_MODE == true then
		wx_log(msg)
	end	
	nLog(msg)
end

init_screen(1)
--app.front_bid() ~= "com.tencent.smoba" then	

m_sleep(200)

function run_app(...)

if  front_app() ~= "com.tencent.cqsj" then
	m_sleep(200)
	open_app("com.tencent.cqsj")
	w_log("game start")
	m_sleep(2000)
		
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
  "timer": 600,
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
	mSleep(2000)
end

local x1,y1 = tab_left[idx_left][1],tab_left[idx_left][2]
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

tap(x1,y1)

	--tap(tab_left[idx_left][1],tab_left[idx_left][2])

	mSleep(2000)

	tap(tab_right[idx_right][1],tab_right[idx_right][2])

	mSleep(2000)
	return fuwuqi
	-- body
end

function fuzhu_before (...)
	--keepScreen(true)
--回城复活
x,y = findMultiColorInRegionFuzzy( 0x8b693e, "14|3|0x5f2c1a,21|-1|0xd8ab7a,33|-1|0x6e371d,30|7|0xdeb483,28|5|0x502416", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("176 多点找色，找到回城复活按钮，并点击")
end
--mSleep(100)
--回城复活2
x,y = findMultiColorInRegionFuzzy( 0xedc38d, "0|11|0xd0a678,4|5|0xe6ba87,9|5|0xd7ab7a,13|14|0xeac08c,7|7|0x4f2316", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("176 多点找色，找到回城复活按钮，并点击")
end

--确定按钮
x,y = findMultiColorInRegionFuzzy( 0x773e1e, "-30|7|0x705632,84|9|0x2d2013,27|17|0x712f1e,13|13|0xf2c992,37|15|0xf3ca93", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("176 多点找色，找到确定按钮，并点击")
end

--确定按钮2
x,y = findMultiColorInRegionFuzzy( 0xba895f, "-1|7|0xb1855f,10|11|0xba8b63,11|3|0xe1b683,15|8|0x6b3a27,3|9|0x693824,11|1|0x784127", 85, 365,  180, 768,  451)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("176 多点找色，找到确定按钮，并点击")
end

--点击会动的小手
x,y = findMultiColorInRegionFuzzy( 0x7f232c, "4|-15|0xe9c065,18|-25|0xfaf9a6,35|-10|0xbd9ea0,36|4|0xf1d973,20|-8|0xe3cea1", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x - 25 ,y - 45)
	w_log("206 多点找色，找到会动的小手，并点击")
end

--点击会动的小手2
x,y = findMultiColorInRegionFuzzy( 0xeaba4a, "12|-11|0xf9f39d,26|-2|0xa0855f,32|8|0x6a442b,19|12|0xd5aa6c,16|3|0xb09c64", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x - 30 ,y - 33)
	w_log("213 多点找色，找到会动的小手2，并点击")
end

--点击会动的小手2
x,y = findMultiColorInRegionFuzzy( 0xf1c66b, "9|-8|0xc2b97b,18|-5|0xf0dede,23|5|0xb98952,13|10|0x7e5f50", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x - 30 ,y - 33)
	w_log("220 多点找色，找到会动的小手3，并点击")
end

--点击传送
x,y = findMultiColorInRegionFuzzy( 0xae8f58, "27|-2|0x763b20,40|-2|0xe0b481,39|12|0xd1a477,46|2|0xf4cb94,42|6|0x5c2a1b", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	m_sleep(200)
	ltap( x,  y)
	w_log("228 多点找色，找到传送")
end

--点击完成任务
x,y = findMultiColorInRegionFuzzy( 0xa37b48, "10|2|0x512718,21|6|0xe6bf8b,44|6|0xefc993,56|4|0x522719,62|3|0xd4ad7e", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	m_sleep(200)
	ltap( x,  y)
	w_log("236 多点找色，找到完成任务的按钮，并点击")
end

--点击完成任务2
x,y = findMultiColorInRegionFuzzy( 0x705032, "0|2|0xa67a4a,19|-4|0xeec08d,19|5|0xe9bc8a,12|12|0xf0c38f", 90, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	m_sleep(200)
	ltap( x,  y)
	w_log("244 多点找色，找到完成任务的按钮，并点击")
end

--点击右侧立即装备
x,y = findMultiColorInRegionFuzzy( 0x614128, "156|1|0xdd9c55,184|3|0x4a1916,187|11|0x551718,195|67|0x8a5e33,-17|115|0x5d3822", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(  934,  399)
	w_log("251 多点找色，找到立即装备，并点击")
end


--副本-红色跳过按钮
x,y = findMultiColorInRegionFuzzy( 0x7d5e39, "22|-3|0x6e1c13,113|1|0xa57a48,39|3|0xc4926b,46|6|0xf7ce96,68|5|0xe7bc89", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("183 多点找色，找到红色跳过按钮，并点击")
end

--保持流畅模式
x,y = findMultiColorInRegionFuzzy( 0x7c421c, "30|3|0x713a1b,79|1|0x793f1c,-1|20|0xe5bc89,23|14|0xd1a678,62|18|0xb68962,75|16|0xe0b684", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("183 多点找色，保持流畅模式")
end

--红包
x,y = findMultiColorInRegionFuzzy( 0xde9f26, "22|-6|0xde9f26,40|8|0xde9f26,21|26|0xde9f26,-1|17|0xde9f26,20|-24|0xaf331b", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("183 多点找色，打开红包")
end

--接受任务
x,y = findMultiColorInRegionFuzzy( 0xa94dcb, "66|-2|0xa84dca,0|20|0xa94dcc,67|22|0x9259a4,34|13|0xca8f22", 85, 0, 0, 1135, 639)	
if x~= -1 and y ~= -1 then
	m_sleep(80)
	ltap( 832,  406)
	m_sleep(80)
	w_log("297 多点找色，找到任务奖励的紫色方框，并点击右侧的发光按钮")
end	

x,y = findMultiColorInRegionFuzzy( 0xaa4dcd, "0|21|0xaa4ecc,0|60|0xa94dcb,66|-1|0xaf50d1,66|26|0xab4ecd,49|-1|0xb050d0", 85, 0, 0, 1135, 639)
m_sleep(80)
if x~= -1 and y ~= -1 then
	m_sleep(80)
	ltap( 832,  406)
	m_sleep(80)
	w_log("306 多点找色，找到任务奖励的紫色方框，并点击右侧的发光按钮")
end

m_sleep(200)
x,y = findMultiColorInRegionFuzzy( 0xe6a620, "-13|-9|0xc6a025,-33|-31|0xb251d4,31|-31|0xb050d2,34|-2|0xa44bc6", 90, 0, 0, 1135, 639)
m_sleep(60)
if x~= -1 and y ~= -1 then
	m_sleep(60)
	ltap( 832,  406)
	m_sleep(60)
	w_log("314 多点找色，找到接受任务的紫色方框，并点击右侧的发光按钮")
end

--公告
x,y = findMultiColorInRegionFuzzy( 0xded5ae, "-2|11|0xdf8c4c,5|4|0xb09565,41|-4|0xd18251,36|18|0x915f25", 85, 0, 0, 1135, 639)
--x,y = findMultiColorInRegionFuzzy( 0xab2424, "21|20|0xd07e3e,19|4|0xf9cb68,1|23|0x4d1216,12|11|0xe9cc81", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("295 多点找色，找到公告关闭X，并点击")
end

--keepScreen(false)
end

function func_after(...)
	

	
	--keepScreen(true)
	--点击发光的完成任务
--x,y = findMultiColorInRegionFuzzy( 0xaf50d1, "62|1|0xa94dcc,-4|65|0xaa4ecc,97|1|0x4a7ac6,162|0|0x5084d1,96|64|0x4e7fcc", 90, 0, 0, 1135, 639)


	--关闭
	x,y = findMultiColorInRegionFuzzy( 0xab2424, "21|20|0xd07e3e,19|4|0xf9cb68,1|23|0x4d1216,12|11|0xe9cc81", 85, 0, 0, 1135, 639)
if x~= -1 and y ~= -1 then
	ltap(x,y)
	w_log("304 多点找色，找到关闭X，并点击")
end
	-- body
	--keepScreen(false)
end

run_app()

--启动游戏并进入游戏
while (true) do 
	m_sleep(500)
	fuzhu_before()
	--keepScreen(true)
	m_sleep(1000)
if multi_col({
	{  919,   75, 0x9d702a},
	{  922,   95, 0xdbb16a},
	{  923,  116, 0xfada80},
	{  891,   99, 0xa97144},
	{  886,   96, 0xae8050},
	{  882,   95, 0x4f1415},
})then
	ltap(882,   95)
	w_log("333 点击公告")
elseif multi_col({
	{  211,  516, 0x82d943},
	{  226,  524, 0xeff3f3},
	{  238,  514, 0x415f2b},
	{  282,  509, 0x43642c},
	{  298,  518, 0xdedfdc},
}) then
	ltap(298,  518)
	w_log("79 点击微信")
	--break
elseif multi_col({
	{  390,  372, 0xd1daee},
	{  407,  371, 0x007aff},
	{  407,  381, 0x007aff},
	{  443,  369, 0x007aff},
	{  457,  380, 0x007aff},
	{  449,  374, 0xd5daec},
})then
	ltap(449,  374)
	w_log("353 打开微信")
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
		w_log("89 点击进入游戏")
	else
		ltap(692,  480) --点击换服
		m_sleep(1000)
		v_choose = choose_fuwuqi()
		m_sleep(1000)
		if v_choose ~= nil then
			choose_flag = true
		end
		w_log("175 点击换服")
	end
	
elseif multi_col({
	{  677,  564, 0xba901e},
	{  694,  566, 0xc38a0d},
	{  685,  579, 0xaa7c00},
	{  865,  569, 0x6c1c13},
	{  929,  573, 0x561311},
}) then
	ltap(677,  564) --点击色子
	m_sleep(1000)
	ltap(929,  573) --点击开始游戏
	w_log("99 点击色子，更换名字，然后点击开始游戏，直到成功开始游戏")
elseif multi_col({
	{  844,  573, 0xaa2a19},
	{ 1012,  572, 0x9c0e0d},
	{  879,  573, 0xcfab68},
	{  964,  575, 0xc8a76a},
	{  928,  574, 0x571212},
	{  923,  569, 0xe7c071},
}) then
	ltap(923,  569)
	w_log("110 直接点击开始游戏")

elseif multi_col({
	{  910,  608, 0xfbfbfa},
	{  924,  611, 0xfdfdfd},
	{  941,  608, 0xfbfbfb},
	{  961,  610, 0xfdfdfd},
	{  989,  609, 0xfbfbfa},
}) then
	ltap(989,  609)
	w_log("257 请点击继续")
elseif multi_col({
	{    2,  138, 0xf8ec8e},
	{    3,  141, 0xf6e68c},
	{    3,  152, 0xfff7b1},
	{    3,  157, 0x6a4626},
	{    9,  159, 0x7a522b},
	{    4,  166, 0x986a38},
})then
	ltap( 99,  169)
	w_log("318 副本 向复活点推进")
	
elseif multi_col({
	{  162,  264, 0x7d5624},
	{  156,  292, 0x533718},
	{  184,  279, 0x744f21},
	{  252,  281, 0x5e3f1a},
	{  298,  281, 0xf4de93},
})then
	ltap(672,  179)
	m_sleep(500)
	ltap(  949,  560)
	w_log("380 添加好友")
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
	w_log("422 第一次膜拜")
elseif multi_col({
	{  664,  519, 0xd9b472},
	{  693,  522, 0x753b20},
	{  710,  522, 0xf4cb94},
	{  715,  530, 0xc6976d},
	{  734,  521, 0xdaad7c},
	{  734,  529, 0x5c2719},
})then
	ltap(734,  529)
	w_log("432 传送")
elseif multi_col({
	{  620,  405, 0xac814d},
	{  639,  403, 0x6c351d},
	{  658,  403, 0xe9be8a},
	{  663,  409, 0xc89c70},
	{  679,  404, 0xf5cb94},
	{  689,  412, 0xedc38e},
})then
	ltap(689,  412)
	w_log("442 点击膜拜按钮")
elseif multi_col({
	{  291,  522, 0x793619},
	{  305,  536, 0x5b2d18},
	{  323,  533, 0xbca051},
	{  332,  533, 0xaa8844},
	{  343,  532, 0x835329},
})then
	ltap(343,  532)
	w_log("451 开始膜拜")
elseif multi_col({
	{    9,   73, 0xc09d76},
	{   14,   75, 0xd4b289},
	{   12,   78, 0xcda77d},
	{   10,   79, 0xecc48f},
	{   14,   82, 0xdeb483},
	{   10,   85, 0xe7bc89},
})then
	w_log("30级了，")
	m_sleep(200)
	ltap( 567,  575) --点击底部中间圆球
	m_sleep(2000)
	ltap(968,  573) --点击右侧设置按钮
	m_sleep(2000)
	ltap(1058,  528) --点击右侧系统设置
	m_sleep(2000)
	ltap(877,  246)  --点击切换账号
	m_sleep(2000)
	w_log("470 成功退出")
	break
	--os.exit()
	
elseif multi_col({
	{  674,  358, 0x773b1c},
	{  690,  364, 0xf2c891},
	{  722,  365, 0xe7bd88},
	{  717,  366, 0x63321a},
	{  707,  366, 0xf0c690},
})then
	ltap(707,  366)
	w_log("517 使用镇魔符")
--点击左侧第一个任务
elseif multi_col({
	{  124,  123, 0x882929},
	{  126,  133, 0x772222},
	{  134,  128, 0xd6ae81},
	{  145,  127, 0xdfa77c},
	{  158,  129, 0xdfb786},
	{  151,  136, 0x8d3836},
})then
	ltap(60,  195)
	--w_log("320 点击左侧第一个任务")
end

--keepScreen(false)
--m_sleep(500)
--fuzhu_before()
m_sleep(500)
func_after()
m_sleep(2000)

run_app()

--nLog("while loop")
--点击屏幕继续，跳过动画
--ltap(298,  518)
end


if TOUCH_MODE == true1 then
		close_log(log_file)		
end	

w_log("脚本结束")