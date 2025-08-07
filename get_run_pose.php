
<?php
include "db_config.php";

$query = "SELECT * FROM run_pose WHERE status = 1";
$result = mysqli_query($conn, $query);

$poses = array();
while($row = mysqli_fetch_assoc($result)) {
    $poses[] = $row;
}

echo json_encode($poses);
?>
