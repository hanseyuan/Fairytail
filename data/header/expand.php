<?php
header("Content-type:application/json");
require_once("../init.php");

@$kw=$_REQUEST["term"];
//$kw="apple";
$sql="select title from  sc_phone ";
if($kw){
  $kws=explode(" ",$kw);//js:split
  for($i=0;$i<count($kws);$i++){
    $kws[$i]=" title like '%".$kws[$i]."%'";
  }
  $where=" where ".implode(" and ",$kws);
  $sql=$sql.$where;
}
$sql=$sql." limit 10 ";
echo json_encode(sql_execute($sql));

