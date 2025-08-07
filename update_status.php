
<?php
include "db_config.php";

$id = $_POST['id'];

$query = "UPDATE run_pose SET status = 0 WHERE id = $id";
if(mysqli_query($conn, $query)){
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}
?>
