import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioFeed avec Vérification',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CheckUserPage(),
    );
  }
}

class CheckUserPage extends StatefulWidget {
  @override
  _CheckUserPageState createState() => _CheckUserPageState();
}

class _CheckUserPageState extends State<CheckUserPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String message = '';

  Future<void> checkUser() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    final url = Uri.parse("http://192.168.137.1:8080/check_user.php");

    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          // Navigation vers la page d'accueil si succès
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BioFeedMainPage()),
          );
        } else {
          setState(() {
            message = jsonResponse['message'];
          });
        }
      } else {
        setState(() {
          message = 'Erreur de connexion au serveur';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Erreur : $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vérification d\'utilisateur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration:
                  const InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: checkUser,
                    child: const Text('Connexion'),
                  ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//classe pour la page génerale de l'application qui rassemble tous les autres pages
class BioFeedMainPage extends StatefulWidget {
  @override
  State<BioFeedMainPage> createState() => _BioFeedMainPageState();
}

class _BioFeedMainPageState extends State<BioFeedMainPage> {
  var selectedIndex = 0;

  void _updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage(onSelectPage: _updateIndex);
        break;
      case 1:
        page = Profile();
        break;
      case 2:
        page = const StockPage();
        break;
      case 3:
        page = const VentPage();
        break;
      case 4:
        page = const ProductionPage();
        break;
      default:
        throw UnimplementedError();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('BioFeed'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'BioFeed Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _updateIndex(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Gestion Profil'),
              onTap: () {
                _updateIndex(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.construction),
              title: const Text('Gestion de Production'),
              onTap: () {
                _updateIndex(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Gestion de stock'),
              onTap: () {
                _updateIndex(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu),
              title: const Text('Gestion du vente'),
              onTap: () {
                _updateIndex(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: page,
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(int) onSelectPage;

  const HomePage({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              size: 100,
              color: Colors.green, // Couleur de l'icône
            ),
            const SizedBox(height: 20), // Espace entre l'icône et le texte
            Text(
              'Bienvenue sur BioFeed !',
              style: TextStyle(fontSize: 28),
            ),
            Text(
              'Application BioFeed : '
              'Services pour la gestion des produits alimentaires pour les animaux.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class VentPage extends StatelessWidget {
  const VentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Vente'),
      ),
      body: const Center(
        child: Text('Gestion de vente'),
      ),
    );
  }
}

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de stock'),
      ),
      body: const Center(
        child: Text('Gestion de Stock'),
      ),
    );
  }
}

class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Producton'),
      ),
      body: const Center(
        child: Text('Page Production'),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Fonction pour ajouter un utilisateur
  Future<void> saveUser(String name, String email) async {
    final url = Uri.parse('http://192.168.137.1:8080/insert_user.php');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      print('User added successfully: ${response.body}');
    } else {
      print('Failed to add user: ${response.statusCode}');
    }
  }

  // Fonction pour supprimer un utilisateur
  Future<void> deleteUser(String email) async {
    final url = Uri.parse('http://192.168.137.1:8080/delete_user.php');
    final response = await http.post(
      url,
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      print('User deleted successfully: ${response.body}');
    } else {
      print('Failed to delete user: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;

                if (name.isNotEmpty && email.isNotEmpty) {
                  saveUser(name, email);
                  nameController.clear();
                  emailController.clear();
                } else {
                  print('Please fill in all fields');
                }
              },
              child: Text('Add User'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;

                if (email.isNotEmpty) {
                  deleteUser(email);
                  emailController.clear();
                } else {
                  print('Please enter an email to delete');
                }
              },
              child: Text('Delete User'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
