<?php
header("Content-Type:text/plain");
require_once("../init.php");
@$uname=$_REQUEST["uname"];
$sql="SELECT count(*) FROM sc_user where uname='".strtolower($uname)."'";
$result=sql_execute($sql);

if($result[0]["count(*)"]==1)
  echo "false";
else
  echo "true";