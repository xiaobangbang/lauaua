<?php 
$result = "";
foreach( $_POST['hobby'] as $i)
{
 echo '<br>';
 $result .= $i;
}
echo $result;

?>