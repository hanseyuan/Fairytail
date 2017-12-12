<?php
header("Content-Type:application/json");
require_once("../init.php");
@$aid=$_REQUEST["aid"];
$sql="DELETE FROM sc_receiver_address WHERE  aid =$aid  ";
$result = mysqli_query($conn,$sql);
$row = mysqli_affected_rows($conn);
if($result && $row>0){
 echo '{"code":1,"msg":"删除成功"}';
}else{
 echo '{"code":-1,"msg":"删除失败"}';
}
?>