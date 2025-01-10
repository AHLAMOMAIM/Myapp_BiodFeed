<?php
$servername = "localhost";
$username = "root";
$password = "EnsAh@2001";
$dbname = "flutter_app";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];

    $sql = "DELETE FROM users WHERE email = '$email'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "User deleted successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => $conn->error]);
    }
}

$conn->close();
?>
