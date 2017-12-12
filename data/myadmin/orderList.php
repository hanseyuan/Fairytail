<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];

@$status=$_REQUEST["status"];
$output=[];
//2获取参数pno页码,并判断
@$pno=$_REQUEST["pno"];
if(!$pno) $pno=1;

$output["pageNo"]=$pno;
//3 设置参数pageSize=3
@$pageSize=3;
$output["pageSize"]=$pageSize;


if($uid){


	$sql="SELECT aid,order_id,lid,title,RAM,ROM,color,price,count,payPrice,status,(SELECT md FROM `sc_phone_pic` WHERE color_id=color_num limit 1)  as md
			FROM sc_order inner 
			JOIN sc_phone ON lid=product_id 
			WHERE user_id=$uid "; 
	
	if($status){
		$output["status"]=$status;
		$sql.=" and status=$status  ";
	}
	//获得商品总数
	$output["count"]=count(sql_execute($sql));
	//页数 ceil上浮取值
	$output["pageCount"]=ceil($output["count"]/$output["pageSize"]);
	//每页显示的数据  limit 0,3
	$sql .=" ORDER  BY aid DESC  limit ".(($pno-1)*$pageSize).",".$pageSize;
	$output["data"]=sql_execute($sql);
	
	echo json_encode($output);
}