<?php
header("Content-Type:application/json");
//1加载init.php
require_once("../init.php");
$output=[];
//2获取参数pno页码,并判断
@$pno=$_REQUEST["pno"];
if(!$pno) $pno=1;

$output["pageNo"]=$pno;
//3 设置参数pageSize=16
@$pageSize=16;
$output["pageSize"]=$pageSize;
//4获取参数kw
@$kw=$_REQUEST["kw"];
//5 SQL拼接字符串 
$sql="SELECT lid, title, price,color_num,(SELECT md FROM `sc_phone_pic` WHERE color_id=color_num  limit 1) as md from sc_phone";//查询所有记录


//添加条件:搜索 关键字
if(!$kw){        //如果关键字不存在，赋值""
    $kw =" ";
}else{
	$kws=explode(" ",$kw);  //空格 打散
	//遍历每个关键词 拼成 title like %kw%
	for($i=0;$i<count($kws);$i++){
		$kws[$i]=" title like '%".$kws[$i]."%' ";
	}
	//添加到where上
	$where="  where ".implode(" and ",$kws);
	//拼接
	$sql=$sql.$where;

}

//获得商品总数
$output["count"]=count(sql_execute($sql));
//页数 ceil上浮取值
$output["pageCount"]=ceil($output["count"]/$output["pageSize"]);
//每页显示的数据  limit 0,16
$sql .=" limit ".(($pno-1)*$pageSize).",".$pageSize;
$output["data"]=sql_execute($sql);




echo json_encode($output);



