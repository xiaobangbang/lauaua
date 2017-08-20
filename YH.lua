
device.set_volume(0)
device.set_brightness(0.7)

local Sr
local width, height = screen.size();
if width == 640 and height == 1136 then
    -- iPhone 5, 5S, iPod touch 5
	Sr = 'U5S'
elseif width == 1536 and height == 2048 then
    -- iPad 3,4,5, mini 2
	--sys.alert('对不起!未适配iPad 3,4,5, mini 2',5,'即将关闭！')
	--os.exit()
elseif width == 750 and height == 1334 then
    -- iPhone 6 iPhone 6s iPhone 7
	Sr = 'U6S'
elseif width == 768 and height == 1024 then
    -- iPad 1,2, mini 1
	--sys.alert('对不起!未适配iPad 1,2, mini 1',5,'即将关闭！')
	--os.exit()
elseif width == 1242 and height == 2208 then
	Sr = 'U6P'
    -- iPhone 6 Plus iPhone 6s Plus iPhone 7 Plus
	--sys.alert('对不起!未适配Plus 系列',5,'即将关闭！')
	--os.exit()
end



itu		= {					--经常性的操作
	close_all_app = (function() 
		for _,bid in ipairs(app.bundles()) do
			app.close(bid)
		end
	end),

	Rand = (function(strs,i) --随机生成给予的文本内容
			local RetStr,Length,Seed="",1,0
				if string.byte(strs:sub(1,1))>=0x80 then
					Length = 3
				end
			math.randomseed(tostring(os.time()):reverse():sub(1, 6) + sys.rnd() + (Seed or 0))
			math.random(string.len(strs)/Length)
				for i=1, i do
					Seed=math.random(string.len(strs)/Length)
					RetStr = RetStr..string.sub(strs,(Seed*Length)-(Length-1),(Seed*Length))
				end
			return(RetStr)
	end),

	Now = (function()--获取网络时间失败则获取本地时间并且格式化年月日
				local reptime = sys.net_time()
					if reptime == 0 then
						reptime = os.time()
					end
				reptime = os.date("%Y-%m-%d-%H-%M", tonumber(reptime))
				return reptime
	end),
	
	NowTime = (function()--获取网络时间失败则获取本地时间并且格式化年月日
				local reptime = sys.net_time()
					if reptime == 0 then
						reptime = os.time()
					end
				reptime = os.date("%Y-%m-%d %H:%M:%S", tonumber(reptime))
				return reptime
	end),
	
	Time = (function()--获取网络时间失败则获取本地时间并且格式化年月日
						reptime = os.time()
				reptime = os.date("%Y/%m/%d", tonumber(reptime))
				return reptime
	end),
	--local date=os.date(“%Y-%m-%d %H:%M:%S”);
	TimeMin = (function()--获取当前小时 24格式
		local reptime = ""
			reptime = os.time()
			reptime = os.date("%H", tonumber(reptime))
		return reptime
	end),
	--local date=os.date(“%Y-%m-%d %H:%M:%S”);
	TimeFen = (function()--获取当前分钟
		local reptime = ""
			reptime = os.time()
			reptime = os.date("%M", tonumber(reptime))
		return reptime
	end),

	hang = (function(paths,word)--增加指定文本一行内容
		local sa = io.open(paths,"a+");
			 sa:write(word.."\n");
			 sa:close();
	end),

	upFile = (function(paths,word,id)--更新指定文本内容 指定的行数
		local list = itu.readFile(paths);
		local files4 = io.open(paths,"w+");
			for i=1,#list do
				
				local PTU = list[i]:split('-')
				nLog(PTU[1]..'-'..id)
				
				if tostring(PTU[1]) == tostring(id) then
					nLog('修改')
					files4:write(word);
					files4:write("\n");
				else
					files4:write(list[i]);
					files4:write("\n");
				end
			end
		 files4:close();
	end),

	Dete = (function(paths,id)--更新指定文本内容 指定的行数
		local list = itu.readFile(paths);
		local files4 = io.open(paths,"w+");
			for i=1,#list do
				
				local PTU = list[i]:split('-')
				nLog(PTU[1]..'-'..id)
				
				if tostring(PTU[1]) == tostring(id) then
				else
					files4:write(list[i]);
					files4:write("\n");
				end
			end
		 files4:close();
	end),

	Path = (function(path,off) --检测指定路径的文件是否存在 支持新建
		local f = io.open(path, "r")
			if off == nil then
				if f == nil then
					os.execute("mkdir "..path)
				end
			else
				if f == nil then
				local oa = io.open(path,"w")
					oa:close()
				end
			end
		return f ~= nil and f:close()
	end),

	PathA = (function(path)--检测文件是否存 返回值
		local f = io.open(path, "rb") if f then f:close() end
		return f ~= nil
	end),
	
	readFile = (function(path)--读取指定路径的文件所有内容并且去掉换行符
		local file = io.open(path,"r");
		local _list = {};
			if file then
				for l in file:lines() do
					table.insert(_list,l)
				end
			file:close();
			end
			for i=1, #_list do
				_list[i] = string.gsub(_list[i], "\n", "")
			end
		return _list
	end),

	Get = (function(path)--获取指定路径下所有的文件名称包括有后缀和无后缀的文件图像
		local a = io.popen("ls "..path);
		local f = {};
			for l in a:lines() do
				table.insert(f,l)
				mSleep(10)
			end
		return f
	end),

	Length = (function(path)--获取指定路径的文件长度 换算为1024=1KB
		local fh=assert(io.open(path, "rb"))
		local len=assert(fh:seek("end"))
			fh:close()
		return len
	end),

	Unlock = (function(s)	--检测屏幕是否锁定进行解锁
		local s = s or 1
		screen.init(s)
		device.unlock_screen()
		if device.is_screen_locked() then
			device.unlock_orien()
		end
		if screen.is_keeped() then
			-- 屏幕已保持
			screen.unkeep()
		end
	end),
}

