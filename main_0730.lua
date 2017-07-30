local CC = require('CC')
local name_pre='菇凉'
tab1= {'式','刑','动','扛','寺','吉','扣','老','执','巩','圾','扩','扫','地','扬','场','耳','共','芒','亚','芝','朽','朴','机','权','过','臣','再','协','在','有','百','存','而','页','匠','夸','夺','灰','达','列','死','轨','邪','划','迈','毕','至','此','贞','师','尘','尖','劣','光','当','早','吐','团','同','吊','吃','因','吸','吗','屿','帆','岁','回','岂','刚','则','肉','网','年','朱','先','竹','迁','乔','伟','传','乒','乓','休','伍','伏','件','任','伤','价','份','华','仰','仿','伙','伪','自','血','向','似','后','行','舟','全','会','杀','合','兆','企','众','爷','肌','朵','杂','危','各','名','多','争','色','壮','冲','冰','庄','庆','亦','刘','齐','交','次','衣','产','决','充','妄','闭','问','闯','羊','并','关','米','灯','州','汗','忙','兴','宇','守','宅','字','安','讲','军','许','论','农','讽','设','访','寻','那','迅','尽','导','异','孙','阵','阳','收','阶','阴','防','奸','如','妇','戏','羽','观','红','纤','级','约','纪','驰','巡','寿','弄','麦','形','进','戒','吞','运','扶','抚','坛','技','坏','扰','拒','找','批','扯','址','走','抄','坝','贡','攻','赤','折','抓','扮','抢','投','坟','抗','坑','坊','抖','护','壳','志','扭','块','声','把','劫','芽','花','芹','芬','苍','芳','严','芦','劳','克','苏','杆','杠','杜','材','李','杨','求','更','束','豆','两','丽','医','辰','励','否','还','歼','来','连','步','坚','旱','时','吴','助','县','里','呆','园','旷','围','呀','男','困','吵','串','员','听','吩','吹','呜','吧','吼','别','岗','帐','财','针','钉','告','我','乱','利','秃','秀','私','每','体','何','但','伸','佣','低','你','住','位','伴','身','皂','佛','近','彻','役','返','余','希','坐','谷','妥','含','邻','岔','肝','肚','肠','龟','免','狂','犹','角','删','饭','饮','系','言','冻','状','亩','况','床','库','疗','应','冷','这','序','辛','弃','冶','忘','闲','间','闷','判','灶','灿','弟','汪','沙','汽','沃','泛','沉','怀','忧','宋','宏','牢','究','穷','灾','良','证','启','评','补','初','社','识','诉','诊','词','译','君','灵','即','层','尿','尾','迟','局','际','陆','阿','陈','阻','附','妙','妖','妨','劲','鸡','驱','纯','纱','纳','纲','驳','纵','纷'}
tab2 ={'纸','纹','纺','纽','奉','玩','环','武','青','责','现','抹','拢','拔','拣','担','坦','押','抽','拐','拖','拍','者','顶','拆','拥','抵','拘','势','抱','垃','拉','拦','坡','披','拨','择','抬','其','取','苦','若','茂','苹','苗','英','茄','茎','茅','林','枝','杯','柜','析','板','松','枪','构','杰','述','枕','丧','事','刺','枣','雨','卖','矿','码','厕','奔','奇','奋','态','欧','垄','妻','轰','顷','转','斩','到','非','叔','肯','齿','些','虎','虏','肾','贤','果','味','昆','国','昌','畅','明','易','昂','典','固','忠','咐','呼','鸣','咏','呢','岸','岩','帖','罗','帜','岭','凯','败','图','钓','制','知','乖','刮','秆','和','季','委','佳','侍','供','使','例','版','侄','侦','侧','凭','侨','佩','货','依','的','迫','质','欣','征','往','爬','彼','径','所','爸','采','受','乳','贪','念','贫','肤','肺','肢','肿','胀','朋','股','肥','服','胁','周','昏','鱼','兔','狐','忽','狗','备','饰','饱','饲','变','京','享','府','底','剂','净','盲','放','刻','育','闸','闹','郑','券','卷','单','炒','炊','炕','炎','炉','沫','浅','法','泄','河','沾','泪','油','泊','沿','泳','泥','沸','波','泼','泽','治','怖','性','怪','学','宝','宗','定','宜','审','宙','官','空','帘','实','试','郎','诗','肩','房','诚','衬','衫','询','该','详','建','肃','录','隶','奏','春','帮','珍','玻','毒','型','持','项','垮','挎','城','挠','政','赴','赵','挡','挺','括','拴','拾','挑','指','垫','挣','挤','拼','挖','按','甚','革','荐','巷','带','草','茧','茶','荒','茫','荡','荣','故','药','标','枯','柄','栋','相','查','柏','柳','柱','柿','栏','树','要','咸','威','厘','厚','砌','砍','面','耐','耍','牵','残','殃','轻','鸦','皆','背','战','点','临','览','竖','尝','是','盼','眨','哄','显','哑','冒','映','星','胃','贵','界','虹','虾','蚁','思','蚂','虽','品','咽','骂','哗','咱','响','哈','咬','咳','哪','炭','峡','罚','贱','贴','骨','钢','钥','钩','卸','矩','怎','牲','选','适','秒','香','种','秋','科','重','复','竿','段','便','俩','贷','顺','修','保','促','侮','俭','俗','俘','信','皇','泉','鬼','侵','律','很','须','叙','剑','逃','食','盆','胆','胜','胞','胖','脉','勉','狭','狮','独','狡','狱','狠'}
tab3={'贸','怨','急','饶','蚀','饺','饼','弯','将','奖','哀','迹','庭','疮','疤','姿','亲','音','帝','施','闻','阀','阁','差','养','美','姜','叛','送','类','迷','前','首','逆','总','炼','炸','炮','烂','剃','浇','浊','洞','测','洗','活','派','洽','染','洲','浑','浓','津','恒','恢','恰','恼','恨','举','觉','宣','室','宫','宪','突','穿','窃','客','冠','祖','神','祝','误','诱','说','诵','耕','耗','艳','泰','珠','班','素','盏','匪','捞','栽','捕','振','载','赶','起','盐','捎','捏','埋','捉','捆','捐','损','都','哲','逝','捡','换','壶','挨','耻','耽','恭','莲','莫','荷','获','晋','恶','真','框','桐','株','桥','桃','格','校','核','样','根','索','哥','速','逗','栗','配','翅','础','破','原','套','逐','烈','殊','顾','轿','较','顿','毙','致','柴','桌','虑','监','紧','党','晓','鸭','晃','晌','晕','蚊','哨','哭','恩','唤','峰','圆','贼','贿','钱','钳','钻','铁','铃','铅','缺','氧','特','牺','造','乘','敌','秤','租','积','秧','秩','称','秘','透','笋','债','借','值','倘','俱','倡','候','俯','倍','倦','健','臭','射','躬','息','徒','徐','舰','舱','般','航','途','拿','爹','爱','颂','翁','脆','脂','胸','胳','脏','胶','留','皱','饿','恋','桨','浆','衰','高','席','准','座','脊','症','病','疾','疼','疲','效','离','唐','资','凉','站','剖','竞','部','旁','旅','畜','阅','羞','料','益','兼','烦','烧','烛','烟','递','涛','浙','涝','酒','涉','消','浩','海','涂','浴','浮','流','润','浪','浸','涨','烫','涌','悟','悄','悔','家','宵','宴','宾','窄','容','宰','案','请','读','扇','袜','袖','袍','被','祥','课','谁','调','冤','谅','谈','谊','剥','恳','展','剧','屑','弱','陪','娱','娘','通','能','难','预','球','理','捧','堵','描','域','掩','掉','堆','推','掀','授','教','掏','掠','培','接','控','探','据','掘','职','基','著','勒','黄','萌','萝','菌','萍','菠','营','械','梦','梢','梅','检','梳','梯','桶','救','副','爽','聋','袭','盛','雪','辅','辆','虚','雀','堂','常','匙','晨','睁','眯','眼','晚','啄','距','跃','略','蛇','累','唱','患','唯','崖','崭','崇','圈','铜','铲','银','甜','梨','笨','笼','笛','符','第','敏','做','袋','悠','偿','售','停','偏','假','得','衔','盘'}
tab4={'船','斜','盒','鸽','悉','欲','彩','领','脚','脖','脸','脱','象','够','猜','猪','猎','猫','馆','凑','减','毫','廊','康','庸','鹿','盗','章','竟','商','族','旋','望','率','着','盖','粘','粗','粒','断','剪','兽','清','添','淋','淹','渠','渐','混','渔','淘','液','渗','情','惜','惭','悼','惧','惕','惊','惨','惯','寇','寄','宿','窑','密','谋','谎','祸','谜','逮','敢','屠','弹','随','蛋','隆','隐','婚','婶','颈','绩','绳','维','绵','琴','斑','替','款','堪','搭','塔','趋','超','提','堤','博','揭','喜','插','揪','搜','煮','援','裁','搁','搂','搅','握','揉','斯','期','欺','联','葛','董','葡','敬','葱','落','朝','辜','葵','棒','棋','植','森','棵','棍','棉','棚','棕','惠','惑','逼','厨','厦','硬','确','雁','殖','裂','雄','悲','紫','辉','敞','赏','掌','晴','暑','最','量','喷','晶','喇','遇','喊','景','践','跌','跑','蛛','蜓','喝','喂','喘','喉','幅','帽','赌','赔','链','销','锁','锄','锅','锈','锋','锐','短','智','毯','鹅','剩','稍','程','稀','税','筐','等','筑','策','筛','筒','答','筋','傅','牌','堡','集','奥','街','惩','御','循','艇','舒','番','释','禽','腊','脾','腔','鲁','猾','猴','然','馋','装','蛮','就','痛','童','阔','善','羡','普','粪','尊','道','渣','湿','温','渴','滑','湾','渡','游','滋','溉','愤','慌','惰','愧','愉','慨','割','寒','富','窜','窝','窗','遍','裕','裤','裙','谢','谣','谦','属','屡','隔','隙','絮','缎','缓','编','骗','缘','瑞','魂','肆','摄','摸','填','搏','摆','携','搬','摇','搞','塘','摊','蒜','勤','鹊','蓝','墓','幕','蓬','蓄','蒙','蒸','献','禁','楚','想','槐','赖','酬','感','碍','碑','碎','碰','碗','碌','雷','零','雾','雹','龄','鉴','睛','睡','睬','鄙','愚','暖','盟','歇','暗','照','跨','跳','跪','路','蜂','嗓','置','罪','罩','错','锡','锣','锤','锦','键','锯','矮','辞','稠','愁','筹','签','简','鼠','催','傻','像','躲','微','愈','遥','腰','腥','触','解','酱','痰','廉','新','韵','意','粮','数','煎','塑','慈','煤','煌','满','漠','源','滤','滥','滔','溪','溜','滚','滨','慎','誉','塞','谨','辟','障','嫌','嫁','叠','缝','缠','慧','撕','撒','趣','趟','撑','播','增','聪','鞋','蕉','蔬','横','槽','樱','橡','飘','醋'}
--115
tab5={'醉','震','霉','瞒','题','暴','瞎','影','踢','踏','踩','嘱','墨','镇','靠','稻','黎','稿','稼','箱','箭','篇','僵','躺','艘','膝','膛','熟','摩','颜','毅','糊','遵','潜','潮','懂','额','慰','劈','静','碧','璃','墙','撇','嘉','摧','境','摘','摔','聚','蔽','慕','暮','蔑','模','榴','榜','榨','歌','遭','酷','酿','酸','磁','愿','需','弊','裳','蜡','蝇','蜘','赚','锹','锻','舞','稳','算','箩','管','僚','鼻','膜','膊','膀','鲜','疑','馒','裹','敲','豪','膏','遮','腐','瘦','辣','竭','端','熄','熔','漆','漂','漫','滴','演','漏','慢','寨','赛','察','蜜','谱','嫩','翠','熊','凳'}




