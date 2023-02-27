
<?php
include "../auth/connect.php";


$noteid=filterrequest("noteid");


$stmt = $con->prepare("DELETE FROM `notes` WHERE  `notes_id`= ? ") ; 
$stmt->execute(array($noteid));
$count=$stmt->rowCount();

if($count>0){

echo json_encode(array("status"=>"success"));

}else
{
echo json_encode(array("status"=>"fail"));

}


?>