--创建一个加载表表的作用是有下表进行加载
--和一个通用表 适用于以下关键字
socket = require("socket")
--获取系统版本号
local Ur = sys.version() Ur = Ur:split('.') Ur = tonumber(Ur[1])
--获取局域网IP地址
local Intranet = "0" for i,v in ipairs(device.ifaddrs()) do if (v[1]=="en0") then Intranet = v[2] end end
--如是流量卡则使用设备名作为标识符
if Intranet == "0" then  Intranet = device.name() end
function Extranet() return simple_http.get("http://ttaozi.com/taocloud/", 5) or "0" end--获取外网IP
device.turn_on_bluetooth()
XY 		= {					--点击操作
	CLICK = (function(p,Wait,Waiting)--单击
		math.randomseed(tostring(os.time()):reverse():sub(1, 7))--设置时间种子 -- 初始化随机因子为一个真随机数
		local Wait = Wait or math.random(1, 50)
		local Waiting = Waiting or math.random(1, 100)
		touch.tap(p[1],p[2],Wait,Waiting)
	end),
	ToCLICK = (function(p,Wait,bting,Waiting)--单击
		math.randomseed(tostring(os.time()):reverse():sub(1, 7))--设置时间种子 -- 初始化随机因子为一个真随机数
		
		local Wait = Wait or math.random(1, 20)
		local bting = bting or math.random(1, 40)
		local Waiting = Waiting or math.random(1, 500)
		touch.on(p[1],p[2]):msleep(Wait):off():msleep(bting)
		touch.on(p[1],p[2]):msleep(Wait + 10):off():msleep(Waiting)
	end),

	Press = (function(p,Waiting)--按下
		math.randomseed(tostring(os.time()):reverse():sub(1, 7))--设置时间种子 -- 初始化随机因子为一个真随机数
		local Waiting = Waiting or math.random(1, 50)
		touch.on(p[1],p[2]):msleep(Waiting):off()
	end),
	TING = (function(p,BuChang,TwoBu,Waiting)--精确滑动
		math.randomseed(tostring(os.time()):reverse():sub(1, 7))--设置时间种子
		local BuChang = BuChang or math.random(10, 30)
		local TwoBu = TwoBu or math.random(1, 5)
		local Waiting = Waiting or math.random(300, 1000)
		touch.on(p[1], p[2])
			:step_len(BuChang)
			:move(p[3], p[4])
			:step_len(TwoBu)
			:move(p[5], p[6])
			
			:delay(Waiting)
		:off()
	end),
	TGP = (function(p,BuChang,Waiting)--精确滑动
		math.randomseed(tostring(os.time()):reverse():sub(1, 7))--设置时间种子
		local BuChang = BuChang or math.random(10, 30)
		local Waiting = Waiting or math.random(300, 1000)
		touch.on(p[1], p[2])
			:step_len(BuChang)
			:move(p[3], p[4])
			:delay(Waiting)
		:off()
	end),

}

Back 	= {					--备份和反备份操作

--快捷消退
_Back = (function(of)
	local tq = of or 50
	for s = 1,tq do
		key.press("BACKSPACE")
		sys.msleep(10)
	end
end),

}

function OcrText(x,y,x1,y1,p,ovp)--识别指定位置的数字

	if type(p) == "table" then
		nLog("*****************")
		return screen.image(x,y,x1,y1):binaryzation({{p[1],p[2]},}):tess_ocr{lang = "eng",white_list = ovp}:trim()
	else
		nLog("-----------------")
		return screen.ocr_text(x,y,x1,y1,{lang = "eng",white_list = p}, ovp):trim()
	end
end





