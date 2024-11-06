// profile_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turquesa_app/apresentacao_screen.dart';
import 'profile_editar.dart';
import 'user_session.dart';

class ProfileScreen extends StatelessWidget {
  // O construtor não precisa mais receber os parâmetros
  ProfileScreen();

  // Função para fazer o logout
  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remover os dados de login do armazenamento local
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('userId');
    await prefs.remove('userPhone');

    // Navegar para a tela de apresentação (sem possibilidade de voltar)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => AboutUsScreen()), // Sua tela de login/apresentação
      (Route<dynamic> route) => false,
    );
  }

  // Função para exibir a confirmação de logout
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário precisa confirmar ou cancelar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar logout: '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você deseja deslogar?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Deslogar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _logout(context); // Faz o logout
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Acessa os dados do usuário diretamente da UserSession
    String userName = UserSession.userName;
    String userEmail = UserSession.userEmail;
    String userId = UserSession.userId;
    String userPhone = UserSession.userPhone;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 125, 177, 171),
        title: Text("Perfil de $userName", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Dados Pessoais
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://img.freepik.com/vetores-gratis/circulo-azul-com-usuario-branco_78370-4707.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela de edição de perfil
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            userName: userName, // Passe o nome do usuário
                            userEmail: userEmail,
                            userId: userId,
                            userPhone: userPhone, // Passe o e-mail do usuário
                          ),
                        ),
                      );
                    },
                    child: Text("Editar perfil"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 149, 171, 171),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Histórico de Serviços
            Text(
              "Histórico de Serviços",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildServiceHistoryItem("Corte de Cabelo", "Concluído", "25 Set 2023"),
            _buildServiceHistoryItem("Spa", "Próximo", "30 Set 2023"),
            _buildServiceHistoryItem("Maquiagem", "Concluído", "10 Set 2023"),
            SizedBox(height: 20),

            // Botão de Logout
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutConfirmation(context); // Chama o diálogo de confirmação
                },
                child: Text("Sair"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(198, 244, 67, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os itens do histórico de serviços
  Widget _buildServiceHistoryItem(String service, String status, String date) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(Icons.check_circle, color: status == "Concluído" ? Colors.green : Colors.orange),
      title: Text(service),
      subtitle: Text("Status: $status"),
      trailing: Text(date),
    );
  }
}
