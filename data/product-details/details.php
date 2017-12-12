<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[];
@$lid=$_REQUEST["lid"];

if($lid){
  $sql="select * from sc_phone where lid=$lid";
  $output["phone"]=sql_execute($sql)[0];
  
  /*查询大中小图*/
  $color_num=$output["phone"]["color_num"];
  $sql="SELECT * FROM sc_phone_pic where color_id=$color_num";
  $output["phone"]["pics"]=sql_execute($sql);


  /*查询详情图*/
  $a=$output["phone"]["family_id"];
  $sql="SELECT phonePic,brandPic FROM sc_phone_family where fid=$a";
  $output["phone"]["details"]=sql_execute($sql);

  $fid=$output["phone"]["family_id"];
  $sql="select fid,fname from sc_phone_family where fid=$fid";
  $output["family"]=sql_execute($sql)[0];
 
  /*查询所有版本*/
  $sql="SELECT  DISTINCT RAM from sc_phone where family_id=$fid";
  $output["family"]["RAM"]=sql_execute($sql);
  /*查询所有内存*/
  $sql="SELECT  DISTINCT ROM from sc_phone where family_id=$fid";
  $output["family"]["ROM"]=sql_execute($sql);
  /*查询所有颜色*/
  $sql="SELECT  DISTINCT color from sc_phone where family_id=$fid";
  $output["family"]["color"]=sql_execute($sql);



  echo json_encode($output);
}else{
  echo "[]";
}
