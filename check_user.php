<?php
header("Content-Type: application/json");
//activation de raport d'erreur pour débogage
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Connexion à la base de données
$conn = new mysqli("localhost", "root", "EnsAh@2001", "Users");

// Vérification de la connexion
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Erreur de connexion à la base de données."]);
    exit;
}

// Codage des requêtes envoyées par Flutter
$data = json_decode(file_get_contents("php://input"), true);

// Vérification que les champs nécessaires sont fournis
if (isset($data['username']) && isset($data['password'])) {
    $username = $conn->real_escape_string($data['username']);
    $password = $conn->real_escape_string($data['password']);

    // Requête SQL pour vérifier si l'utilisateur et le mot de passe corect
    $query = "SELECT * FROM user_Profil WHERE username = '$username' AND password = '$password'";
    $result = $conn->query($query);

    if ($result && $result->num_rows > 0) {
        echo json_encode(["success" => true, "message" => "Authentification réussie."]);
    } else {
        echo json_encode(["success" => false, "message" => "Nom d'utilisateur ou mot de passe incorrect."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Nom d'utilisateur ou mot de passe non fourni."]);
}

$conn->close();
?>
