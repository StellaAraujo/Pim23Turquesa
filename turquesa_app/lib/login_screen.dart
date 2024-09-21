import 'package:flutter/material.dart';
import 'register_screen.dart'; // Importa a tela de Registro
import 'home_screen.dart'; // Importa a tela de Home
import 'dart:convert'; // Para converter dados para JSON
import 'package:http/http.dart' as http; // Para fazer requisições HTTP

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  // Controladores para os campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Função para autenticar o usuário
  Future<void> _authenticateUser() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    const String url = 'http://localhost:3000/user/login'; // URL da sua API de login

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Se a autenticação for bem-sucedida
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login realizado com sucesso!')),
        );

        // Navega para a tela de Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Se as credenciais estiverem erradas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ou senha inválidos')),
        );
      }
    } catch (e) {
      // Tratamento de erros
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo acima do nome do salão
              Image.network(
                'https://alugueon.com.br/wp-content/uploads/2023/02/logo-turquesa-esmalteria-franquia-alugueon.png', // Substitua pela URL da logo
                height: 120,
              ),
              SizedBox(height: 20),

              // Nome do salão
              Text(
                'Turquesa Esmalteria & Beleza',
                style: TextStyle(
                  color: Colors.teal[800],
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Campo de e-mail
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.teal[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Campo de senha com ícone de "olhinho"
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.teal[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.teal[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Botão de Entrar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                ),
                onPressed: () {
                  _authenticateUser(); // Chama a função de autenticação
                },
                child: Text('Entrar', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),

              // Botão de Registrar-se
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  'Registrar-se',
                  style: TextStyle(color: Colors.teal[700], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
