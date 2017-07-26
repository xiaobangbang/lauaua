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

	--args_json['source'] = "运行账号.csv"
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

initArgs()
list = CC.web_file.list("./running")
local batchid

nLog("文件个数")
nLog(#list)
--sys.alert(db_name)

if #list > 0 then
initArgs()
batchid=CC.web_file.size(list[1])

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
	--local args = proc_take("CC_args")
	--local args = json.decode(args)
	--local filename = args['source']
	local filename	
	list = CC.web_file.list("./running")
	if #list >0 then
		filename = "./running/"..list[1]
	
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

sys.msleep(1000)
initArgs()
--local aa = CC.web_file.exists(db_file_local)
local aa = CC.web_file.size(db_file_local)
nLog(CC.web_file.size(db_file_local))
nLog(db_file_local)
--size
if aa <= 0 then
	nLog("162 第一次，开始下载")
	initArgs()
	CC.web_file.down_file('foo2.db',db_file_local)
end
sys.msleep(2000)

while #list >0 do
	nLog(#list)
	--initArgs()
	acct1 = getLess60Account()
	local acct_name, acct_pwd  

	if acct1 ~= nil and string.len(acct1) >12  then 
			--sys.alert("getNewAccount:"..acct1)
		acct_name, acct_pwd = getUserAcct(string.atrim(acct1))
		
		if acct_name ~= nil then 				
			insGameAcct(acct_name)
			--sys.msleep(5000)
			--updGameAcct(acct_name,"Y")
			initArgs()
			recordOKAccount(acct1)
		end 
	else			
		initArgs()
		CC.web_file.update_file("upload_sqlite/"..db_name,db_file_local)
		sys.alert("account_less60.txt 没有账号了！")
		os.exit()
	end	
	list = CC.web_file.list("./running")
end	

end