<html>
 <head>
 <script type="text/javascript"> 
function check_all(obj,cName) 
{ 
    var checkboxs = document.getElementsByName(cName); 
    for(var i=0;i<checkboxs.length;i++){checkboxs[i].checked = obj.checked;} 
} 
function check_submit(cName) 
{ 
	//alert(cName);
	var valid = 0;
    var checkboxs = document.getElementsByName(cName); 
	 for(var i=0;i<checkboxs.length;i++){		
		if (checkboxs[i].checked ==true) {
			//myform.submit();
			valid = 1;			
		}
	}
	
	if (valid==1){		
		
		document.getElementById("myform").submit()
	}else{
		alert("没有选择账号");
	}
	
} 
</script> 
 </head>
 <body>
  <form id="myform"  enctype="multipart/form-data" action="download-csv.php" method="post">
  <p><input type="checkbox" name="all" onclick="check_all(this,'hobby[]')" />全选/全不选</p> 
<?php
/**
 * Simple example of extending the SQLite3 class and changing the __construct
 * parameters, then using the open method to initialize the DB.
 */
 

 
class MyDB extends SQLite3
{
    function __construct()
    {
        $this->open('D:\XXT_Lan_2.5.5.0\data\foo2.db');
    }
	
	function generate_password( $length = 8 ) { 
// 密码字符集，可任意添加你需要的字符 
$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_ []{}<>~`+=,.;:/?|'; 
$password =''; 
for ( $i = 0; $i < $length; $i++ ) 
{ 
// 这里提供两种字符获取方式 
// 第一种是使用 substr 截取$chars中的任意一位字符； 
// 第二种是取字符数组 $chars 的任意元素 
// $password .= substr($chars, mt_rand(0, strlen($chars) – 1), 1); 
$password .= $chars[ mt_rand(0, strlen($chars) - 1) ]; 
} 
return $password; 
} 

}

$db = new MyDB();



/**
$db->exec('CREATE TABLE foo (bar STRING)');
*/
$v_acct = $db->generate_password(9);
//echo $v_acct;
//$db->exec("INSERT INTO foo (acct_user,user_pwd,bar) VALUES ('$v_acct','pwd1','This is a test')");

$result = $db->query('SELECT * FROM excel_acct_info');
/**
var_dump();
*/
echo "<TABLE border='1' bgcolor='yellow'>";
while($row= $result->fetchArray()){
	$acct_user= $row['acct_user'];
	$user_pwd= $row['user_pwd'];
	$v_csv_data=$acct_user.','.$user_pwd;
	echo "<tr>";
	echo "<td>";	
	//echo '<input type="checkbox" name="hobby[]" value='.$row['acct_user'].'/>'.$row['acct_user'].'/'.$row['user_pwd'];
	echo "<input type='checkbox' name='hobby[]' value='$v_csv_data'/>";
	echo "</td>";
	echo "<td>";		
	echo "$acct_user";
	echo "</td>";
	echo "<td>";
	echo "$user_pwd";
	echo "</td>";
	echo "</tr>";
}	
echo "</TABLE>";
?> 
 <input type="submit" value="提交" onclick="check_submit('hobby[]')"/>
 <input type="button" value="刷新当前页面" onclick="javascript:location.reload();" />
 </br></br>
 <a href="javascript:history.go(-1);"  title="返回">返回</a>
 </form>  
 </body>
</html>
