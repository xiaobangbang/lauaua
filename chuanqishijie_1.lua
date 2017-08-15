DEBUG_MODE =false
TOUCH_MODE= true
XXT_MODE =false

if TOUCH_MODE == true then
	require("TSLib")
end

function open_app(app_name)
	
	-- body
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

m_sleep(1000)
if  front_app() ~= "com.tencent.cqsj" then
	m_sleep(1000)
	open_app("com.tencent.cqsj")
	w_log("game start")
	m_sleep(2000)
		
end

--启动游戏
while (true) do 
if multi_col({
	{  211,  516, 0x82d943},
	{  226,  524, 0xeff3f3},
	{  238,  514, 0x415f2b},
	{  282,  509, 0x43642c},
	{  298,  518, 0xdedfdc},
}) then
	ltap(298,  518)
	w_log("点击微信")
	break
end
m_sleep(2000)
--点击屏幕继续，跳过动画
ltap(298,  518)

end


if TOUCH_MODE == true1 then
		close_log(log_file)		
end	

w_log("脚本结束")