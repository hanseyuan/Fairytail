<?php
header("Content-Type:application/json");
require_once("../init.php");
$sql="SELECT * FROM sc_index_carousel ORDER  BY cid DESC LIMIT 4";
echo json_encode(sql_execute($sql));