function getCharactorName()
	
	local char1,char2,char3,char4,char5
	math.randomseed(os.time())
	char1 = tab1[math.random(1,410)]
	math.randomseed(os.time())
	char2 = tab2[math.random(1,410)]
	math.randomseed(os.time())
	char3 = tab3[math.random(1,410)]
	math.randomseed(os.time())
	char4 = tab4[math.random(1,410)]
	math.randomseed(os.time())
	char5 = tab5[math.random(1,110)]
	nLog(char1..char2..char3..char4..char5)
	return char1..char2..char3..char4..char5

end

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

	--args_json['source'] = "运行账号.csv"
	args_json['target'] = "./complete/account_greater60.csv"
	args = json.encode(args_json)
	proc_put('CC_args', args) 
end

function file_exists(path)
	local file = io.open(path, "rb")
	if file then file:close() end
	return file ~= nil
end

initArgs()
list = CC.web_file.list("./running")
local batchid

nLog("文件个数")
nLog(#list)

local ip = "没开 WiFi"
for i,v in ipairs(device.ifaddrs()) do
	if (v[1]=="en0") then
		ip = v[2]
	end
end
--sys.alert(db_name)
local db_file_local
local sqlite3
local db_name
if #list > 0 then
	initArgs()
	batchid=CC.web_file.size("./running/"..list[1])
	--sys.alert(list[1])
--sys.alert(batchid)
--机器名称中不能包含空格
--local db_name = "db-"..device.name().."-"..os.date("%Y-%m-%d_%H%M%S", os.time())..".db"
	db_name = device.type()..device.name()..ip.."-"..batchid..".db"
--sys.alert(db_name)
	db_file_local = "/private/var/mobile/Media/1ferver/lua/scripts/"..db_name

	sqlite3 = require('sqlite3')

	sys.msleep(1000)
	initArgs()
--local aa = CC.web_file.exists(db_file_local)
	--local aa = CC.web_file.size(db_file_local)
	--nLog(CC.web_file.size(db_file_local))
	nLog(db_file_local)
--size
	if file_exists(db_file_local) == false then
		nLog("81 第一次，开始下载")
		initArgs()
		CC.web_file.down_file('foo2.db',db_file_local)
	else
		nLog("85 文件已经存在")
	end
	sys.msleep(2000)
else
	nLog("没有账号文件.")
	os.exit()
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
	local sql ="insert into game_acct(acct_name,acct_log_device,device_type,charactor_name)select '"..acct_name.."','"..device.name().."','"..device.type().."','".. name_pre .."' where not exists(select acct_name from game_acct where acct_name = '"..acct_name.."');"
	nLog(sql)
	db:exec(sql)
	db:close()
end

function updGameAcct(acct_name,flag_60)
	local db = sqlite3.open(db_file_local, "rw")
	--local sql1 =".set param @acct_name = '"..acct_name.."';"
	--local sql2 =".set param @flag60 = '"..flag_60.."';"
	local sql =[=[ 	update game_acct  set flag60 = ?  where acct_name = ? ; ]=]
	--nLog(sql)
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
	--local args = proc_take("CC_args")
	--local args = json.decode(args)
	--local filename = args['source']
	local filename	
	local list1 = CC.web_file.list("./running")
	if #list1 >0 then
		filename = "./running/"..list1[1]

		nLog(filename)
		--local filename1 = args['target']
--sys.alert("filename:"..filename)
		if CC.web_file.exists(filename) then
			nLog("in...........")
			--sys.alert("CC.web_file.exists(filename)")
			--sys.alert(CC.web_file.take_line(filename))
			--sys.alert(CC.web_file.line_count(filename))
			while  (CC.web_file.line_count(filename) > 0 ) do
				nLog("in2.............")
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
		--nLog("acct_ret"..acct_ret)
		if acct_ret == nil then
			success = CC.web_file.delete(filename);
			acct_ret = getLess60Account()
		end
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

--require("TSLib")
--init("com.tencent.smoba",1)
screen.init(1)
sys.msleep(1000)
testrun()
fuhuo =0
bag_back = 'Y'
shangjin_flag ='N'
--第一次运行脚本登陆，点击左侧小头像，输入账号



--sys.alert("屏幕懂了")
local acct1 --从中控读取的账号密码存此变量
local server_choose_flag= 'N'
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
			{  400,  447, 0x2b8d1d},
			{  628,  443, 0xd9b668},
			{  657,  445, 0xe2be6e},
			{  689,  443, 0xe0bc6d},
			{  657,  456, 0xe2be6e},
			})then
		nLog("390 点击选服")
		if server_choose_flag =='N' then
			touch.tap(657,  456)--点击选服
			sys.msleep(2000)
			server_choose_flag='Y'
		else
			touch.tap(571,  547) --点击登录游戏
			sys.msleep(5000)
			server_choose_flag ='N'
		end


	elseif screen.is_colors({
			{  208,  152, 0x9e7831},
			{  305,  142, 0x7e6834},
			{  302,  158, 0xa86b03},
			{  258,  159, 0xfabb00},
			{  950,   83, 0xaf7337},
			{  249,  154, 0xcdb8ab},
			}) then
		nLog("408 服务器列表")
		touch.tap(256,  221) --点击纪元王者专服
		sys.msleep(2000)
		touch.tap(469,  431) --点击纪元王者1服
		--touch.tap(768,  342)--点击纪元王者2服
	elseif screen.is_colors({
			{  904,  597, 0xc5890f},
			{  943,  598, 0xbd7800},
			{  973,  603, 0x9d5803},
			{ 1013,  591, 0xfeaf00},
			{ 1071,  608, 0xba731a},
			{  697,  600, 0x0388de},
			{  687,  605, 0x006bce},
			}) then
		nLog("423 创建角色")
		touch.tap(563,  597)
		sys.msleep(10000)
		math.randomseed(os.time())
		--print('zvx'..math.random(1,1000) )	
		touch.tap(155,   97) --点击文本框
		sys.msleep(5000)
		touch.tap(263,  187) --点击select all
		sys.msleep(3000)
		touch.tap(80,  188) --点击 Cut
		sys.msleep(2000)
		name_pre = getCharactorName()
		sys.msleep(2000)
		sys.input_text(name_pre)
		sys.msleep(3000)
		touch.tap(54,  274) --点击Done
		sys.msleep(5000)
		touch.tap(987,  591) --点击确认创建
	elseif screen.is_colors({
			{  297,  100, 0xf65700},
			{  504,  176, 0xf06144},
			{  321,  244, 0xa2a2a2},
			{  710,  247, 0xffffff},
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
			end 
			shangjin_flag ='N'
		else
			initArgs()
			CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
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
			nLog("413 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
			initArgs()
			CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
		else
			nLog("422 当前账号为空")
		end
	elseif screen.is_colors({
			{   18,   21, 0xf8f5f4},
			{   14,   17, 0xe3d9d7},
			{   16,   25, 0xe3d9d7},
			{   17,   19, 0x7a3202},
			})then
		nLog("152 90多级了，可以切换账号了")
		touch.tap(50,  591)
		sys.msleep(3000)
		--60级和90级的设置按钮，貌似位置不一致
		--默认点击设置按钮
		touch.tap(923,  614) --默认点击设置按钮
		sys.msleep(3000)

		touch.tap(362,   42) --点击系统设置
		sys.msleep(2000)
		touch.tap(494,  469) --点击切换账号
		sys.msleep(2000)
		touch.tap(692,  406) --点击确定

		if acct1 ~= nil then
			nLog("664 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
			initArgs()
			CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
		else
			nLog("671 当前账号为空")
		end
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
			{  840,  258, 0xba8b48},
			{  753,  409, 0x578430},
			{  773,  415, 0x7d9e89},
			{  794,  420, 0x3b6d4d},
			{  770,  427, 0xeff3f0},
			{  790,  424, 0xc1d1c6},
			}) then
		nLog("675 穿装备")
		touch.tap(790,  424)
	elseif screen.is_colors({
			{  594,  485, 0x7daa03},
			{  636,  483, 0x91ca00},
			{  681,  480, 0x91cb06},
			{  672,  508, 0xfdfe90},
			{  608,  503, 0x325918},
			{  621,  506, 0xf7fba0},
			}) then
		nLog("631 领取")
		touch.tap(621,  506)
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
		nLog("618 确定-装备提示")
		touch.tap(710,  419)	
	elseif screen.is_colors({
			{  537,  407, 0x6b7d35},
			{  571,  404, 0x607532},
			{  606,  414, 0xc8d6cc},
			{  551,  421, 0x82a300},
			{  588,  422, 0xe0e8e2},
			}) then
		nLog("627 立即装备")
		touch.tap(588,  422)
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
			nLog("664 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
			initArgs()
			CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
		else
			nLog("671 当前账号为空")
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
			{   65,  258, 0xf6f500},
			{   81,  262, 0xfdfd00},
			{   93,  257, 0x9b9700},
			{  111,  260, 0xe3e200},
			{  131,  259, 0xf7f700},
			{  147,  257, 0xf3f300},
			})then
		nLog("704 赏金任务")
		touch.tap(147,  257)
		shangjin_flag ='Y'
	elseif screen.is_colors({
			{   65,  318, 0xffff00},
			{   93,  319, 0xd6d400},
			{  123,  317, 0xfbfb00},
			{  146,  323, 0xd2d000},
			{  130,  319, 0xffff00},
			{   81,  320, 0xfdfd00},
			})then 
		nLog("715 赏金任务")
		touch.tap(130,  319)
		shangjin_flag ='Y'
	elseif screen.is_colors({
			{  852,  540, 0xffff5b},
			{  852,  603, 0xffff40},
			{  893,  554, 0x355a74},
			{  921,  568, 0x3aa2c6},
			}) then
		nLog("673 前往接取-黄色框")
		touch.tap(921,  568)
	elseif screen.is_colors({
			{  886,  551, 0x295373},
			{  938,  555, 0x355a7a},
			{  887,  575, 0xc6cac2},
			{  950,  575, 0xfdfdea},
			{  920,  575, 0x0682b8},
			{  918,  565, 0x36799c},
			})then
		nLog("709 前往接取-蓝色")
		touch.tap(918,  565)
	elseif screen.is_colors({
			{  815,  552, 0xff6d21},
			{  815,  571, 0x1b0c06},
			{  818,  598, 0x714733},
			{  827,  575, 0x6f2604},
			{  831,  558, 0x51283c},
			}) then
		nLog("674 天神")
		touch.tap(831,  558)
	elseif screen.is_colors({
			{  814,  551, 0xb53e20},
			{  824,  549, 0xf2851f},
			{  835,  553, 0x221018},
			{  812,  604, 0x793e2d},
			{  821,  573, 0x511321},
			}) then
		nLog("691")
		touch.tap(821,  573)
	elseif screen.is_colors({
			{  819,  554, 0x732f1e},
			{  815,  578, 0xbaaa8a},
			{  814,  601, 0x4c3128},
			{  819,  567, 0x221324},
			{  828,  566, 0x7a5955},
			}) then
		nLog("674 天神")
		touch.tap(828,  566)
	elseif screen.is_colors({
			{  822,  570, 0x381424},
			{  820,  584, 0x852802},
			{  827,  559, 0x746573},
			})then
		nLog("560 再次体验天神")
		touch.tap(827,  559)
	elseif screen.is_colors({
			{ 1055,  553, 0x423e3b},
			{ 1064,  541, 0x3e3e3e},
			{ 1038,  561, 0x565859},
			{ 1041,  542, 0x3b3c3d},
			{ 1063,  562, 0x545656},
			{ 1052,  571, 0x63480e},
			})then
		nLog("754 天神")
		touch.tap(843,  580)
	elseif screen.is_colors({
			{  958,  429, 0x88cf26},
			{  947,  431, 0xfefffd},
			{  978,  435, 0xdee7e0},
			{  971,  430, 0xfefefd},
			})then
		nLog("763 出售")
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
		--[[
	elseif screen.is_colors({
			{   64,  567, 0xf2f1ee},
			{   61,  577, 0xc6c0b8},
			{   51,  589, 0x725634},
			}) then
		nLog("210 点击满字箭头")
		touch.tap(51,  589)
		sys.msleep(2000)
		touch.tap(201,590) --点击背包
	]]--	
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
		nLog("983 使用金币")
		touch.tap(802,  418)
	elseif screen.is_colors({
			{   14,  252, 0xc7c500},
			{   36,  268, 0xcecc00},
			{   53,  257, 0xc5c300},
			{   34,  285, 0xf4f1f0},
			}) then
		nLog("956 引")
		touch.tap(34,  285)
	elseif screen.is_colors({
			{   13,  260, 0xcbc900},
			{   37,  266, 0xc1bf01},
			{   80,  259, 0xe2e100},
			})then
		nLog("963 引")
		touch.tap(80,  259)
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
		nLog("1064 参加赏金任务")
		--touch.tap( 49,  320)
		touch.tap(491,  141)
		sys.msleep(100)
		shangjin_flag ='Y'
	elseif screen.is_colors({
			{  466,  136, 0x6b9335},
			{  522,  136, 0x699134},
			{  492,  138, 0xbde053},
			{  492,  149, 0x98cd2a},
			}) then
		nLog("1075 前往赏金")
		touch.tap(492,  149)
	elseif screen.is_colors({
			{  108,  560, 0x5a8431},
			{  161,  560, 0x648e33},
			{  112,  578, 0xa5bca1},
			{  155,  577, 0xf9fae6},
			})then
		nLog("1081 领取任务")
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
		--[[
	elseif screen.is_colors({
	{  113,  227, 0x9d9e89},
	{  118,  228, 0xf9faf8},
	{  129,  228, 0xefefeb},
	{  137,  228, 0xf0f0ed},
	{  146,  224, 0xf7f7f6},
	{  169,  230, 0xeeeeeb},
}) then
	nLog("1105 诅咒之戒前往挑战")
	touch.tap(169,  230)
]]--	
	elseif screen.is_colors({
			{  116,  228, 0xb8b9a9},
			{  138,  228, 0xbebeb1},
			{  151,  227, 0xd8d8d0},
			{  168,  226, 0xebebe7},
			}) and shangjin_flag =='N' then
		nLog("1132 旋光之戒")
		touch.tap(168,  226)
	elseif screen.is_colors({
			{  387,  295, 0xf2e1d8},
			{  366,  317, 0x5e493c},
			{  411,  350, 0xb0a595},
			})then
		nLog("1098 诅咒之戒")
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
		--[[
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
	]]--	
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
		--[[
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
	]]--	
	elseif screen.is_colors({
			{  745,  401, 0x56812e},
			{  785,  407, 0xa5c84a},
			{  819,  422, 0x51850d},
			}) then
		nLog("91 买一组")
		touch.tap(819,  422)
	elseif screen.is_colors({
			{  652,  395, 0x5d7331},
			{  686,  395, 0x667932},
			{  719,  396, 0x607633},
			{  712,  415, 0x81978d},
			{  682,  415, 0xb4c1bb},
			{  692,  416, 0xa3bc00},
			})  then
		nLog("1217 确定")
		touch.tap(692,  416)
	elseif screen.is_colors({
			{  948,  436, 0x6ba020},
			{  976,  439, 0x689f1c},
			{  962,  456, 0x84cb28},
			{  991,  461, 0x669b1c},
			{  956,  467, 0x6ba61d},
			{  950,  459, 0xfffffe},
			}) then
		nLog("1217 穿上")
		touch.tap(950,  459)
	elseif screen.is_colors({
			{  808,  144, 0xadfc55},
			{  807,  152, 0x37f831},
			{  806,  157, 0x39ee2c},
			{  806,  141, 0xdff477},
			{  803,  144, 0xb4f173},
			}) then
		nLog("1216 点击背包第三个装备")
		touch.tap(803,  144)
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
		--[[
	elseif screen.is_colors({
			{   64,  573, 0xe3e0dc},
			{   69,  567, 0xd9d5d0},
			{   58,  568, 0x3b220b},
			}) then
		nLog("514 点击左下角箭头")
		touch.tap(51,590)
		sys.msleep(500)
		touch.tap(204,594)
	]]--	
		--[[
	elseif screen.is_colors({
			{  730,  557, 0x697e34},
			{  776,  561, 0x809334},
			{  801,  576, 0x7ea301},
			}) then
		nLog("1323 一键出售")
		touch.tap(801,  576)
		sys.msleep(500)
		--touch.tap(780,  531)
		sys.msleep(1000)
		--touch.tap(1068,36)
		--sys.msleep(2000)
		touch.tap(790,  137)
		
		sys.msleep(200)
		touch.tap(1064,   30) --点击返回
	]]--	
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
			{   25,  257, 0x00fbfb},
			{   49,  261, 0x00fefe},
			{   87,  262, 0x08bab5},
			{  120,  259, 0x08beb8},
			{  132,  256, 0x00f9f9},
			})  then
		nLog("1351 主屏幕上点击可接取支线任务")
		touch.tap(132,  256)
	elseif screen.is_colors({
			{  419,  350, 0x563d29},
			{  424,  348, 0x1ef300},
			{  443,  351, 0x1eff00},
			{  467,  352, 0x1efa00},
			{  392,  350, 0x563d29},
			}) then
		nLog("1416 点击支线任务")
		touch.tap(392,  350)
		sys.msleep(200)
		touch.tap(921,  567) --前往接取
	elseif screen.is_colors({
			{  951,  581, 0x2f4b15},
			{  964,  594, 0xd9dec5},
			{ 1006,  596, 0xf1f3dd},
			{  995,  595, 0xa2ba00},
			}) then --挑战戒灵
		nLog("1426 挑战戒灵")
		sys.msleep(200)
		--[[
		touch.tap(45,  593) --点击箭头
		sys.msleep(3000)
		touch.tap(197,  595) --点击背包
		sys.msleep(5000)
		touch.tap(790,  134) --点击第三个装备
		sys.msleep(2000)
		]]--
		touch.tap(995,  595) --点击挑战戒灵

	elseif screen.is_colors({
			{  793,  226, 0x8b381b},
			{  806,  226, 0xb76646},
			{  814,  232, 0xede393},
			{  786,  234, 0x763a20},
			{  789,  252, 0xddcd7c},
			}) then
		nLog("1428 点击右侧任务")
		touch.tap(789,  252)
		sys.msleep(5000)
		touch.tap(939,  574) --闪光绿色立即前往
		sys.msleep(10000)
	elseif screen.is_colors({
			{  691,  519, 0x527d2a},
			{  748,  519, 0x59832f},
			{  774,  523, 0x5d8832},
			{  714,  533, 0x546b41},
			{  773,  540, 0x45710f},
			{  746,  540, 0xedefd9},
			})then
		nLog("1508 获取途径")
		touch.tap(746,  540)
	elseif screen.is_colors({
			{  693,  304, 0xdd7b3e},
			{  688,  310, 0xe08344},
			{  701,  315, 0xc25010},
			{  684,  316, 0xc44a0d},
			{  691,  307, 0xe76023},
			}) then
		nLog("1428 装备没有获取")
		touch.tap(542,  312)
	
	elseif screen.is_colors({
			{  533,  479, 0x637834},
			{  574,  481, 0x6c8134},
			{  536,  498, 0xfcfcfa},
			{  567,  497, 0xd1d8cd},
			{  593,  494, 0xf0f2ee},
			{  573,  495, 0x9db700},
			}) then
		nLog("1481 属性不足，继续挑战")
		touch.tap(725,  105) --点击关闭
		sys.msleep(500)
		touch.tap(1049,   42) --返回
		sys.msleep(500)
		touch.tap(1049,   42) --返回
		sys.msleep(500)
		touch.tap(51,  592) --箭头
		sys.msleep(3000)
		touch.tap(195,  597)--背包
		sys.msleep(2000)
		touch.tap(922,  570) --整理
		sys.msleep(7000)
		touch.on(784,  303):move(784,  459):off()
		sys.msleep(2000)
		touch.tap(783,  138)
		sys.msleep(1000)
		touch.tap(961,  415)
		--touch.tap(573,  495)
	
	elseif screen.is_colors({
	{  713,  516, 0x778964},
	{  739,  517, 0x546b42},
	{  764,  517, 0x8f9f79},
	{  713,  528, 0x2f510e},
	{  753,  524, 0x5c7346},
}) then
	nLog("1584 获取途径")
	touch.tap(753,  524)
	elseif screen.is_colors({
	{  519,  106, 0xfae5ba},
	{  483,  108, 0xa17a5e},
	{  592,  110, 0x8a6047},
	{  630,  113, 0xf2dcb3},
	{  686,  305, 0xfb640b},
	{  700,  317, 0xc55010},
	{  690,  312, 0xe05d24},
})then
	nLog("1586 属性不足，缺失第一件装备")
	touch.tap(532,  314)
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
		nLog("1621 接取支线任务")
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
		nLog("1670 50级之前进行主线任务")
		touch.tap(918,568)
	
	elseif screen.is_colors({
			{  182,  288, 0xdeba6b},
			{  181,  295, 0xd1ae63},
			{  199,  286, 0xd3b065},
			{  194,  296, 0xdeba6b},
			{  921,  568, 0x758925},
			}) then
		nLog("1680 50级之前进行主线任务")
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
		--[[	
	elseif screen.is_colors({
			{  115,  223, 0xfdfdfc},
			{  137,  229, 0xdbdbd4},
			{  150,  228, 0xa5a693},
			{  165,  228, 0xa8a997},
			}) then
		nLog("1601 前往挑战")
		sys.msleep(200)
		touch.tap(165,  228)
	]]--
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
		shangjin_flag ='Y'
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
		nLog("1795 确认-退出副本")
		touch.tap(686,  413)
		sys.msleep(1000)
		if acct1 ~= nil then
			nLog("1687 "..acct1)
			initArgs()
			recordOKAccount(acct1)
			acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
			if acct_name ~= nil then 
				--sys.msleep(2000)	
				updGameAcct(acct_name,"Y")
			end 
			initArgs()
			CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
		else
			nLog("1696 当前账号为空")
		end
	elseif screen.is_colors({
			{  949,  578, 0x637833},
			{  984,  579, 0x6c8135},
			{ 1041,  584, 0x6a7c32},
			{  952,  598, 0xc2caaf},
			{  987,  598, 0xf2f4de},
			{ 1014,  599, 0xeaedd6},
			} )then
		nLog("1554 挑战矮人")
		touch.tap(1014,  599)
	elseif screen.is_colors({
			{  952,  584, 0xc3cbaf},
			{  979,  590, 0x7c9126},
			{  996,  595, 0x9cb400},
			}) then 
		nLog("468 挑战矮人")
		sys.msleep(100)
		touch.tap(996,  595)
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
		touch.tap(453,  296)--点击左侧可交付
		sys.msleep(300)
		touch.tap(917,  570) --点击蓝色前往交付
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
		nLog("1832 点击进行中支线任务")
		touch.tap(369,  293)
	elseif screen.is_colors({
			{  430,  410, 0xea0200},
			{  404,  410, 0x563c29},
			{  444,  411, 0xe30300},
			{  468,  412, 0xfe0000},
			{  453,  410, 0xf90000},
			{  369,  411, 0x573c29},
			})then
		nLog("1649 点击红色进行中任务")
		touch.tap(369,  411)
		sys.msleep(1000)
		touch.tap(918,  567) --点击绿色立即前往
	elseif screen.is_colors({
			{  877,  561, 0x435c1e},
			{  961,  564, 0x344f21},
			{  923,  569, 0xf9fae5},
			}) then
		nLog("1687 立即前往")
		touch.tap(923,  569)
	elseif screen.is_colors({
			{  888,  563, 0xf5f6e1},
			{  914,  561, 0xb2bc9e},
			{  937,  562, 0xf6f7e1},
			{  953,  563, 0x6d8159},
			{  890,  574, 0x799904},
			{  939,  574, 0xebeed7},
			})then
		nLog("1828 闪光绿色立即前往")
		touch.tap(939,  574)
		sys.msleep(4000)
		bag_back ='N'
	elseif screen.is_colors({
			{  891,  564, 0x809437},
			{  918,  563, 0x92a538},
			{  946,  563, 0xffffeb},
			{  889,  583, 0x85be02},
			{  956,  577, 0x739b00},
			}) then
		nLog("1838 背包界面")
		if bag_back =='Y' then
			touch.tap(1061,   34) --点击整理	
		else
			touch.tap(920,  572) --点击整理
			sys.msleep(7000)
			touch.tap(786,  123) --点击第3个装备
			sys.msleep(2000)
			bag_back ='Y'
		end
	elseif screen.is_colors({
			{  760,  355, 0x68a11f},
			{  799,  361, 0x76b521},
			{  824,  360, 0x6da71d},
			{  791,  379, 0x74af21},
			{  787,  491, 0x5fa225},
			{  810,  494, 0xf1f4f1},
			{  763,  498, 0x6aa421},
			})then
		nLog("1850 出售")
		touch.tap(763,  498)
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
		nLog("1855 返回")
		sys.msleep(200)
		touch.tap(1102,   40)
	elseif screen.is_colors({
			{ 1017,   16, 0x48692e},
			{ 1046,   28, 0xcbba88},
			{ 1074,   28, 0xc0ab7f},
			{ 1102,   42, 0xa58b59},
			}) then --点击返回
		nLog("1864 点击返回")
		sys.msleep(200)
		touch.tap(1102,   42)
	elseif screen.is_colors({
			{ 1034,   36, 0xd6c38a},
			{ 1095,   35, 0xf2e19f},
			{ 1087,   52, 0xa18850},
			}) then --返回
		nLog("1708 返回")
		sys.msleep(200)
		touch.tap(1087,   52)
	elseif screen.is_colors({
			{ 1035,   37, 0xccb882},
			{ 1041,   44, 0xa48351},
			{ 1068,   38, 0xbca576},
			{ 1064,   51, 0x926031},
			{ 1088,   52, 0xa6884e},
			{ 1099,   44, 0xc9b57b},
			})then
		nLog("1883 点击返回")
		touch.tap(1088,   52)
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
--[[
	elseif screen.is_colors({
			{  482,  103, 0xa78365},
			{  525,  476, 0x5d6e2e},
			{  725,  106, 0xa56b36},
			}) then --属性不足，关闭
		nLog("265 属性不足，关闭")
		sys.msleep(200)
		touch.tap(725,  106)
]]--		
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
		nLog("1921 点击自主加点")
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
		shangjin_flag ='Y'
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
		shangjin_flag ='Y'
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
			{  749,  269, 0xfe8f00},
			{  768,  270, 0xf98d01},
			{  789,  270, 0xfc8e00},
			{  832,  259, 0xdfb35d},
			{  836,  266, 0xa86f37},
			})then
		nLog("2152 守护过期")
		touch.tap(836,  266)
	elseif screen.is_colors({
			{  559,  248, 0xe0a95d},
			{  577,  248, 0xe1b469},
			{  558,  258, 0xffd083},
			{  576,  257, 0xfee59b},
			{  562,  267, 0xfde195},
			})then
		nLog("2161 新功能开启-魔戒寻主")
		touch.tap(562,  267)
		sys.msleep(5000)
		touch.tap(52,589)--点击左下角箭头
		sys.msleep(2000)
		touch.tap(839,  586) --点击设置
	elseif screen.is_colors({
			{   18,   16, 0xf7f4f2},
			{   15,   20, 0xd3c3c2},
			{   16,   26, 0xdbcdcb},
			{   20,   25, 0xbea6a3},
			{   20,   22, 0xd2c2c0},
			{   17,   20, 0xd6c7c5},
			}) then
		nLog("2175 60级换号")
		touch.tap(52,589)--点击左下角箭头
		sys.msleep(2000)
		touch.tap(839,  586) --点击设置
		sys.msleep(5000)
		touch.tap(358,   38)
	elseif screen.is_colors({
			{  116,  223, 0xfcfcfb},
			{  137,  228, 0xefefec},
			{  151,  229, 0xe1e1db},
			{  164,  229, 0xb0b0a0},
			})then
		nLog("1833 前往挑战")
		touch.tap(164,  229)
	elseif screen.is_colors({
			{   35,  157, 0xe9e9d6},
			{   45,  160, 0xdcdbc9},
			{   53,  162, 0x754319},
			{   80,  160, 0xae9a81},
			{   68,  165, 0xbdb5a2},
			}) then
		nLog("2256 点击任务")
		touch.tap(68,  165)
		--[[
	elseif screen.is_colors({
			{   29,  149, 0x635136},
			{   84,  166, 0x745118},
			{   45,  161, 0xdbdac8},
			})then
		nLog("2198 点击任务")
		touch.tap(45,  161)	
		sys.msleep(200)
		touch.tap(124,  218)
	]]--	
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
		nLog("1502 自动挂机.............")
		touch.tap(1085,  344)	
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
			{  358,   37, 0xe77b37},
			{  343,   37, 0x7d422c},
			{  375,  288, 0x785b2f},
			{  420,  290, 0x755a30},
			{  444,  288, 0x20d700},
			{  449,  294, 0x1eff00},
			}) then
		nLog("2279 可交付任务")
		touch.tap(921,  570)
	elseif screen.is_colors({
			{  323,   36, 0xe8dedb},
			{  350,   32, 0xece5e2},
			{  214,   35, 0xdecc95},
			{  233,   38, 0xc6b67f},
			{  277,   36, 0xfae6ae},
			{  244,   41, 0xc09603},
			}) then 
		nLog("2273 转为赏金任务")
		touch.tap(244,   41)
		sys.msleep(500)
		touch.tap(922,  569)
		shangjin_flag ='Y'
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

