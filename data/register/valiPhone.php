<?php
header("Content-Type:text/plain");
require_once("../init.php");
@$phone=$_REQUEST["phone"];
$sql="SELECT count(*) FROM sc_user where phone='".strtolower($phone)."'";
$result=sql_execute($sql);

if($result[0]["count(*)"]==1)
  echo "false";
else
  echo "true";