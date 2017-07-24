local CC = require('CC')

function initArgs()

	local args = proc_take('spawn_args')    --获取启动参数
	--sys.alert(args)
	if args == '' then
		args = proc_take('CC_args')         --适配中控框架启动方式
	end
	--sys.alert(args)
	if args == '' then
		args = proc_take('IDE_args')        --适配IDE启动方式(需在IDE电脑端启动中控)
	end

	proc_put('spawn_args', args)            --重新再次写入
	proc_put('CC_args', args)               --重新再次写入
	proc_put('IDE_args', args)              --重新再次写入	
	local args_json = json.decode(args)     --转换启动参数

	--sys.alert(table.deep_print(args_json))
	if type(args_json) == 'table' then      --防止未提交启动
		if type(args_json['server_ip']) == 'string' then
			local server_ip = json.decode(  --IDE与中控的传输方式不同所以需要增加此段
				args_json['server_ip']
			)
			CC.set_sever_ip(                --设置中控IP
				server_ip
			)
		else
			CC.set_sever_ip(                --设置中控IP
				args_json['server_ip']
			)
		end
	else
		error('无启动参数,请使用中控或IDE启动')
	end

	args_json['source'] = "运行账号.csv"
	args_json['target'] = "account_greater60.txt"
	args = json.encode(args_json)
	proc_put('CC_args', args) 
end
function testrun()

	if app.is_running("com.jiguang.mgame.yhjy") then
		--nLog("46 app  is running")
		abc =1
	else
		local r = app.run("com.jiguang.mgame.yhjy") -- 启动应用 
		sys.msleep(10 * 1000) -- 等 10 秒
		if r == 0 then
			nLog("50 app run ok")
		else
			sys.alert("启动失败", 3)		
		end
	end

	local bid = app.front_bid()
	if bid ~= "com.jiguang.mgame.yhjy" then
		local r = app.run("com.jiguang.mgame.yhjy") -- 启动应用 
		sys.msleep(10 * 1000) -- 等 10 秒
		if r == 0 then
			nLog("50 app run ok")
		else
			sys.alert("启动失败", 3)		
		end
	end 
end
testrun()
--sys.alert(db_name)
initArgs()
local batchid=CC.web_file.size("运行账号.csv")
--机器名称中不能包含空格
--local db_name = "db-"..device.name().."-"..os.date("%Y-%m-%d_%H%M%S", os.time())..".db"
local db_name = "db-"..device.name().."-"..batchid..".db"
--sys.alert(db_name)
local db_file_local = "/private/var/mobile/Media/1ferver/lua/scripts/"..db_name

--sys.alert(db_name)

local sqlite3 = require('sqlite3')

function getUserAcct(acct1)	
	--sys.alert( string.find(acct1,"/"))
	local acct_r = string.sub(acct1,1,string.find(acct1,",") - 1)
	--sys.alert(string.len(acct1))
	local pwd_r = string.sub(acct1, string.find(acct1,",") + 1 ,string.len(acct1))
	return (string.gsub(acct_r,'"','')) ,(string.gsub(pwd_r,'"',''))
end

function insGameAcct(acct_name)
	local db = sqlite3.open(db_file_local, "rw")
	--local sql="insert into game_acct(acct_name,acct_log_device,device_type) values('"..acct_name.."','"..device.name().."','"..device.type().."' );"
	local sql ="insert into game_acct(acct_name,acct_log_device,device_type)select '"..acct_name.."','"..device.name().."','"..device.type().."' where not exists(select acct_name from game_acct where acct_name = '"..acct_name.."');"
	nLog(sql)
	db:exec(sql)
	db:close()
end

function updGameAcct(acct_name,flag_60)
	local db = sqlite3.open(db_file_local, "rw")
	--local sql1 =".set param @acct_name = '"..acct_name.."';"
	--local sql2 =".set param @flag60 = '"..flag_60.."';"
	local sql =[=[ 	update game_acct  set flag60 = ?  where acct_name = ? ; ]=]

	--local sql ="update game_acct  set flag60 = '"..flag_60.."'  where acct_name = '"..acct_name.."';"
	
	nLog(sql)
	sys.msleep(200)
	local stmt = db:prepare(sql)
	stmt:bind_values(flag_60,acct_name)
	--stmt.bind("@acct","13944912552")
	stmt:step()	
	--db:exec(sql)
	db:close()
end



function getLess60Account()
	local acct_ret
	local args = proc_take("CC_args")
	local args = json.decode(args)
	local filename = args['source']
	--local filename1 = args['target']
--sys.alert("filename:"..filename)
	if CC.web_file.exists(filename) then
		--sys.alert("CC.web_file.exists(filename)")
		--sys.alert(CC.web_file.take_line(filename))
		--sys.alert(CC.web_file.line_count(filename))
		while  (CC.web_file.line_count(filename) > 0 ) do
			acct_ret = CC.web_file.take_line(filename)			
			if acct_ret ~= nil then
				break
			end 
		end
		CC.log('')
	else
		CC.log('文件不存在')
		os.exit()
	end

	return acct_ret

end

function recordOKAccount(ok_acct)
	local args = proc_take("CC_args")
	local args = json.decode(args)
--local filename = args['source']
	local filename1 = args['target']
--sys.alert("filename:"..filename)
	if CC.web_file.exists(filename1) then
		--sys.alert("CC.web_file.exists(filename)")
		--sys.alert(CC.web_file.take_line(filename))
		--sys.alert(CC.web_file.line_count(filename))
		--while  (CC.web_file.line_count(filename) > 0 ) do
		--local abc = CC.web_file.take_line(filename)
		--sys.alert(abc)
		--local g_success = true --游戏运行成功
		success = CC.web_file.appends(filename1, ok_acct.."\r\n")		
		--end
		CC.log('')
	else
		CC.log('文件不存在')
		os.exit()
	end
end

initArgs()
--local aa = CC.web_file.exists(db_file_local)
local aa = CC.web_file.size(db_file_local)
nLog(aa)
--size
if aa <= 0 then
	nLog("162 第一次，开始下载")
	initArgs()
	CC.web_file.down_file('foo2.db',db_file_local)
end

--require("TSLib")
--init("com.tencent.smoba",1)
screen.init(1)
sys.msleep(1000)

fuhuo =0

--如果已经进入游戏，跳过选服
if screen.is_colors({
		{   65,   45, 0xf5efde},
		{   52,   48, 0xaa8d7a},
		{   62,   23, 0xb98b48},
		}) then
	v_choo_ok = true
else
	v_choo_ok = true	
end

--第一次运行脚本登陆，点击左侧小头像，输入账号
loop_cnt =1
while true do
	loop_cnt = loop_cnt +1
	x, y = screen.find_color({
			{   0,    0, 0xf26568 },
			{  -1,   -4, 0xfffffa },
			{   2,   -3, 0xfe940a },
			{  -2,    0, 0xf15c63 },
			}, 90)

	if x~= -1 and y ~= -1 then
		sys.msleep(100)
		nLog("195 点击半边精灵图标"..x..y)
		sys.msleep(500)
		touch.tap(x,y)
		sys.msleep(3000)
		touch.tap(x+75,y)
		break	
	end

	x, y = screen.find_color({
			{   0,    0, 0xf15e5f },
			{   3,    0, 0xf1646b },
			{   0,    1, 0xf26265 },
			{   3,    1, 0xf1636d },
			}, 90)

	if x~= -1 and y ~= -1 then
		nLog("211 点击整个精灵图标")
		sys.msleep(200)
		touch.tap(x,y)
		sys.msleep(3000)
		touch.tap(x+120,y)
		break	
	end
	if loop_cnt >50 then 
		break
	end
	nLog(loop_cnt)
end

--选服脚本
while true do

	if fuhuo > 2 then
		if screen.is_colors({
				{  836,  583, 0xe0ccb3},
				{  842,  584, 0xd1bea2},
				{  839,  590, 0x70542b},
				}) then
			nLog("33 直接点击设置")
			touch.tap(839,  590)
		else 
			nLog("36 复活太多了，换账号吧")
			touch.tap( 48,  589)
			sys.msleep(500)
			touch.tap(839,  588)
		end		
	end

	if screen.is_colors({
			{  630,  443, 0xd9b668},
			{  657,  445, 0xe2be6e},
			{  687,  445, 0xe0bc6d},
			{  715,  445, 0xd2af64},
			}) then
		nLog("13 点击选服")
		touch.tap(715,  445)
	elseif screen.is_colors({
			{  212,  146, 0x8f7033},
			{  258,  155, 0xf2bf0d},
			{  297,  151, 0xfefefe},
			{  386,  164, 0x23c839},
			})then
		v_choo_ok = true
		nLog("24 点击已有的第一个角色")
		touch.tap(386,  164)
	elseif screen.is_colors({
			{  215,  153, 0xba8636},
			{  261,  154, 0xf8e12b},
			{  291,  155, 0xf0eae8},
			}) then
		v_choo_ok = true
		nLog("31 点击已有的第一个角色")
		touch.tap(500,168)
	end

	sys.msleep(50)
	nLog(v_choo_ok)
	sys.msleep(50)
	if v_choo_ok  then
		break
	end 
	sys.msleep(1000)
	nLog("31 end while")
