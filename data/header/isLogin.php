<?php
session_start();
header("Content-Type:application/json");
@$uid=$_SESSION["uid"];
if($uid){
  //echo $uid;
  require_once("../init.php");
  $sql="select uname from sc_user where uid=$uid";
  $uname=sql_execute($sql)[0]["uname"];   
  ////echo '{"code":1,"uname":'$uname'}';     //uid 存在  获得uname
  echo json_encode(["code"=>1,"uname"=>$uname]);
}else{
  echo json_encode(["code"=>-1,"uname"=>""]);
}
