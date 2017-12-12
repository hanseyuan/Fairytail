<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[//包含三层楼所有首页商品的二维关联数组
  //"f1"=>[],
  //"f2"=>[],
  //"f3"=>[]
];
//查询一楼首推商品的sql语句
$sql="SELECT * FROM sc_floor_product where brand='HUAWEI'";
//查询出一楼的7个首推商品，保存在结果数组的f1子数组中
$output["f1"]=sql_execute($sql);

//查询二楼首推商品的sql语句
$sql="SELECT * FROM sc_floor_product where brand='SAMSUNG'";
//查询出二楼的7个首推商品，保存在结果数组的f1子数组中
$output["f2"]=sql_execute($sql);

//查询二楼首推商品的sql语句
$sql="SELECT * FROM sc_floor_product where brand='OPPO'";
//查询出二楼的7个首推商品，保存在结果数组的f1子数组中
$output["f3"]=sql_execute($sql);

echo json_encode($output);