end
--sys.alert("屏幕懂了")
local acct1 --从中控读取的账号密码存此变量

--insGameAcct("13944912552")
--updGameAcct("13944912552","N")

while true do 
	screen.keep()
	sys.msleep(500)
	if screen.is_colors({
			{  772,  197, 0xaa7439},
			{  536,  416, 0x728a00},
			{  568,  417, 0x9cb504},
			}) then --点击确定，更新客户端
		nLog("10 点击确定，更新客户端")
		sys.msleep(200)
		touch.tap(568,  417)
	elseif screen.is_colors({
			{  653,  400, 0x627532},
			{  725,  403, 0x6a7e38},
			{  687,  421, 0x859572},
			}) then	
		nLog("77 点击确定，更新客户端")
		touch.tap(687,  421)
	elseif screen.is_colors({
			{  849,  129, 0xa86e34},
			{  535,  473, 0x879d2a},
			{  567,  474, 0xd9e55b},
			}) then --公告，点击确认
		nLog("18 公告，点击确认")
		sys.msleep(200)
		touch.tap(567,  474)
	elseif screen.is_colors({
			{  527,  463, 0x6a7a35},
			{  557,  475, 0xfefefd},
			{  587,  475, 0xebeee9},
			{  569,  482, 0xa1be01},
			}) then
		nLog("29 公告确认")
		sys.msleep()
		touch.tap(569,  482)
	elseif screen.is_colors({
			{  537,  466, 0x788b39},
			{  583,  475, 0x8ba306},
			{  567,  474, 0xd9e55a},
			}) then
		nLog("36 公告确认")
		touch.tap(567,  474)
	elseif screen.is_colors({
			{  558,  576, 0x999999},
			{  558,  561, 0x999999},
			{  572,  583, 0x999999},
			{  554,  574, 0x999999},
			})then
		nLog("307 注销登陆")
		touch.tap(554,  574)
	elseif screen.is_colors({
			{  324,  244, 0x999999},
			{  350,  246, 0x999999},
			{  692,  243, 0xffffff},
			{  636,  243, 0xffffff},
			})then

		initArgs()
		acct1 = getLess60Account()
		local acct_name, acct_pwd  

		if acct1 ~= nil and string.len(acct1) >12  then 
			--sys.alert("getNewAccount:"..acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))

			sys.msleep(4000)
			nLog("126 用户登录 点击账号")
			touch.tap(636,  243)
			sys.msleep(5000)
			nLog("134 清空账号")
			touch.tap(717,   38)
			sys.msleep(1000)
			nLog("142 输入账号")
			sys.input_text(acct_name)
			sys.msleep(1000)
			nLog("135 点击密码框")
			touch.tap(559,  141)
			sys.msleep(1000)
			nLog("138 清空密码")
			touch.tap(718,  140)
			sys.msleep(1000)
			nLog("141 输入密码")
			sys.input_text(acct_pwd)
			sys.msleep(1000)
			nLog("144 立即登陆")
			touch.tap(715,  279)

			if acct_name ~= nil then 
				sys.msleep(2000)
				insGameAcct(acct_name)
				--sys.msleep(5000)
				--updGameAcct(acct_name,"Y")
			end 
		else
			initArgs()
			CC.web_file.update_file("abc/"..db_name,db_file_local)
			sys.alert("account_less60.txt 没有账号了！")
			os.exit()
		end
	elseif screen.is_colors({
			{   16,   20, 0xe0d5d3},
			{   17,   15, 0xc3adaa},
			{   18,   20, 0xeee8e7},
			{   20,   24, 0xe8e0de},
			{   17,   27, 0x9c7773},
			}) then
		nLog("276 80多级了，换账号了")
		touch.tap(47,  592) --点击设置		
		sys.msleep(2000)
		touch.tap(920,  589)
		sys.msleep(2000)
		touch.tap(362,   42) --点击系统设置
		sys.msleep(2000)
		touch.tap(494,  469) --点击切换账号
		sys.msleep(2000)
		touch.tap(692,  406) --点击确定
		
		if acct1 ~= nil then
			nLog("350 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
		end
	elseif screen.is_colors({
			{   18,   21, 0xf8f5f4},
			{   14,   17, 0xe3d9d7},
			{   16,   25, 0xe3d9d7},
			{   17,   19, 0x7a3202},
			})then
		nLog("152 90多级了，可以切换账号了")
		touch.tap(50,  591)
		sys.msleep(4000)
		--60级和90级的设置按钮，貌似位置不一致
		if screen.is_colors({
				{  915,  584, 0x8c724e},
				{  924,  586, 0x967c58},
				{  920,  592, 0x543b15},
				{  923,  614, 0xe3d987},
				}) then
			nLog("161 判定设置按钮位置")
			touch.tap(923,  614)
			sys.msleep(4000)
		end

		--默认点击设置按钮
		touch.tap(923,  614) --默认点击设置按钮
		sys.msleep(4000)
		touch.tap(362,   42) --点击系统设置
		sys.msleep(2000)
		touch.tap(494,  469) --点击切换账号
		sys.msleep(2000)
		touch.tap(692,  406) --点击确定

		initArgs()
		recordOKAccount(acct1)

	elseif screen.is_colors({
			{  321,   38, 0xacacac},
			{  349,   40, 0xa8a8a8},
			{  713,   39, 0xcccccc},
			{  717,   38, 0xfefefe},
			})then
		nLog("134 清空账号")
		touch.tap(717,   38)
	elseif screen.is_colors({
			{  321,   38, 0xacacac},
			{  351,   38, 0x9e9e9e},
			{  419,   37, 0xc7c7cd},
			{  518,   42, 0xc7c7cd},
			})then
		nLog("142 输入账号")
		sys.input_text("13944912552")
	elseif screen.is_colors({
			{  489,  523, 0xad7001},
			{  568,  545, 0xb17b06},
			{  607,  545, 0x965f05},
			{  574,  554, 0xc7c4a4},
			}) then --登录游戏
		nLog("27 登录游戏")
		sys.msleep(200)
		touch.tap(574,  554)
	elseif screen.is_colors({
			{  892,  586, 0xf9e017},
			{  957,  583, 0xfef063},
			{ 1022,  593, 0xe4b404},
			})then
		nLog("117 开始游戏")
		fuhuo = 0
		touch.tap(1022,  593)
	elseif screen.is_colors({
			{  892,  579, 0xffffeb},
			{  944,  598, 0xb67202},
			{ 1010,  595, 0xcd8b05},
			{ 1049,  600, 0xa86909},
			}) then 
		nLog("36 确认创建角色")
		sys.msleep(200)
		touch.tap(1049,  600)
	elseif screen.is_colors({
			{  900,  603, 0xc09841},
			{  973,  604, 0x9e5904},
			{ 1050,  599, 0xb56c06},
			})then
		nLog("349 确认创建")
		touch.tap(1050,  599)
	elseif screen.is_colors({
			{  527,  284, 0xfcfbf9},
			{  589,  287, 0xf7f6f3},
			{  568,  411, 0xb15213},
			{  546,  417, 0xccc7c3},
			})then
		nLog("357 角色重名")
		touch.tap(546,  417)
		sys.msleep(2000)
		touch.tap(696,  600)
	elseif screen.is_colors({
			{  907,  584, 0xfeeb3d},
			{  958,  597, 0xb67b11},
			{ 1067,  607, 0xaf6d1a},
			{  986,  596, 0x103f77},
			}) then --确认创建
		nLog("36 确认创建")
		sys.msleep(200)
		touch.tap(986,  596)
	elseif screen.is_colors({
			{  891,  586, 0xffe513},
			{  956,  594, 0xcc9209},
			{ 1054,  593, 0xd99500},
			{  983,  589, 0x091f34},
			}) then --开始游戏
		nLog("163 开始游戏")
		fuhuo = 0
		touch.tap(983,  589)
	elseif screen.is_colors({
			{  529,  394, 0x7a5d35},
			{  603,  396, 0x745933},
			{  583,  419, 0xfffffe},
			{  565,  410, 0xdd7c40},
			})  then
		nLog("64 断开连接，重新登陆游戏")
		sys.msleep(200)
		touch.tap(565,  410)

	elseif screen.is_colors({
			{  893,  578, 0xfffff2},
			{  948,  581, 0xfff391},
			{ 1057,  593, 0xda9a0a},
			{  985,  598, 0x9b6f1c},
			})  then
		nLog("182 开始游戏")
		fuhuo = 0
		touch.tap(  985,  598)
	
	elseif screen.is_colors({
			{   15,   17, 0xa88784},
			{   19,   18, 0xe0d5d3},
			{   20,   23, 0xe9e1e0},
			{   13,   24, 0xbfa7a4},
			{   16,   26, 0xd1c0be},
			}) then
		nLog("165 80级了，换账号了")
		touch.tap(52,589)--点击左下角箭头
		sys.msleep(2000)
		touch.tap(930,585) --点击设置
		sys.msleep(3500)
		touch.tap(357,38) --点击系统设置
		sys.msleep(3500)
		touch.tap(494,467)--点击切换账号
		sys.msleep(3500)
		touch.tap(693,413)--确定退出
		sys.msleep(1500)
	elseif	screen.is_colors({
			{  297,  100, 0xf65700},
			{  504,  176, 0xf06144},
			{  321,  244, 0xa2a2a2},
			{  710,  247, 0xffffff},
			}) then
		nLog("183 输入账号")
		touch.tap(710,  247)
	elseif screen.is_colors({
			{  667,  473, 0x408ed6},
			{  697,  480, 0xffffff},
			{  722,  482, 0xb0d0ee},
			{  716,  492, 0x9fc6eb},
			})  then
		nLog("73 立即登陆")
		sys.msleep(200)
		touch.tap(  716,  492)
	elseif screen.is_colors({
			{  660,  459, 0x578132},
			{  713,  460, 0x608a32},
			{  657,  485, 0x53880d},
			{  692,  475, 0xc6cdc1},
			}) then
		nLog("243 脱机外挂结算 知道了")
		touch.tap(692,  475)
	elseif screen.is_colors({
			{  760,  404, 0x5d842f},
			{  808,  404, 0x5a8430},
			{  838,  261, 0xe5c486},
			})then
		nLog("250 关机脱机外挂窗口")
		touch.tap(838,  261)
	elseif screen.is_colors({
			{  655,  396, 0x647532},
			{  692,  400, 0x778c36},
			{  732,  399, 0x657632},
			{  681,  421, 0xfffffe},
			{  710,  419, 0x153c24},
			})then
		nLog("492 确定-装备提示")
		touch.tap(710,  419)
	elseif screen.is_colors({
			{  533,  401, 0x61762c},
			{  580,  408, 0x17522b},
			{  546,  423, 0x5e890a},
			{  605,  421, 0x86a591},
			{  573,  418, 0x719409},
			})then
		nLog("501 立即装备")
		touch.tap(573,  418)
	elseif screen.is_colors({
			{  483,  282, 0xe4e1dc},
			{  528,  286, 0xc7c2ba},
			{  568,  278, 0xedebe7},
			{  608,  283, 0xeceae6},
			{  663,  399, 0x6d8035},
			{  691,  414, 0xa4bc02},
			})then
		nLog("584 确定退出当前账号")
		touch.tap(691,  414)
		sys.msleep(500)

		if acct1 ~= nil then
			nLog("587 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
		end
	elseif screen.is_colors({
			{   18,   16, 0xf7f3f2},
			{   16,   19, 0xe6dddc},
			{   14,   24, 0xe2d7d5},
			{   16,   26, 0xd9ccca},
			{   20,   24, 0xe1d6d4},
			{   18,   20, 0xbca29f},
			})then
		nLog("648 60级了 ，开始换账号")
		touch.tap(52,589)--点击左下角箭头
		sys.msleep(2000)
		touch.tap(839,  586) --点击设置
	elseif screen.is_colors({
	{   15,   16, 0xdaccc9},
	{   18,   16, 0xdbcecc},
	{   19,   17, 0xf3efee},
	{   17,   21, 0xece5e3},
	{   15,   25, 0xd9cbc9},
})then
	nLog("659 70级了 ，开始换账号")
		touch.tap(52,589)--点击左下角箭头
		sys.msleep(2000)
		touch.tap(839,  586) --点击设置
	elseif screen.is_colors({
			{  822,  570, 0x381424},
			{  820,  584, 0x852802},
			{  827,  559, 0x746573},
			})then
		nLog("560 再次体验天神")
		touch.tap(827,  559)
	elseif screen.is_colors({
			{  958,  429, 0x88cf26},
			{  947,  431, 0xfefffd},
			{  978,  435, 0xdee7e0},
			{  971,  430, 0xfefefd},
			})then
		nLog("211 出售")
		touch.tap(971,  430)
	elseif screen.is_colors({
			{  766,  323, 0x74b121},
			{  781,  327, 0xf2f6f3},
			{  809,  331, 0xb7cabd},
			{  787,  339, 0xa5bcac},
			}) then
		nLog("219 使用")
		touch.tap(787,  339)
	elseif screen.is_colors({
			{  761,  387, 0x78b620},
			{  793,  380, 0x6ea41c},
			{  814,  401, 0xebf0ec},
			{  801,  401, 0xf4f7f4},
			})then
		nLog("227 使用")
		touch.tap(801,  401)
	elseif screen.is_colors({
			{  534,  422, 0x697a36},
			{  590,  421, 0x677933},
			{  567,  439, 0xa5bd01},
			{  554,  443, 0xfcfdfb},
			})then
		nLog("227 使用")
		touch.tap(554,  443)
	elseif screen.is_colors({
			{  768,  411, 0x70ac1f},
			{  791,  417, 0x89d028},
			{  815,  428, 0xf4f7f4},
			})then
		nLog("242 使用")
		touch.tap(815,  428)
	elseif screen.is_colors({
			{  767,  446, 0x70ac20},
			{  794,  446, 0x79b921},
			{  801,  463, 0xf7f9f6},
			})then
		nLog("242 使用")
		touch.tap(801,  463)
	elseif screen.is_colors({
			{  651,  252, 0x7dfd34},
			{  651,  255, 0x44f723},
			{  652,  264, 0x3ffd35},
			}) then
		nLog("210 穿上")
		touch.tap(963,404)
	elseif screen.is_colors({
			{  651,  249, 0xf15e12},
			{  651,  254, 0xf3590a},
			{  651,  263, 0xea781b},
			})then
		nLog("217 出售")
		touch.tap(960,464)
	elseif screen.is_colors({
			{  215,   28, 0xc47141},
			{  243,   28, 0xe1834c},
			{  259,   44, 0xd8c9c3},
			}) then
		nLog("打开背包")
		touch.tap(921,571) --整理

		sys.msleep(7000)
		touch.tap(776,567) --一键出售
		sys.msleep(500)
		touch.tap(621,131)--点击第一件装备
		sys.msleep(500)	
	elseif screen.is_colors({
			{   64,  567, 0xf2f1ee},
			{   61,  577, 0xc6c0b8},
			{   51,  589, 0x725634},
			}) then
		nLog("210 点击满字箭头")
		touch.tap(51,  589)
		sys.msleep(2000)
		touch.tap(201,590) --点击背包
	elseif screen.is_colors({
			{  536,  502, 0x758637},
			{  573,  503, 0x829435},
			{  562,  521, 0xdbdbdb},
			})then
		nLog("292 确定")
		touch.tap(562,  521)
	elseif screen.is_colors({
			{  286,  441, 0x7d482c},
			{  325,  450, 0xd8a84d},
			{  355,  460, 0xd5d0bb},
			})then
		nLog("299 领取奖励20/20")
		touch.tap(355,  460)
	elseif screen.is_colors({
			{  879,  556, 0x667934},
			{  927,  560, 0x92a07f},
			{  921,  576, 0x9eb900},
			})then
		nLog("306 前往领取")
		touch.tap(921,  576)
	elseif screen.is_colors({
			{  536,  409, 0x627532},
			{  564,  410, 0x708836},
			{  594,  410, 0x637035},
			{  563,  428, 0xa0be02},
			}) then
		nLog("108 选择奖励")
		touch.tap(563,  428)
	elseif screen.is_colors({
			{  657,  440, 0x7f9075},
			{  698,  439, 0x9eab96},
			{  681,  450, 0xa4be01},
			{  451,  442, 0xc6743b},
			}) then
		nLog("116 取消购买")
		touch.tap(451,  442)
	elseif screen.is_colors({
			{  535,  403, 0x768934},
			{  599,  402, 0x6f8535},
			{  566,  414, 0xa5bd03},
			{  773,  194, 0xa66d34},
			}) then
		nLog("125 取消充值")
		touch.tap(773,  194)
		sys.msleep(500)
		touch.tap(1060,   33)
	elseif screen.is_colors({
			{  534,  396, 0x765a32},
			{  537,  420, 0xa85b03},
			{  567,  410, 0xde7b3e},
			})then
		nLog("235 检查到非法软件运行游戏")
		touch.tap(567,  410)
	elseif screen.is_colors({
			{  329,   35, 0xeddaa2},
			{  352,   41, 0xe4d29b},
			{  373,   40, 0x786d3a},
			})then
		nLog("1419 点击系统设置tab")
		touch.tap(373,   40)
	elseif screen.is_colors({
			{   61,  571, 0x918578},
			{   69,  577, 0xb4ada4},
			{   48,  587, 0xaa844b},
			})then
		nLog("242 背包满")
		touch.tap(48,  587)
	elseif screen.is_colors({
			{  456,  457, 0x588231},
			{  521,  476, 0x5c9011},
			{  487,  468, 0xe6e8e2},
			{  495,  468, 0xd0ed57},
			})then
		nLog("377 切换账号")
		touch.tap(495,  468)
	elseif screen.is_colors({
			{  463,  480, 0x54880c},
			{  519,  478, 0x588d0c},
			{  488,  471, 0xfffffe},
			{  499,  468, 0x5a694a},
			})then
		nLog("416 切换账号")
		touch.tap(499,  468)
	elseif screen.is_colors({
			{  749,  407, 0x507729},
			{  782,  417, 0xb8eb4e},
			{  802,  418, 0x90ba40},
			}) then
		nLog("124 使用金币")
		touch.tap(802,  418)
		--[[
	elseif screen.is_colors({
			{  752,  400, 0x5a8230},
			{  806,  401, 0x5b8632},
			{  780,  419, 0xa3d82b},
			}) then
		nLog("175 资源找回，立即前往")
		touch.tap(780,  419)
		]]--	
		--[[
	elseif screen.is_colors({
			{  991,  339, 0x885b36},
			{  996,  339, 0xa07248},
			{  996,  346, 0x977049},
			{ 1003,  342, 0x4a240a},
			})then
		nLog("482 我要变强")
		touch.tap(1003,  342)
		]]--
	elseif screen.is_colors({
			{  758,  407, 0x537c2a},
			{  807,  411, 0x648d31},
			{  777,  423, 0x387420},
			{  787,  424, 0xcfdcd3},
			}) then 
		nLog("109 查看装备")
		sys.msleep(100)
		touch.tap(787,  424)
	elseif screen.is_colors({
			{  747,  408, 0x577c2f},
			{  768,  419, 0xc7d5cb},
			{  789,  418, 0xfbfcfa},
			}) then --查看装备
		nLog("71 查看装备")
		sys.msleep(200)
		touch.tap(789,  418)
	elseif screen.is_colors({
			{  924,  402, 0x679f1e},
			{  947,  408, 0xeef3ef},
			{  977,  419, 0xa8beb0},
			}) then --穿上
		nLog("79 穿上")
		sys.msleep(200)
		touch.tap( 977,  419)
	elseif screen.is_colors({
			{  747,  407, 0x4f7728},
			{  753,  427, 0x588f0f},
			{  771,  420, 0xaac0b2},
			{  795,  419, 0xf8faf8},
			}) then --装备武器衣服
		nLog("812 装备武器衣服")
		sys.msleep(200)
		touch.tap(795,  419)
	elseif screen.is_colors({
			{  921,  387, 0x67a01d},
			{  950,  406, 0xfffffe},
			{  976,  401, 0xfafbfa},
			}) then --穿上装备
		nLog("104 穿上装备")
		sys.msleep(200)
		touch.tap(976,  401)	
	elseif screen.is_colors({
			{  759,  401, 0x5b832e},
			{  800,  402, 0x598430},
			{  833,  255, 0xe6dbb0},
			{  833,  271, 0xc98b41},
			}) then
		nLog("92 关闭查看窗口")
		touch.tap(833,  271)
	elseif screen.is_colors({
			{  344,  502, 0x7b5a35},
			{  413,  500, 0x765933},
			{  364,  527, 0xb46401},
			{  393,  515, 0xb5a78c},
			}) then
		nLog("100 安全区复活")
		touch.tap(393,  515)
	elseif screen.is_colors({
			{   12,  316, 0x969200},
			{   19,  317, 0xf2f200},
			{   30,  319, 0xdad900},
			{   49,  320, 0xd7d500},
			}) then
		nLog("108 参加赏金任务")
		touch.tap( 49,  320)
	elseif screen.is_colors({
			{  466,  136, 0x6b9335},
			{  522,  136, 0x699134},
			{  492,  138, 0xbde053},
			{  492,  149, 0x98cd2a},
			}) then
		nLog("116 前往赏金")
		touch.tap(492,  149)
	elseif screen.is_colors({
			{  108,  560, 0x5a8431},
			{  161,  560, 0x648e33},
			{  112,  578, 0xa5bca1},
			{  155,  577, 0xf9fae6},
			})then
		nLog("124 领取任务")
		touch.tap(155,  577)
	elseif screen.is_colors({
			{  878,  555, 0x647a33},
			{  952,  553, 0x5e7331},
			{  885,  577, 0xb1bb9d},
			{  923,  572, 0xf2f4de},
			}) then
		nLog("132 前往")
		touch.tap(923,  572)
	elseif screen.is_colors({
			{  112,  554, 0x2b5c81},
			{  161,  553, 0x2d6388},
			{  138,  572, 0xeaecdc},
			}) then
		nLog("139 进入副本")
		touch.tap( 138,  572)
		--[[
	elseif screen.is_colors({
			{  891,  319, 0xd4ac5e},
			{  888,  329, 0xc18f37},
			{  899,  334, 0xb48837},
			}) then 
		nLog("476 点击邮件")
		sys.msleep(100)
		touch.tap(899,  334)
	elseif screen.is_colors({
			{  897,  322, 0xd5aa49},
			{  905,  335, 0xb07e2b},
			{  888,  328, 0xbf8d32},
			}) then
		nLog("653 点击邮件")
		touch.tap(888,  328)
	elseif screen.is_colors({
			{  885,  556, 0x697d36},
			{  920,  564, 0x9dae3a},
			{  955,  559, 0x6a8133},
			{  922,  580, 0x9cbf02},
			}) then
		nLog("107 领取邮件奖励")
		touch.tap(922,  580)
		sys.msleep(1000)
		touch.tap(1068,35)
	elseif screen.is_colors({
			{  928,  560, 0x606d6e},
			{  890,  557, 0x515d5f},
			{  805,  565, 0x356e8f},
			{  776,  571, 0x0583b5},
			}) then
		nLog("107 删除邮件")
		touch.tap(776,  571)
		]]--
	elseif screen.is_colors({
			{  927,  555, 0x667c33},
			{  954,  572, 0x6c8a00},
			{  985,  548, 0x960304},
			}) then
		nLog("228 加点")
		touch.tap(954,  572)
	elseif screen.is_colors({
			{  140,  574, 0xc52701},
			{  150,  572, 0xb10a00},
			{  119,  586, 0x745b2d},
			})then
		nLog("464 点击角色")
		touch.tap(119,  586)
	elseif screen.is_colors({
			{  387,  295, 0xf2e1d8},
			{  366,  317, 0x5e493c},
			{  411,  350, 0xb0a595},
			})then
		nLog("768 诅咒之戒")
		touch.tap(411,  350)
	elseif screen.is_colors({
			{   32,  215, 0xffb000},
			{   19,  286, 0xe82100},
			{   37,  287, 0xb91f00},
			})then
		nLog("706 诅咒之戒")
		touch.tap(32,  215)	
	elseif screen.is_colors({
			{  948,  577, 0x667d35},
			{ 1021,  579, 0x677b36},
			{  956,  597, 0x70835c},
			{ 1014,  597, 0xe2e6ce},
			})	then
		nLog("479 挑战戒灵")
		touch.tap(1014,  597)
	elseif screen.is_colors({
			{  516,   22, 0xb91500},
			{  471,   36, 0xfe8f43},
			{  204,  321, 0xa40800},
			})then
		nLog("235 坐骑技能")
		touch.tap(204,  321)
	elseif screen.is_colors({
			{  733,  558, 0xb6a690},
			{  803,  556, 0x785b34},
			{  771,  576, 0xbd5501},
			})then
		nLog("236 自动驯养")
		touch.tap(771,  576)
	elseif screen.is_colors({
			{  386,  571, 0xb30f09},
			{  358,  570, 0xe99f28},
			{  362,  594, 0x261808},
			})then 
		nLog("200 强化")
		touch.tap(362,  594)
	elseif screen.is_colors({
			{  731,  557, 0x7c6037},
			{  816,  556, 0x6e5533},
			{  743,  577, 0xf4f3f0},
			{  778,  574, 0xf3f1ee},
			}) then
		nLog("208 自动强化")
		touch.tap(778,  574)
	elseif screen.is_colors({
			{   43,  595, 0xf8e3a9},
			{   48,  587, 0xab854b},
			{   63,  574, 0xb4110c},
			{   31,  608, 0xbf8e6d},
			}) then
		nLog("579 点击左下角任务")
		touch.tap(31,  608)

	elseif screen.is_colors({
			{  729,  555, 0x325c76},
			{  755,  568, 0x1a2c47},
			{  773,  570, 0x0480b3},
			}) then
		nLog("321 一键申请")
		touch.tap(773,  570)
	elseif screen.is_colors({
			{  829,  554, 0x9f0503},
			{  749,  577, 0x0169a8},
			{  774,  568, 0x4bb1d2},
			}) then
		nLog("215 一键申请")
		touch.tap(774,  568)
	elseif screen.is_colors({
			{  116,  589, 0x7e5622},
			{  128,  588, 0x845825},
			{  145,  567, 0x780000},
			{  148,  572, 0xb81400},
			}) then
		nLog("587 点击角色头像")
		touch.tap(116,  589)
	elseif screen.is_colors({
			{  170,  343, 0xcceab8},
			{  200,  348, 0xdfeebe},
			{  210,  316, 0x710000},
			}) then
		nLog("107 坐骑技能")
		touch.tap(210,  316)
	elseif screen.is_colors({
			{  513,   18, 0x770000},
			{  517,   21, 0xab0c00},
			{  509,   21, 0xaa0500},
			})then 
		nLog("154 点击坐骑")
		touch.tap(509,   21)
	elseif screen.is_colors({
			{  775,  519, 0x596e2b},
			{  798,  529, 0xbecc4b},
			{  824,  529, 0xe5e9d1},
			{  840,  535, 0x87a000},
			}) then
		nLog("115 学习技能")
		touch.tap(840,  535)
		sys.msleep(1000)
		touch.tap(897,85)
	elseif screen.is_colors({
			{  883,  561, 0x708735},
			{  986,  551, 0xba1600},
			{  959,  557, 0x657634},
			{  921,  573, 0xa4bc00},
			}) then
		nLog("125 加点")
		touch.tap(921,  573)
	elseif screen.is_colors({
			{  894,  560, 0x758933},
			{  924,  560, 0x809337},
			{  897,  573, 0x1f3d0b},
			{  915,  573, 0xdfe3db},
			}) then
		nLog("133 加点")
		touch.tap( 915,  573)
	elseif screen.is_colors({
			{  643,  520, 0x336182},
			{  684,  520, 0x377090},
			{  684,  536, 0x078bc5},
			{  697,  530, 0x79838b},
			}) then
		nLog("141 推荐")
		touch.tap( 697,  530)
		sys.msleep(1000)
		touch.tap(828,526)
		sys.msleep(1000)
		touch.tap(1062,33)
	elseif screen.is_colors({
			{  745,  401, 0x56812e},
			{  785,  407, 0xa5c84a},
			{  819,  422, 0x51850d},
			}) then
		nLog("91 买一组")
		touch.tap(819,  422)
	elseif screen.is_colors({
			{  639,  144, 0xa8fc47},
			{  603,  121, 0xfcf8c0},
			{  627,  123, 0x8d6b26},
			}) then
		nLog("98 穿戴橙色装备")
		touch.tap(627,  123)
	elseif screen.is_colors({
			{  598,  110, 0x6e3400},
			{  613,  110, 0x793702},
			{  635,  109, 0x612c00},
			}) then
		nLog("105 穿戴橙色装备")
		touch.tap(627,  123)	
	elseif screen.is_colors({
			{  933,  369, 0x72af1e},
			{  966,  366, 0x72ad21},
			{  970,  385, 0xd2ded6},
			}) then
		nLog("485 穿上")
		touch.tap(970,  385)
	elseif screen.is_colors({
			{  934,  430, 0x72ac1f},
			{  960,  427, 0x6ea81d},
			{  990,  441, 0x689d1d},
			{  950,  441, 0xfffffe},
			}) then
		nLog("113 穿上")
		touch.tap(950,  441)
	elseif screen.is_colors({
			{   64,  573, 0xe3e0dc},
			{   69,  567, 0xd9d5d0},
			{   58,  568, 0x3b220b},
			}) then
		nLog("514 点击左下角箭头")
		touch.tap(51,590)
		sys.msleep(500)
		touch.tap(204,594)
	elseif screen.is_colors({
			{  730,  557, 0x697e34},
			{  776,  561, 0x809334},
			{  801,  576, 0x7ea301},
			}) then
		nLog("100 一键出售")
		touch.tap(801,  576)
		sys.msleep(500)
		touch.tap(780,  531)
		sys.msleep(1000)
		touch.tap(1068,36)
	elseif screen.is_colors({
			{  734,  517, 0x637833},
			{  806,  521, 0x718437},
			{  779,  543, 0xbbcdc1},
			{  780,  531, 0xc3d047},
			}) then
		nLog("108 确认出售")
		touch.tap(780,  531)
	elseif screen.is_colors({
			{  744,  461, 0x6e8635},
			{  804,  459, 0x6c8036},
			{  777,  480, 0x7b9904},
			}) then
		nLog("117 立即体验")
		touch.tap(777,  480)
	elseif screen.is_colors({
			{  562,  255, 0x8f4c26},
			{  573,  254, 0xb26a42},
			{  568,  263, 0xb99788},
			}) then
		nLog("124 新功能开启 战盟")
		touch.tap(568,  263)
	elseif screen.is_colors({
			{  535,  396, 0x765b32},
			{  598,  393, 0x715731},
			{  562,  420, 0xdcd8d5},
			})then
		nLog("662 断开连接 确定")
		touch.tap(562,  420)
	elseif screen.is_colors({
			{  653,  471, 0x408ed6},
			{  773,  467, 0x408ed6},
			{  688,  491, 0xffffff},
			{  744,  492, 0xf5f9fd},
			})then
		nLog("670 立即登陆")
		touch.tap(744,  492)
	elseif screen.is_colors({
			{  816,  550, 0x7e3522},
			{  816,  604, 0x55392e},
			{  869,  554, 0xcf4825},
			})then
		nLog("663 再次体验天神")
		touch.tap(838,  579)
	elseif screen.is_colors({
			{  816,  553, 0xfd6222},
			{  843,  545, 0xff6a1e},
			{  814,  607, 0x553a2e},
			}) then
		nLog("684 再次体验天神")
		touch.tap(844,  584)
	elseif screen.is_colors({
			{  831,  556, 0x362436},
			{  818,  566, 0x160810},
			{  814,  591, 0x5b3a26},
			}) then
		nLog("223 再次体验天神")
		touch.tap(814,  591)
	elseif screen.is_colors({
			{  818,  548, 0xff6521},
			{  812,  601, 0xff752d},
			{  816,  572, 0x200a11},
			})  then
		nLog("91 再次体验天神之戒")
		sys.msleep(200)
		touch.tap(  816,  572)

	elseif screen.is_colors({
			{  382,  318, 0xa25513},
			{  386,  356, 0x3f1700},
			{  423,  333, 0xcac1bf},
			{  394,  333, 0xdba950},
			})  then
		nLog("100 获得破风之戒")
		sys.msleep(200)
		touch.tap(  394,  333)


	elseif screen.is_colors({
			{   30,  203, 0xc64ee4},
			{  117,  223, 0xf9f9f8},
			{  163,  227, 0xbbbbad},
			}) then --诺玛村庄，前往挑战
		nLog("112 诺玛村庄，前往挑战")
		sys.msleep(200)
		touch.tap(163,  227)
	elseif screen.is_colors({
			{  951,  581, 0x2f4b15},
			{  964,  594, 0xd9dec5},
			{ 1006,  596, 0xf1f3dd},
			{  995,  595, 0xa2ba00},
			}) then --挑战戒灵
		nLog("185 挑战戒灵")
		sys.msleep(200)
		touch.tap(995,  595)

	elseif screen.is_colors({
			{  298,  265, 0x925822},
			{  310,  283, 0xf1eeeb},
			{  349,  277, 0xfdfdfb},
			}) then --挑战戒灵
		nLog("194 挑战戒灵")
		sys.msleep(200)
		touch.tap(349,  277)
	elseif screen.is_colors({
			{  387,  306, 0xffffff},
			{  406,  310, 0xf55ef7},
			{  381,  334, 0xbe7f35},
			}) then --获得戒指
		nLog("128 获得戒指")
		sys.msleep(200)
		touch.tap(381,  334)
	elseif screen.is_colors({
			{  520,  221, 0xf9dd93},
			{  546,  224, 0xf3c761},
			{  583,  221, 0xffe098},
			{  617,  231, 0xcb9053},
			})  then
		nLog("203 获得戒指")
		sys.msleep(100)
		touch.tap(617,  231)
	elseif screen.is_colors({
			{  391,  293, 0x573c26},
			{  415,  291, 0x24a600},
			{  445,  289, 0x23b800},
			{  462,  294, 0x20e300},
			}) then
		nLog("203 点击支线任务")
		sys.msleep(100)
		touch.tap(462,  294)
		--[[
	elseif screen.is_colors({
			{   25,  256, 0xfcfc00},
			{   19,  282, 0xd12000},
			{  113,  286, 0xf22200},
			}) then --点击主线红色任务
		nLog("136 点击主线红色任务")
		sys.msleep(200)
		--touch.tap(113,  286)
		sys.msleep(200)
		touch.tap(114,211)
	]]--	
	elseif screen.is_colors({
			{   22,  259, 0x06d0cc},
			{   36,  260, 0x0c9b93},
			{   67,  261, 0x02efee},
			{   51,  266, 0x01f2f1},
			}) then 
		nLog("220 接取支线任务")
		sys.msleep(100)
		touch.tap(51,  266)
	elseif screen.is_colors({
			{   57,  259, 0x1efc00},
			{   68,  255, 0x1ebc00},
			{   75,  266, 0x1efc00},
			{   81,  266, 0x1efd00},
			}) then 
		nLog("229 交付支线任务")
		sys.msleep(100)
		touch.tap(81,  266)
	elseif screen.is_colors({
			{  870,  554, 0x355a73},
			{  971,  584, 0x0065bb},
			{  897,  582, 0x016ec0},
			{  920,  570, 0x1089b8},
			}) then --前往交付
		nLog("54 -前往交付")
		sys.msleep(200)
		touch.tap(920,  570)		
	elseif screen.is_colors({
			{  426,  287, 0x1fe600},
			{  444,  289, 0x21d400},
			{  462,  291, 0x20dc00},
			{  439,  291, 0x402a13},
			}) then
		nLog("236 接取支线任务")
		sys.msleep(100)
		touch.tap(439,  291)
	elseif screen.is_colors({
			{  309,  183, 0xe02100},
			{  326,  186, 0x901d00},
			{  332,  187, 0xca2000},
			{  353,  188, 0xf22100},
			}) then
		nLog("802 55级可接取")
		touch.tap(1066,29)
	elseif screen.is_colors({
			{  176,  290, 0x573b29},
			{  188,  290, 0xdab669},
			{  198,  295, 0xceab61},
			}) then
		nLog("466 50级之前进行主线任务")
		touch.tap(918,568)
	elseif screen.is_colors({
			{  182,  288, 0xdeba6b},
			{  181,  295, 0xd1ae63},
			{  199,  286, 0xd3b065},
			{  194,  296, 0xdeba6b},
			{  921,  568, 0x758925},
			}) then
		nLog("452 50级之前进行主线任务")
		touch.tap(921,  568)
	elseif screen.is_colors({
			{  390,  293, 0x573c26},
			{  416,  286, 0xed0200},
			{  433,  289, 0xff0000},
			{  453,  293, 0xf70000},
			}) then
		nLog("258 点击进行中的支线任务")
		sys.msleep(200)
		touch.tap(453,  293)
	elseif screen.is_colors({
			{  115,  223, 0xfdfdfc},
			{  137,  229, 0xdbdbd4},
			{  150,  228, 0xa5a693},
			{  165,  228, 0xa8a997},
			}) then
		nLog("211 前往挑战")
		sys.msleep(200)
		touch.tap(165,  228)
	elseif screen.is_colors({
			{   14,  252, 0xc7c500},
			{   36,  268, 0xcecc00},
			{   53,  257, 0xc5c300},
			{   34,  285, 0xf4f1f0},
			}) then
		nLog("625 引")
		touch.tap(34,  285)
	elseif screen.is_colors({
			{   13,  260, 0xcbc900},
			{   37,  266, 0xc1bf01},
			{   80,  259, 0xe2e100},
			})then
		nLog("943 引")
		touch.tap(80,  259)
	elseif screen.is_colors({
			{  788,  267, 0xf88c01},
			{  742,  269, 0xf98d01},
			{  840,  264, 0xb17b42},
			})then
		nLog("950 关闭到期提醒")
		touch.tap(840,  264)
	elseif screen.is_colors({
			{   18,  282, 0xf9f8f7},
			{   81,  287, 0xf6f4f3},
			{  145,  280, 0xccc6c0},
			})then
		nLog("950 点击活动页面")
		touch.tap(145,  280)
	elseif screen.is_colors({
			{  198,  152, 0xe3d008},
			{  218,  155, 0xc18700},
			{  202,  172, 0xf6f215},
			})then
		nLog("957 点击活动页面-赏金任务")
		touch.tap(493,  151)
	elseif screen.is_colors({
			{  106,  558, 0x557e2f},
			{  165,  555, 0x537c2a},
			{  125,  578, 0xe6edd7},
			{  142,  577, 0xa5db2d},
			})then
		nLog("972 领取任务")
		touch.tap(142,  577)
	elseif screen.is_colors({
			{  762,  265, 0xf48a02},
			{  803,  271, 0xd27908},
			{  838,  267, 0xa96c35},
			})then
		nLog("979 守护过期")
		touch.tap(838,  267)
	elseif screen.is_colors({
			{  526,  429, 0xdaaf34},
			{  569,  434, 0xd8ad36},
			{  623,  427, 0xdecd53},
			{  589,  434, 0xd6ae22},
			})then
		nLog("987 复活")
		fuhuo = fuhuo +1
		sys.msleep(8000)
		if fuhuo >2 then
			if screen.is_colors({
					{ 1074,   46, 0xc29457},
					{ 1086,   50, 0x5a3813},
					{ 1078,   77, 0xcbb665},
					}) then
				nLog("994 复活，退出")
				touch.tap(1086,   50)
			end
		end 
		--touch.tap(53,596)
		--sys.msleep(1000)
		--touch.tap(119,  589)
	elseif screen.is_colors({
			{  658,  396, 0x637633},
			{  720,  397, 0x627832},
			{  686,  413, 0xfdfde9},
			})then
		nLog("1005 确认-退出副本")
		touch.tap(686,  413)

	elseif screen.is_colors({
			{   20,  149, 0x625137},
			{   35,  157, 0xe8e8d6},
			{   71,  164, 0xcfcebe},
			}) then --点击任务栏
		nLog("1050 点击任务栏")
		sys.msleep(200)
		touch.tap(71,  164)	
	elseif screen.is_colors({
			{  424,  287, 0x1ef800},
			{  416,  291, 0x20db00},
			{  453,  296, 0x20e400},
			}) then
		nLog("275 交付支线任务")
		sys.msleep(100)
		touch.tap(453,  296)
	elseif screen.is_colors({
			{  407,  290, 0x563d29},
			{  428,  289, 0xfe0000},
			{  442,  290, 0xfd0000},
			{  465,  291, 0xd60500},
			})then
		nLog("1440 点击进行中支线任务")
		touch.tap(407,  290)
	elseif screen.is_colors({
			{  399,  289, 0x563d29},
			{  429,  289, 0xff0000},
			{  443,  289, 0xff0000},
			{  466,  290, 0x451601},
			{  416,  293, 0xe70300},
			})then
		nLog("1449 点击进行中支线任务")
		touch.tap(369,  293)
	elseif screen.is_colors({
			{  877,  561, 0x435c1e},
			{  961,  564, 0x344f21},
			{  923,  569, 0xf9fae5},
			}) then
		nLog("415 立即前往")
		touch.tap(923,  569)
	elseif screen.is_colors({
			{  873,  556, 0x657834},
			{  894,  570, 0x729105},
			{  920,  571, 0x9eb600},
			{  931,  570, 0xcad1b7},
			}) then --立即前往
		nLog("1447 立即前往")
		sys.msleep(200)
		touch.tap( 931,  570)
	elseif screen.is_colors({
			{  102,  558, 0x537d2c},
			{  143,  569, 0xb3d44f},
			{  162,  571, 0x9abd3f},
			}) then
		nLog("292 领取奖励")
		sys.msleep(100)
		touch.tap(162,  571)
	elseif screen.is_colors({
			{  104,  560, 0x578130},
			{  182,  583, 0x57890e},
			{  140,  570, 0xadcc47},
			}) then
		nLog("162 领取奖励")
		sys.msleep(200)
		touch.tap(142,  575)
	elseif screen.is_colors({
			{  104,  558, 0x557e30},
			{  183,  587, 0x609d18},
			{  124,  569, 0xedefda},
			{  142,  575, 0xaae32d},
			}) then
		nLog("171 领取奖励")
		sys.msleep(200)
		touch.tap(142,  575)
	elseif screen.is_colors({
			{  102,  559, 0x588131},
			{  182,  585, 0x538c13},
			{  141,  572, 0xd9ef5a},
			{  155,  575, 0xf4f6e2},
			}) then --领取奖励
		nLog("180 领取奖励")
		sys.msleep(200)
		touch.tap(155,  575)
	elseif screen.is_colors({
			{ 1034,   35, 0xd4be74},
			{ 1071,   30, 0xedd98b},
			{ 1095,   47, 0xbea94d},
			}) then --跳过剧情
		nLog("163 跳过剧情")
		sys.msleep(200)
		touch.tap(1095,   47)
	elseif screen.is_colors({
			{  819,  551, 0xfc5922},
			{  817,  603, 0x984028},
			{  830,  581, 0x6c140b},
			}) then --体验天神之威
		nLog("171 体验天神之威")
		sys.msleep(200)
		touch.tap(830,  581)
	elseif screen.is_colors({
			{  753,  537, 0x5d6f2e},
			{  764,  553, 0xf9faf7},
			{  790,  562, 0xfffffe},
			}) then --退出
		nLog("179 退出")
		sys.msleep(200)
		touch.tap(790,  562)
	elseif screen.is_colors({
			{  553,  215, 0xf7e7aa},
			{  371,  324, 0xda7c1f},
			{  433,  329, 0x513e38},
			}) then --获得戒指
		nLog("187 获得戒指")
		sys.msleep(200)
		touch.tap(433,  329)
	elseif screen.is_colors({
			{  870,  556, 0x647936},
			{  894,  569, 0xb4c748},
			{  919,  569, 0xcbda49},
			{  943,  569, 0xb3c443},
			}) then --立即前往
		nLog("196 立即前往")
		sys.msleep(200)
		touch.tap(943,  569)
	elseif screen.is_colors({
			{  872,  554, 0x315d78},
			{  921,  570, 0x007faf},
			{  946,  575, 0x0067a0},
			}) then
		nLog("359 立即前往")
		touch.tap(946,  575)
	elseif screen.is_colors({
			{  752,  410, 0x5b8631},
			{  770,  420, 0xa1b9a9},
			{  788,  418, 0xf4f7f4},
			}) then --查看更好的装备
		nLog("204 查看更好的装备")
		sys.msleep(200)
		touch.tap(788,  418)
	elseif screen.is_colors({
			{ 1108,   25, 0xf4e6a2},
			{ 1075,   28, 0xc2aa7f},
			{ 1102,   40, 0xb69e67},
			}) then --返回
		nLog("351 返回")
		sys.msleep(200)
		touch.tap(1102,   40)
	elseif screen.is_colors({
			{ 1017,   16, 0x48692e},
			{ 1046,   28, 0xcbba88},
			{ 1074,   28, 0xc0ab7f},
			{ 1102,   42, 0xa58b59},
			}) then --点击返回
		nLog("214 点击返回")
		sys.msleep(200)
		touch.tap(1102,   42)
	elseif screen.is_colors({
			{ 1034,   36, 0xd6c38a},
			{ 1095,   35, 0xf2e19f},
			{ 1087,   52, 0xa18850},
			}) then --返回
		nLog("222 返回")
		sys.msleep(200)
		touch.tap(1087,   52)
	elseif screen.is_colors({
			{  962,  567, 0x42352c},
			{  295,  185, 0xf22200},
			{  424,  289, 0x21db00},
			}) then --接取支线任务
		nLog("230 接取支线任务")
		sys.msleep(200)
		touch.tap(424,  289)
	elseif screen.is_colors({
			{  101,  557, 0x28597e},
			{  141,  573, 0x07a8e9},
			{  171,  565, 0xecf1e0},
			}) then --接受蓝色任务
		nLog("238 接受蓝色任务")
		sys.msleep(200)
		touch.tap(171,  565)
	elseif screen.is_colors({
			{ 1039,   23, 0xe2d098},
			{ 1067,   31, 0xb49666},
			{ 1098,   41, 0xaa8d59},
			}) then
		nLog("325 返回")
		sys.msleep(200)
		touch.tap(1098,   41)
	elseif screen.is_colors({
			{ 1112,   24, 0xfbf7b0},
			{ 1106,   41, 0xc99d53},
			{   30,  205, 0xe659f7},
			{  146,  228, 0xe5e6e3},
			}) then 
		nLog("248 第一次戒灵")
		sys.msleep(200)
		touch.tap(146,  228)
	elseif screen.is_colors({
			{  945,  578, 0x637734},
			{  974,  593, 0xfefeea},
			{ 1011,  591, 0xfefeea},
			{  995,  596, 0xa4bd01},
			}) then --挑战戒灵
		nLog("257 挑战戒灵")
		sys.msleep(200)
		touch.tap( 995,  596)

	elseif screen.is_colors({
			{  482,  103, 0xa78365},
			{  525,  476, 0x5d6e2e},
			{  725,  106, 0xa56b36},
			}) then --属性不足，关闭
		nLog("265 属性不足，关闭")
		sys.msleep(200)
		touch.tap(725,  106)
	elseif screen.is_colors({
			{  531,  323, 0xf4ea91},
			{  575,  323, 0xeed98b},
			{  573,  250, 0xffffff},
			}) then --前往冈德城
		nLog("273 前往冈德城")
		sys.msleep(200)
		touch.tap(573,  250)
	elseif screen.is_colors({
			{  106,  557, 0x2c5d7d},
			{  115,  570, 0xe2e4d6},
			{  145,  571, 0x848d93},
			{  141,  571, 0x08a9ee},
			}) then
		nLog("444 进入副本")
		sys.msleep(100)
		touch.tap(141,  571)
	elseif screen.is_colors({
			{ 1072,  329, 0x442e0e},
			{ 1082,  329, 0x54330a},
			{ 1091,  333, 0x8d6a28},
			}) then
		nLog("453 开启挂机")
		sys.msleep(100)
		touch.tap(1081,  328)
	elseif screen.is_colors({
			{ 1073,  331, 0x221217},
			{ 1088,  331, 0x291419},
			{ 1074,  345, 0x746c67},
			{ 1092,  363, 0xdbcb79},
			}) then
		nLog("555 开启挂机")
		touch.tap(1092,  363)
	elseif screen.is_colors({
			{  952,  584, 0xc3cbaf},
			{  979,  590, 0x7c9126},
			{  996,  595, 0x9cb400},
			}) then 
		nLog("468 挑战矮人")
		sys.msleep(100)
		touch.tap(996,  595)

	elseif screen.is_colors({
			{  444,  222, 0xf1c16a},
			{  467,  223, 0xf3af58},
			{  451,  240, 0xa24012},
			{  462,  240, 0xab481c},
			}) then
		nLog("654 点击礼包")
		touch.tap(462,  240)
	elseif screen.is_colors({
			{  559,  241, 0xfff2e9},
			{  576,  242, 0x7d6556},
			{  563,  254, 0xfce19f},
			}) then
		nLog("484 自主加点")
		touch.tap(563,  254)
	elseif screen.is_colors({
			{  243,  188, 0xfbfcfc},
			{  275,  192, 0xf3f2f1},
			{  324,  190, 0xd1cec9},
			{  381,  190, 0xeeedeb},
			}) then
		nLog("492 点击自主加点")
		touch.tap(116,597)
		--[[
	elseif screen.is_colors({
			{  441,   17, 0xd39251},
			{  485,   18, 0x9e5a2b},
			{ 1063,  304, 0x3ebcf2},
			}) then
		nLog("593 坐骑，点击下一篇")
		touch.tap(1063,  304)
		]]--
	elseif screen.is_colors({
			{  215,   26, 0x7d712a},
			{  241,   33, 0xb29829},
			{  266,   46, 0xf3e0a7},
			}) then
		nLog("677 点击角色标签")
		touch.tap(266,   46)
	elseif screen.is_colors({
			{  547,  254, 0xc99149},
			{  566,  244, 0xfffcbd},
			{  587,  252, 0x7f4d23},
			{  568,  261, 0xd6a240},
			}) then
		nLog("618 新功能开启 赏金任务")
		touch.tap(568,  261)
	elseif screen.is_colors({
			{  441,  107, 0xffff0c},
			{  574,  106, 0xfefe12},
			{  488,  221, 0x766654},
			}) then
		nLog("740 前往暗黑密道")
		touch.tap(488,  221)
	elseif screen.is_colors({
			{  523,  396, 0x745a33},
			{  601,  396, 0x725934},
			{  572,  419, 0xebe9e7},
			}) then
		nLog("762 重连")
		touch.tap(572,  419)
	elseif screen.is_colors({
			{  405,  315, 0x0ca700},
			{  389,  313, 0xe9d4c1},
			{  408,  339, 0xfffcfa},
			}) then
		nLog("1280 获得戒指-挽歌之戒")
		touch.tap(408,  339)
	elseif screen.is_colors({
			{  557,  249, 0xcf9a51},
			{  576,  247, 0xe8c074},
			{  567,  271, 0x7d422d},
			{  567,  233, 0xc6a877},
			})then
		nLog("1281 60级le 魔戒寻主")
		touch.tap(567,  233)
	elseif screen.is_colors({
			{  558,  252, 0xe1a862},
			{  574,  263, 0xcf8544},
			{  574,  283, 0x785122},
			}) then
		nLog("854 魔戒寻主")
		touch.tap(574,  283)
	elseif screen.is_colors({
			{  564,  257, 0x714023},
			{  572,  256, 0x964624},
			{  569,  267, 0xcdb5a9},
			})then
		nLog("1251 战盟")
		touch.tap(569,  267)
	elseif screen.is_colors({
			{  557,  259, 0x9f4d28},
			{  566,  259, 0xd4a93b},
			{  564,  273, 0x885425},
			})then
		nLog("1258 赏金任务 ")
		touch.tap(564,  273)
	elseif screen.is_colors({
			{  559,  257, 0xd5b872},
			{  575,  257, 0x8d5f35},
			{  568,  277, 0x2f190e},
			})then
		nLog("1251 新功能开启 自主加点 ")
		touch.tap(568,  277)
	elseif screen.is_colors({
			{  887,  558, 0x6c7d36},
			{  944,  556, 0x667632},
			{  914,  577, 0xfbfcfb},
			})then
		nLog("1258 第一次加点")
		touch.tap(914,  577)
	elseif screen.is_colors({
			{  793,  517, 0x6b8238},
			{  863,  517, 0x667833},
			{  826,  529, 0x24410d},
			})then
		nLog("1265 点击确认")
		touch.tap(826,  529)

	elseif screen.is_colors({
			{ 1079,  334, 0x987113},
			{ 1086,  335, 0xe4bc3d},
			{ 1082,  341, 0xd3a615},
			})then
		nLog("1258 开启挂机")
		touch.tap(1082,  341)
	elseif screen.is_colors({
			{  972,   34, 0xdac178},
			{ 1015,   30, 0xf8e196},
			{ 1092,   47, 0xc0a050},
			})then
		nLog("1265 跳过剧情")
		touch.tap(1092,   47)
	elseif screen.is_colors({
			{  991,   24, 0xf5d999},
			{ 1010,   31, 0xcda968},
			{ 1055,   27, 0xe9c88a},
			}) then
		nLog("808 跳过引导")
		touch.tap(1055,   27)
	elseif screen.is_colors({
			{  981,   33, 0xba9d57},
			{ 1023,   23, 0xf7e598},
			{ 1054,   30, 0xbf9764},
			{ 1085,   28, 0xd4c179},
			}) then
		nLog("626 跳过引导")
		touch.tap(1085,   28)
	elseif screen.is_colors({
			{  984,   26, 0xe5cb87},
			{ 1017,   30, 0xd2b26c},
			{ 1047,   24, 0xe9d68f},
			})then
		nLog("1051 跳过引导")
		touch.tap(1047,   24)

	elseif screen.is_colors({
			{  660,  460, 0x578031},
			{  710,  462, 0x6c9437},
			{  692,  475, 0xc7cec2},
			})then
		nLog("1058 692,  475 知道了")
		touch.tap(692,  475)
	elseif screen.is_colors({
			{  423,  290, 0xde0400},
			{  443,  289, 0xff0000},
			{  468,  291, 0xfd0000},
			{  452,  297, 0xfe0000},
			})then
		nLog("1839 点击支线任务")
		touch.tap(423,  290)
	elseif screen.is_colors({
			{  116,  223, 0xfcfcfb},
			{  137,  228, 0xefefec},
			{  151,  229, 0xe1e1db},
			{  164,  229, 0xb0b0a0},
			})then
		nLog("1833 前往挑战")
		touch.tap(164,  229)
	elseif screen.is_colors({
			{   29,  149, 0x635136},
			{   84,  166, 0x745118},
			{   45,  161, 0xdbdac8},
			})then
		nLog("1473 点击任务")
		touch.tap(45,  161)	
	elseif screen.is_colors({
			{  888,  555, 0x657834},
			{  945,  557, 0x6b7e35},
			{  910,  571, 0xffffeb},
			})then
		nLog("1480 前去领取")
		touch.tap(910,  571)
	elseif screen.is_colors({
			{ 1077,  336, 0xb28125},
			{ 1087,  335, 0xf0c03f},
			{ 1081,  345, 0x9d9d9a},
			})then
		nLog("1495 点击自动挂机")
		touch.tap(1081,  345)
	elseif screen.is_colors({
			{ 1079,  337, 0x9c6a05},
			{ 1076,  345, 0xedf2f1},
			{ 1085,  344, 0x7c807d},
			})then
		nLog("1502 自动挂机")
		touch.tap(1085,  344)

		--[[
	elseif screen.is_colors({
			{   61,  571, 0x790000},
			{   65,  574, 0x9f0704},
			{   49,  591, 0x543a18},
			})then
		nLog("1487 点击红色箭头")
		touch.tap(49,  591)
		
	elseif screen.is_colors({
			{   37,  595, 0x65502b},
			{   42,  605, 0x846930},
			{   31,  606, 0x866233},
			{   26,  610, 0x866436},
			})then
		nLog("1503 收回任务箭头")
		touch.tap(31,  606)
	]]--	
	elseif screen.is_colors({
			{  660,  405, 0x718636},
			{  722,  402, 0x677932},
			{  699,  425, 0xc5cdb1},
			})then
		nLog("1565 断网重连 确定")
		touch.tap(699,  425)
	elseif screen.is_colors({
			{  377,  314, 0xffd79b},
			{  417,  310, 0xe9ca86},
			{  406,  339, 0xb5a494},
			{  408,  351, 0x73604f},
			})then
		nLog("1757 天神之戒")
		touch.tap(408,  351)
	elseif screen.is_colors({
			{  813,  552, 0xc94120},
			{  813,  603, 0x7d3f2d},
			{  821,  568, 0x462232},
			})then
		nLog("再次体验天神")
		touch.tap(821,  568)
	elseif screen.is_colors({
			{ 1109,   29, 0xebd392},
			{ 1046,   27, 0xd5c28c},
			{ 1098,   43, 0x9b824e},
			}) then
		nLog("1908 返回")
		touch.tap(1098,   43)
	elseif screen.is_colors({
			{ 1040,   24, 0xdcca94},
			{ 1056,   28, 0xcab883},
			{ 1112,   33, 0xd2c084},
			{ 1097,   43, 0xaa8a53},
			})then
		nLog("1927 第一次返回")
		touch.tap(1097,   43)
	elseif screen.is_colors({
			{ 1047,   28, 0xcab983},
			{ 1081,   32, 0xae9864},
			{ 1056,   44, 0xdb883f},
			{ 1103,   44, 0xa9854f},
			})then
		nLog("1722 第一次返回")
		touch.tap(1103,   44)
	end	


	if fuhuo > 2 then
		if screen.is_colors({
				{  836,  583, 0xe0ccb3},
				{  842,  584, 0xd1bea2},
				{  839,  590, 0x70542b},
				}) then
			nLog("1430 直接点击设置")
			touch.tap(839,  590)
		else 
			if screen.is_colors({
					{  915,  583, 0xa59072},
					{  920,  583, 0xfbfaf2},
					{  922,  591, 0x563d25},
					})then
				nLog("1505 判定设置按钮的位置")
				touch.tap(922,  591)
			else
				touch.tap( 48,  589)
				sys.msleep(500)
				touch.tap(839,  588)
			end	
		end
		--[[
		if screen.is_colors({
				{   34,  599, 0xb38e51},
				{   38,  605, 0x5a3c24},
				{   48,  589, 0x927238},
				})then
			nLog("1429 点击左下角退出")
			touch.tap( 48,  589)
		end
		]]--
	end
	screen.unkeep()
	--nLog(fuhuo)
	sys.msleep(2000)
	--nLog("332 end")
	testrun()
end