--[[
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
	end
	]]--

	if screen.is_colors({
			{  981,   29, 0xd4bb72},
			{ 1018,   31, 0xc7a460},
			{ 1047,   33, 0xbf8344},
			{ 1076,   29, 0xd2b366},
			{ 1104,   39, 0xd9b263},
			})then
		nLog("2060 跳过引导" )
		touch.tap(1104,   39)
	end
	screen.unkeep()
	--nLog(fuhuo)
	sys.msleep(3000)
	--nLog("2055 end")
	testrun()

	if screen.is_colors({
			{  840,  258, 0xba8b48},
			{  753,  409, 0x578430},
			{  773,  415, 0x7d9e89},
			{  794,  420, 0x3b6d4d},
			{  770,  427, 0xeff3f0},
			{  790,  424, 0xc1d1c6},
			}) then
		nLog("2319 穿装备")
		touch.tap(790,  424)
	elseif screen.is_colors({
			{  758,  407, 0x537c2a},
			{  807,  411, 0x648d31},
			{  777,  423, 0x387420},
			{  787,  424, 0xcfdcd3},
			}) then 
		nLog("2337 查看装备")
		sys.msleep(100)
		touch.tap(787,  424)
	elseif screen.is_colors({
			{  747,  408, 0x577c2f},
			{  768,  419, 0xc7d5cb},
			{  789,  418, 0xfbfcfa},
			}) then --查看装备
		nLog("2345 查看装备")
		sys.msleep(200)
		touch.tap(789,  418)
	end

	if screen.is_colors({
			{  921,  387, 0x67a01d},
			{  950,  406, 0xfffffe},
			{  976,  401, 0xfafbfa},
			}) then --穿上装备
		nLog("2355 穿上装备")
		sys.msleep(200)
		touch.tap(976,  401)	
	end
	sys.msleep(1000)
end