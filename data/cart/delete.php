<?php
header("Content-Type:application/json");
require_once("../init.php");
@$iid=$_REQUEST["iid"];
$sql="DELETE FROM `sc_shoppingcart_item` WHERE `sc_shoppingcart_item`.`iid` =$iid ";
$result = mysqli_query($conn,$sql);
$row = mysqli_affected_rows($conn);
if($result && $row>0){
 echo '{"code":1,"msg":"删除成功"}';
}else{
 echo '{"code":-1,"msg":"删除失败"}';

}
?>
