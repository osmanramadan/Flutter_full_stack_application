<?php
include "../auth/connect.php";


$notetitle   = filterrequest("notetitle");
$notecontent = filterrequest("notecontent");
$noteid      = filterrequest("noteid");
$imagename   = filterrequest("imagename"); 


if (isset($_FILES['file'])) {
    deletefile("../auth/upload",$imagename);
$imagename = upload_file("file");

}

$stmt = $con->prepare("UPDATE `notes` SET `notes_title` = ?, `notes_content` = ? 
,  `notes_image` = ? WHERE `notes`.`notes_id` = ? ");
$stmt->execute(array($notetitle, $notecontent, $imagename, $noteid));

$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
?>