_Salice = {
	Saread = os.time(), --负责检测游戏是否正常运行如不正常运行则重新开启并且登陆
	Inkstone = os.time(),--负责定时检测画面关键点数据变化用于判断是否卡死
}
local Pro_point = {}
for _k,_v in ipairs({{ 1092,   93, 0xbda289},{ 1024,  123, 0x4f542e},{  550,  341, 0xa5926d},{  577,  342, 0x5c534b},{  589,  342, 0xabab99},{  598,  299, 0x4c1913},{  535,  283, 0x331185},{   81,  587, 0x430043},{   95,  593, 0x460046},{  910,  199, 0xa5795a},{  292,   22, 0xbdae94},{  974,   62, 0x6b6152},{ 1055,  245, 0xce9e8c},{  646,  543, 0x736d39},{  429,  520, 0x948a73},{  222,  458, 0x948a7b},{  255,  244, 0xada694},{  553,  193, 0xdd7e2f},{  588,  182, 0x9b331e},{  579,  188, 0xffc95e},}) do
	Pro_point[_k] = GetPosColor(_v[1],_v[2])
end
local OrNo = false
local Dark = os.time()

function _YHSart(_tab)
    -- 判断是否传入的是正确内容
    if _G.DoName then table.insert(DoName,_tab.Name) else _G.DoName = {_tab.Name} end
    local _now = os.time()
    local _break = false
    local _Repeat = false
    for _key,_value in ipairs(_tab) do _value.RepeatTime = os.time() end
    if _tab.Begin then 
		if _tab.Begin() then
			return 
		end
	end

    while true do
        local _States = {}
        --寻找满足状态的项
        screen.keep()
			for _key,_value in ipairs(_tab) do
				--找色重复
				if _value[Sr].Color then
					if screen.is_colors(_value[Sr].Color, _value.csim or _tab.csim) then
						table.insert(_States,_key)
						if _tab.Repeat then
							if os.time() - _value.RepeatTime >= _tab.Repeat.n then
								_value.RepeatTime = os.time()
								if not _value.NoRepeat then _Repeat = true;nLog('-Color'.._value.Name..' 重复找色')  end
							end
						end
					else
						_value.RepeatTime = os.time()
					end
				end
				--区域找色重复
				if _value[Sr].SFColor then
					--区域找色
					S,K = screen.find_color(_value[Sr].SFColor[1],_value[Sr].SFColor[2],_value[Sr].SFColor[3] or 1 ,_value[Sr].SFColor[4] or 1 ,_value[Sr].SFColor[5] or 1136 ,_value[Sr].SFColor[6] or 768 )
					if S > 0 then
						table.insert(_States,_key)
						if _tab.Repeat then
							if os.time() - _value.RepeatTime >= _tab.Repeat.n then
								_value.RepeatTime = os.time()
								if not _value.NoRepeat then _Repeat = true;nLog('-SF:'.._value.Name..' 重复范围找色') end
							end
						end
					else
						 _value.RepeatTime = os.time()
					end
			   end
				
				--区域找图重复
				if _value[Sr].Image then
					ST,KT = screen.find_image(_value[Sr].Image[1],_value[Sr].Image[2],_value[Sr].Image[3] or 1 ,_value[Sr].Image[4] or 1 ,_value[Sr].Image[5] or 1136 ,_value[Sr].Image[6] or 768 )
					if ST > 0 then
						table.insert(_States,_key)
						if _tab.Repeat then
							if os.time() - _value.RepeatTime >= _tab.Repeat.n then
								_value.RepeatTime = os.time()
								if not _value.NoRepeat then _Repeat = true;nLog('-Image:'.._value.Name..' 重复图') end
							end
						end
					else
						_value.RepeatTime = os.time()
					end
				end
		end
        screen.unkeep()
        --超时判断
		

        if #_States == 0 then
            if _tab.timeout then
                if os.time() - _now >= _tab.timeout.n then
                    nLog('超时')
                    local _Back = _tab.timeout.Run()
                    if _Back then return end
                    if _tab.timeout.layer then _Sart(_tab.timeout.layer) end
                    _now = os.time()
                end
            end
        else
            --执行满足状态的项
			
            for _key,_value in ipairs(_States) do
                local _Handle = _tab[_value]
				if _Handle[Sr].SFColor then
					sys.log('SF:'.._Handle.Name) nLog('SF:'.._Handle.Name)
				elseif _Handle[Sr].Color then
					sys.log('Color'.._Handle.Name) nLog('Color'.._Handle.Name)
				elseif _Handle[Sr].Image then
					sys.log('Image:'.._Handle.Name) nLog('Image:'.._Handle.Name)
				end
				--下列执行可以进行记录 如果多久未执行直接关闭应用并且重新运行 有可能是断网倒是游戏失去连接
                if _Handle[Sr].Run then 
					if _Handle[Sr].Run() then _break = true end
				end 
                if _Handle[Sr].layer then _Sart(_Handle[Sr].layer) end
                _now = os.time()
            end
            if _break then break end
            if _Repeat then if _tab.Repeat.Run() then return end
                _Repeat = false
            end
			

        end


		--定时检测中控是否需要放入夹子
		sys.msleep(_tab.sleep or 200)
    end
    if _tab.End then _tab.End() end
    if type(_G.DoName) == 'table' then
        if #(_G.DoName) > 0 then
            table.remove(_G.DoName,#DoName)
        end
    end
end




YH = {
Accout = '',
_PassWord = "",
}


_JY_Ling 						= {							Name = '主线任务',
	inventory = false,		
	The = os.time(),			--直接冲
	Beibao = os.time(),
	主线和赏金 = false,
		{	Name = '@找点',
			U5S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
					nLog('---')
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 立即穿戴',
			U5S={
				Color = {
					{  770,  194, 0xa77034},{  607,  432, 0x83d000},
				},
				Run = (function()
					XY.CLICK({559, 417},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		
		{	Name = '@找点 装备提示',
			U5S={
				Color = {
					{  775,  193, 0xab733a},{  482,  400, 0x7b5c33},{  644,  401, 0x708236},
				},
				Run = (function()
					XY.CLICK({695, 414},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 药水 买一组',
			U5S={
				Color = {
					{  760,  397, 0x547b27},{  778,  431, 0x66a819},
				},
				Run = (function()
					XY.CLICK({760,  397},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 新手魔戒引导',
			U5S={
				Color = {
					{ 1092,   51, 0xae8b55},{ 1094,   35, 0xf1dd9f},{  685,   94, 0x4b7587},{  448,   94, 0x558aa4},
				},
				Run = (function()
					if screen.is_colors({{ 969,  610, 0x8ad400 },}, 85) then
						XY.CLICK({969,  610},20,1000)
					end
					XY.CLICK({1053, 46},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 坐骑返回',
			U5S={
				Color = {
					{ 1101,   43, 0xa98a52},{ 1111,   33, 0xd4c387},{ 1111,   30, 0xe2d18d},{  121,   36, 0xf8f5ec},{  121,   38, 0xd8d0bd},{  610,  589, 0x0a71d0},{  610,  590, 0x1786d1},{  763,  590, 0xe57e0a},{  763,  591, 0xab630a},{  922,  591, 0xa2c128},
				},
				Run = (function()
					XY.CLICK({1068, 31},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 确定清理',
			U5S={
				Color = {
					{  471,   77, 0x26110a},{  641,   76, 0x261510},{  799,   74, 0x202122},{  361,   74, 0x202427},{  592,  521, 0x41624c},{  748,  514, 0x697d2f},
				},
				Run = (function()
					XY.CLICK({783, 529},20,1000)
					XY.CLICK({1068, 33},20,1000)
					
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},
		
		{	Name = '@找点 背包页面',
			U5S={
				Color = {
					{  115,   43, 0xc28530},{  134,   48, 0x5c3c12},{  124,   64, 0x573112},{  140,   64, 0x67421f},{  729,  584, 0x7bbe00},{  536,  575, 0x0278fe},{  354,  570, 0x0061f0},{  171,  577, 0xf8c12f},{  872,  556, 0x667a35},
				},
				Run = (function()
					XY.CLICK({768, 562},20,1000)
					if not screen.is_colors({{ 471,   77, 0x26110a },{ 641,   76, 0x261510 },{ 799,   74, 0x202122 },{ 361,   74, 0x202427 },{ 592,  521, 0x41624c },{ 748,  514, 0x697d2f },}, 85) then
						XY.CLICK({1068, 33},20,1000)
					end
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},



		{	Name = '@找点 战斗奖励',
			U5S={
				Color = {
					{  571,  185, 0xedd95c},{  571,  190, 0xe7ca53},{  571,  204, 0xba842c},{  571,  245, 0xdacf6b},{  571,  246, 0xdacc67},{  615,  255, 0xd7b646},{  833,  590, 0xa1c328},{  833,  591, 0x3c540a},
				},
				Run = (function()
					XY.CLICK({826, 565},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 副本中',
			U5S={
				Color = {
					{ 1072,   32, 0xd5ac67},{ 1092,   34, 0xbf8f42},{ 1093,   46, 0xdfb66d},{ 1076,   54, 0x894e0f},{ 1073,   68, 0x6e4e22},{ 1092,   68, 0x7d633f},{ 1074,   60, 0xca9f55},{ 1068,   59, 0x492c17},
				},
				Run = (function()
					--未开启自动挂机状态
					if screen.is_colors({{1073,  331, 0x2a1815 },{1080,  333, 0xf9dd57 },{1086,  330, 0x2a1415 },{1087,  335, 0xf6cd3a },}, 85) then
						XY.CLICK({1081, 341},20,1000)
					end
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 解锁新地图',
			U5S={
				Color = {
					{  129,   37, 0xdfac4f},{  362,   17, 0xdf9f5c},{  481,  100, 0x817b33},{  540,  190, 0x848836},{  612,  479, 0xf8e24c},{  632,  373, 0x828032},{  350,   21, 0x9c5731},{  350,   17, 0xdc9e5f},
				},
				Run = (function()
					XY.CLICK({572, 270},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 挑战属性不足挑战危险',
			U5S={
				Color = {
					{  517,  102, 0xd8bd98},{  524,  102, 0xdbc09b},{  725,  106, 0xa66e34},{  564,  137, 0xa55631},{  564,  138, 0x7a4124},{  541,  476, 0x637930},{  550,  502, 0x7fa202},{  549,  513, 0x93e00a},
				},
				Run = (function()
					XY.CLICK({570, 492},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 剧情任务 窗口 任务窗口',
			U5S={
				Color = {
					{  923,  585, 0x0074ca},{ 1101,   43, 0xaa8b54},{  180,   38, 0x340300},{  121,   47, 0x955c44},{  151,   47, 0xede7af},{  121,   77, 0xd7a546},{  121,   83, 0xdd6f08},{  917,  584, 0x0072ca},
				},
				Run = (function()
					if screen.is_colors({{ 923,  585, 0x0074ca },}, 85) then
						XY.CLICK({923,  585},20,1000)
					end
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 vup 体验',
			U5S={
				Color = {
					{  325,  201, 0x646a66},{  731,  451, 0x7d9130},{  830,  161, 0xfcb340},{  826,  211, 0x340b10},{  756,  181, 0x4e031b},{  853,  502, 0x6d1b12},{  656,  499, 0x662d26},{  517,  499, 0x491428},
				},
				Run = (function()
					XY.CLICK({841, 157},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 装备对比',
			U5S={
				Color = {
					{  126,   39, 0x8b6635},{  535,  577, 0x224364},{  361,  572, 0x2f5368},{  167,  574, 0x615331},{  743,  577, 0x628717},{  900,  572, 0x6d8c24},{ 1018,   72, 0x342b1c},{ 1088,   20, 0x57391f},
				},
				Run = (function()
					--穿上
					x, y = screen.find_color({{   0,    0, 0xfffffe },{   0,    4, 0xfbfcfa },{   6,    4, 0xfffffd },{   0,   12, 0xfbfcfa },{   0,   17, 0x6ca61b },{ -57,   -9, 0x66a01c },{ -57,   23, 0x6da71c },{ -26,    9, 0xfffffe },}, 80,  839,  301, 1038,  591)
					if x > 0 then
						XY.CLICK({x+5, y+5},20,1000)
					end
					
					
					
					
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 副本结束',
			U5S={
				Color = {
					{  749,  530, 0x373714},{  749,  531, 0x6c702b},{  751,  578, 0x213704},{  751,  577, 0x446b0d},{  848,  577, 0x476c0e},{  848,  578, 0x1e3702},
				},
				Run = (function()
					XY.CLICK({802, 554},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 体验天神之怒',
			U5S={
				Color = {
					{  576,  547, 0x9d591b},{  680,  609, 0xa76e23},{  617,  609, 0xa96a1e},{  808,  539, 0xe0981c},{  808,  540, 0xb06f1b},{  808,  541, 0xe28d25},
				},
				Run = (function()
					XY.CLICK({837, 571},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 穿戴装备',
			U5S={
				Color = {
					{  843,  261, 0xa66e34},{  748,  401, 0xc0e36b},{  748,  402, 0x678e2c},{  815,  436, 0x6d9b24},{  815,  435, 0x88c328},
				},
				Run = (function()
					XY.CLICK({779, 414},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 解锁新功能',
			U5S={
				Color = {
					{  389,  272, 0xf5db9b},{  387,  316, 0x781800},{  734,  318, 0x711b00},{  748,  272, 0xf4d396},{  666,  358, 0x701800},{  456,  362, 0x691702},
				},
				Run = (function()
					XY.CLICK({401, 328},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 获得戒指	',
			U5S={
				Color = {
					{  705,  220, 0x7b5e32},{  705,  222, 0xceb77d},{  824,  447, 0x827254},{  824,  448, 0x423626},{  273,  447, 0x7c6b51},{  273,  448, 0x3e3122},{  837,  219, 0xc9b06f},{  279,  219, 0xc8b470},
				},
				Run = (function()
					XY.CLICK({401, 328},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 任务对话框',
			U5S={
				Color = {
					{  268,   23, 0xa76f35},{  258,   35, 0xf7ac3c},{   28,  607, 0x2c2520},{  271,  605, 0x2d2620},{  136,   46, 0x5b432f},
				},
				Run = (function()
					_JY_Ling.The = os.time() - 10
					--领取奖励
					if screen.is_colors({{ 142,  550, 0xbad968 },{ 140,  592, 0x93ce30 },}, 85) then
						XY.CLICK({142, 573},20,1000)
					elseif screen.is_colors({{ 142,  588, 0x1265a8 },}, 85) then
						XY.CLICK({142, 573},20,1000)
					else
						XY.CLICK({268, 22},20,1000)
					end
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 跳过引导2',
			U5S={
				Color = {
					{  971,   27, 0xf8e38f},{  971,   29, 0x4c2503},{  971,   32, 0x572d15},{  971,   33, 0xe4ce83},{ 1094,   48, 0xbb9c4b},{ 1106,   36, 0xe9dc86},
				},
				Run = (function()
					XY.CLICK({1040, 27},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 跳过引导1',
			U5S={
				Color = {
					{  981,   20, 0xedda8f},{  981,   22, 0x4d2c05},{  981,   27, 0xe1ca82},{ 1113,   28, 0xf6e596},{ 1113,   36, 0xd5b971},{ 1076,   20, 0xf7d98a},{ 1076,   21, 0x503114},{ 1076,   24, 0xf6dda0},
				},
				Run = (function()
					XY.CLICK({1040, 27},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},
		
		{	Name = '@找点 区域地图选怪挂机',
			U5S={
				Color = {
					{  206,   22, 0x81512a},{  125,   25, 0x8e5e27},{  116,   46, 0x926325},{  147,   52, 0xbd9637},{  125,   62, 0x9f712f},{  249,   49, 0xe05206},
				},
				Run = (function()
					XY.CLICK({261, 469},20,1000)
					XY.CLICK({927, 570},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},
		
		{	Name = '@找点 _JY_Ling 游戏主界面',
			U5S={
				Color = {
					{ 1131,    3, 0x312010},{ 1019,    1, 0xd4ac6e},{  115,   11, 0x666245},
				},
				Run = (function()
					local Now = os.time()
					
					if Now - _JY_Ling.The > 10 then
						_JY_Ling.The = os.time()
						--之戒指
						if screen.is_colors({{ 107,  195, 0xfed971 },{ 107,  198, 0xe5ab55 },{ 112,  198, 0xffbd5d },{ 112,  208, 0xfa5c17 },{ 104,  206, 0xfb6f25 },{ 127,  197, 0xfcc462 },{ 128,  206, 0xf76d25 },}, 80) then
							--前往挑战
							if screen.is_colors({{ 118,  223, 0xf8f8f6 },{ 118,  224, 0x646545 },{ 205,  223, 0x4bd700 },}, 80) then
								nLog('魔戒可以挑战了')
								XY.CLICK({62, 210},20,1000)
								return false
							end
						end
						
						--引导任务
						x, y = screen.find_color({{   0,    0, 0xf9f900 },{  -5,    0, 0xfffe00 },{   6,   -2, 0xdad900 },{   6,    2, 0xdad900 },{   6,    7, 0xdad900 },{  13,   -1, 0xc1bf00 },{  13,    5, 0xc1bf00 },{  13,    9, 0xc1bf00 },}, 90,    5,  185,   86,  367)
						if x > 0 then
							_JY_Ling.主线和赏金 = true
						end

						

						
						if not _JY_Ling.主线和赏金 then
							
							--绿色主线任务
							x, y = screen.find_color({{   0,    0, 0x1eef00 },{   0,    1, 0x1eef00 },{   0,    2, 0x1ef200 },{   0,    3, 0x1efb00 },{  12,   -2, 0x1efd00 },{  12,    3, 0x1efd00 },{  12,    8, 0x1efd00 },{   3,    3, 0x1ec600 },}, 80,  5, 185, 86, 367)
							if x > 0 then
								nLog('完成一个主线任务绿色')
								XY.CLICK({x+5, y+5},20,1000)
							end
							
							--黄色主线任务
							x, y = screen.find_color({{   0,    0, 0xf7f700 },{   0,    1, 0xf0ef00 },{   0,    2, 0xf0ef00 },{   0,    3, 0xf3f200 },{   0,    4, 0xfbfb00 },{  12,    0, 0xfdfd00 },{  12,    5, 0xfdfd00 },{  12,   10, 0xfdfd00 },}, 80,    5, 185, 86, 367)
							if x > 0 then
								nLog('接一个主线任务黄色')
								XY.CLICK({x+5, y+5},20,1000)
							end
							--黄色主线任务2
							x, y = screen.find_color({{   0,    0, 0xe8e700 },{   0,    1, 0xe8e700 },{   0,    2, 0xecec00 },{   0,    3, 0xf9f900 },{  12,   -2, 0xdbd900 },{  12,    4, 0xdbd900 },{  12,   10, 0xdfdd00 },}, 90,    8,  183,   87,  345)
							if x > 0 then
								nLog('接2个主线任务黄色')
								XY.CLICK({x+5, y+5},20,1000)
							end
							
							
							--支线任务
							x, y = screen.find_color({{   0,    0, 0x07c8c3 },{  12,   -2, 0x00fefe },{  12,    1, 0x00fbfb },{  12,    2, 0x03e1df },{  12,    7, 0x00f8f7 },{  24,   -2, 0x08bfba },{  24,    9, 0x08bfba },}, 80,  5, 185, 86, 367)
							if x > 0 then
								xx, yx = screen.find_color({{   0,    0, 0x1efc00 },{   3,    0, 0x1efc00 },{   6,    0, 0x1efc00 },{   2,    3, 0x301d05 },{   2,    6, 0x2a2008 },{  -2,    9, 0x1ff000 },{   3,    9, 0x1fef00 },{   7,    9, 0x1ff000 },}, 80,    5,  185,   86,  367)
								if xx > 0 then
								else
									nLog('可能有丁蓝色一个支线任务需要去接非直接接取')
									XY.CLICK({x+5, y+5},20,1000)
									return false
								end
							end
							
							--支线任务
							x, y = screen.find_color({{   0,    0, 0xfdfd00 },{   0,    3, 0xf7f600 },{   0,    8, 0xe4e300 },{  -5,    3, 0xebeb00 },{   3,    3, 0xf2f100 },}, 80,    5,  185,   86,  367)
							if x > 0 then
								xx, yy = screen.find_color({{   0,    0, 0x22c200 },{   2,    0, 0x22bf00 },{   6,    0, 0x22c400 },{   2,    3, 0x332511 },{   2,    6, 0x31220e },{  -1,    9, 0x21c800 },{   4,    9, 0x22c500 },{   7,    9, 0x21ca00 },}, 90,    5,  185,   86,  367)
								if xx > 0 then
								else
									nLog('接一个支线任务黄色')
									XY.CLICK({x+5, y+5},20,1000)
									return false
								end
							end
						
							--执行到这里直接点击
							XY.CLICK({98, 269},20,1000)
						
						else

							--未开启自动挂机状态
							if screen.is_colors({{1073,  331, 0x2a1815 },{1080,  333, 0xf9dd57 },{1086,  330, 0x2a1415 },{1087,  335, 0xf6cd3a },}, 85) then
								XY.CLICK({1081, 341},20,1000)
							end
							

							local Yhstr = tonumber(OcrText(10, 11,32, 29,{0xC1A79C,0x344A53},'0123456789'):match('(%d+)'))
							sys.log("当前等级"..Yhstr)
							if Yhstr >= 60 then
								return true
							end

						end
						
						
					end
					
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		Repeat = {
			n = 10,
			Run = (function()--重复

				end),
		},
		timeout = {
			n = 20,
			Run = (function()--超时
					
				end),
		},
		Begin = (function() 
			_JY_Ling.主线和赏金 = false
		end),
		End = (function() 
			--这里直接伪更新中控账号信息并且伪装新设备信息继续开刷可能需要重新加载一次
		end),
		sleep = 300,
		csim = 80
	}

_JY_Exit 						= {							Name = '退出账号',
	inventory = false,
	Xuan = false,
		{	Name = '@找点',
			U5S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
					nLog('---')
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 切换账号',
			U5S={
				Color = {
					{   39,  336, 0xff9600},
				},
				Run = (function()
					XY.CLICK({45, 324},20,1000)
					sys.sleep(4)
					XY.CLICK({140,  315},20,1000)
					sys.sleep(4)
					XY.CLICK({ 563,  314},20,1000)

				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 公告',
			U5S={
				Color = {
					{  851,  127, 0xb47f3d},{  608,  491, 0x7fc600},{  518,  459, 0x617332},
				},
				Run = (function()
					XY.CLICK({851, 130},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 登录账号密码',
			U5S={
				Color = {
					{  320,   89, 0xff9902},{  348,   83, 0xf9b900},{  348,   95, 0xff8400},{  350,  106, 0xff8400},{  402,  103, 0x056ad7},{  532,  504, 0xf27241},{  570,  504, 0xf27241},{  621,  507, 0xf27241},{  332,  501, 0xf27241},{  820,  501, 0xf27241},
				},
				Run = (function()
					XY.CLICK({342, 546},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 一键注册切换已有账号密码',
			U5S={
				Color = {
					{  308,   94, 0xffbc32},{  349,   83, 0xf9b900},{  348,   95, 0xff8400},{  348,  105, 0xff8400},{  402,  100, 0x056ad7},{  303,  469, 0xf27241},{  616,  469, 0x408ed6},{  521,  487, 0xf27241},{  822,  490, 0x408ed6},
				},
				Run = (function()
					XY.CLICK({807, 244},20,1000)
					sys.sleep(3)
					while true do
						if screen.is_colors({{ 809,  316, 0xd20000 },{ 809,  333, 0xd20000 },}, 85) then
							XY.CLICK({809,  316},20,1000)
						else
							break
						end
						sys.sleep(3)
					end
					XY.CLICK({808, 247},20,1000)
					return true
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},


		Repeat = {
			n = 10,
			Run = (function()--重复

				end),
		},
		timeout = {
			n = 20,
			Run = (function()--超时
					
				end),
		},
		Begin = (function() 
			app.close("com.jiguang.mgame.yhjy")
			sys.sleep(3)
			while (true) do
				bid = app.front_bid()
				if tostring(bid) == "com.jiguang.mgame.yhjy" then
					break
				else
					app.run("com.jiguang.mgame.yhjy")
					sys.sleep(10)
					XY.CLICK({918, 52},10,2000)
				end
			end
			 
		end),
		End = (function() 
			
		end),
		sleep = 10,
		csim = 80
	}

	
_JY_Center 						= {							Name = '控制引导',
	inventory = false,
	Xuan = false,
		{	Name = '@找点',
			U5S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
					nLog('---')
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 信息提示',
			U5S={
				Color = {
					{  773,  194, 0xa77034},{  605,  428, 0xca8200},
				},
				Run = (function()
					XY.CLICK({772, 196},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 开始游戏',
			U5S={
				Color = {
					{   47,   16, 0xffe44b},{   46,   46, 0xde9e1d},{  123,   45, 0xe8b637},{  159,   18, 0xfeee77},{  164,   32, 0xdead10},{ 1078,  607, 0xbe7111},{  905,  605, 0x9d5a0e},
				},
				Run = (function()
					XY.CLICK({980, 589},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 _JY_Center 游戏主界面',
			U5S={
				Color = {
					{ 1131,    3, 0x312010},{ 1019,    1, 0xd4ac6e},{  115,   11, 0x666245},
				},
				Run = (function()
					if tonumber(OcrText(10, 11,32, 29,{0xC1A79C,0x344A53},'0123456789'):match('(%d+)')) < 70 then
						_YHSart(_JY_Ling)
						return true
					end
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 公告',
			U5S={
				Color = {
					{  851,  127, 0xb47f3d},{  608,  491, 0x7fc600},{  518,  459, 0x617332},
				},
				Run = (function()
					XY.CLICK({851, 130},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

	
		{	Name = '@找点 登录账号密码',
			U5S={
				Color = {
					{  320,   89, 0xff9902},{  348,   83, 0xf9b900},{  348,   95, 0xff8400},{  350,  106, 0xff8400},{  402,  103, 0x056ad7},{  532,  504, 0xf27241},{  570,  504, 0xf27241},{  621,  507, 0xf27241},{  332,  501, 0xf27241},{  820,  501, 0xf27241},
				},
				Run = (function()
					XY.CLICK({342, 546},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 一键注册切换已有账号密码',
			U5S={
				Color = {
					{  308,   94, 0xffbc32},{  349,   83, 0xf9b900},{  348,   95, 0xff8400},{  348,  105, 0xff8400},{  402,  100, 0x056ad7},{  303,  469, 0xf27241},{  616,  469, 0x408ed6},{  521,  487, 0xf27241},{  822,  490, 0x408ed6},
				},
				Run = (function()
					
					--这里无需检测删除账号数据删除账号数据在推出游戏处进行单独处理
					XY.CLICK({722, 246},10,2000)
					sys.input_text('P')--输入账号
					Back._Back()
					sys.input_text(YH.Accout,true)--输入账号
					sys.sleep(2)
					XY.CLICK({730, 336},10,2000)
					sys.sleep(2)
					Back._Back()
					sys.input_text(YH._PassWord,true)--输入密码
					sys.sleep(2)
					XY.CLICK({793, 491},10,2000)
					sys.sleep(2)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 创建角色',
			U5S={
				Color = {
					{   37,   15, 0xfef247},{   33,   45, 0xe3b137},{   33,   46, 0xca9128},{  155,   29, 0xf8d625},{  165,   29, 0xf5c91b},
				},
				Run = (function()
					XY.CLICK({75, 174},20,1000)
					XY.CLICK({651, 593},20,1000)
					
					sys.sleep(2)
					Nan = itu.Rand('QWERTYUIOPASDFGHJKLZXCVBNM',6)
					nLog(Nan)
					sys.input_text('P')
					Back._Back()
					sys.sleep(1)
					sys.input_text(Nan,true)
					XY.CLICK({68, 209},20,1000)
					sys.sleep(2)
					XY.CLICK({987, 596},20,1000)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		
		{	Name = '@找点 _JY_Center 选服 登录游戏',
			U5S={
				Color = {
					{  485,  562, 0x945d05},{  650,  562, 0x9d6508},{  459,  517, 0xfae4a9},{  676,  517, 0xf4e0a9},
				},
				Run = (function()
					XY.CLICK({564, 537},20,500)
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},


		Repeat = {
			n = 10,
			Run = (function()--重复

				end),
		},
		timeout = {
			n = 20,
			Run = (function()--超时
					
				end),
		},
		Begin = (function()

		end),
		End = (function() 

		end),
		sleep = 10,
		csim = 80
	}

--￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥
	
_CheckIT 						= {							Name = '过检IT',
	inventory = false,
	
		{	Name = '@找点',
			U5S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
					nLog('---')
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		{	Name = '@找点 扫描',
			U5S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
					
					
					
				end),
			},
			U6S={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
			U6P={
				Color = {
					{    1, 1, 0xff00ff},
				},
				Run = (function()
				
				end),
			},
		},

		

		
		Repeat = {
			n = 10,
			Run = (function()--重复

				end),
		},
		timeout = {
			n = 20,
			Run = (function()--超时
					
				end),
		},
		Begin = (function() 
			_ATR.inventory = false
		end),
		End = (function() 

		end),
		sleep = 10,
		csim = 80
	}



--[[

local t = {
	'(nil)()',
    'a = nil + 1',
    'a = nil .. 1',
    '(nil).a = ""',
}
for _, v in ipairs(t) do
    nLog(pcall(load(v)))
end
nLog("0" == tostring(0.0))
]]
--标记 增加以下七天乐的领取
sys.sleep(2)
itu.Unlock(1)

while true do
	_YHSart(_JY_Center)
end
