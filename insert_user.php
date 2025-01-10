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
    $name = $_POST['name'];
    $email = $_POST['email'];

    $sql = "INSERT INTO users (name, email) VALUES ('$name', '$email')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Record added successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => $conn->error]);
    }
}

$conn->close();
?>
