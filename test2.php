<html>
 <head>
 </head>
 <body>
  <form name="myform" enctype="multipart/form-data" action="checkbox.php" method="post">   
<?php
/**
 * Simple example of extending the SQLite3 class and changing the __construct
 * parameters, then using the open method to initialize the DB.
 */
 

 
class MyDB extends SQLite3
{
    function __construct()
    {
        $this->open('mysqlitedb.db');
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
echo $v_acct;
$db->exec("INSERT INTO foo (acct_user,user_pwd,bar) VALUES ('$v_acct','pwd1','This is a test')");

$result = $db->query('SELECT acct_user,user_pwd,bar FROM foo');
/**
var_dump();
*/
echo "<TABLE >";
while($row= $result->fetchArray()){
	$acct_user= $row['acct_user'];
	$user_pwd= $row['user_pwd'];
	//echo '<input type="checkbox" name="hobby[]" value='.$row['acct_user'].'/>'.$row['acct_user'].'/'.$row['user_pwd'];
	echo "<input type='checkbox' name='hobby[]' value='$acct_user'/>$acct_user ,$user_pwd ";
	echo "<br>";	
}	
echo "</TABLE>";
?> 
 <input type="submit" value="提交" />
 </form>  
 </body>
</html>
