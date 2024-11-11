import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turquesa_app/apresentacao_screen.dart';
import 'profile_editar.dart';
import 'user_session.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  // O construtor não precisa mais receber os parâmetros
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<dynamic> agendamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAgendamentos(); // Carregar os agendamentos ao iniciar
  }

  // Função para buscar os agendamentos do usuário
 Future<void> _fetchAgendamentos() async {
  String userId = UserSession.userId;
  try {
    final response = await http
        .get(Uri.parse('http://localhost:3000/agendamentos/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Ordena os agendamentos pela data mais próxima para a mais distante
      data.sort((a, b) {
        DateTime dataA = DateTime.parse(a['data']);
        DateTime dataB = DateTime.parse(b['data']);
        return dataA.compareTo(dataB);
      });

      setState(() {
        // Mapeia e formata a data para o formato DD/MM/AAAA HH:mm
        agendamentos = data.map((agendamento) {
          return {
            ...agendamento,
            'data': formatarData(agendamento['data']),
          };
        }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Erro na requisição: ${response.statusCode}");
      print("Corpo da resposta: ${response.body}");
      throw Exception('Erro ao carregar agendamentos');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print("Erro na requisição: $e");
    throw Exception('Erro ao carregar agendamentos');
  }
}

  // Função para formatar a data
  String formatarData(String dataOriginal) {
    try {
      DateTime dateTime = DateTime.parse(dataOriginal);
      return DateFormat('dd/MM/yyyy ').format(dateTime);
    } catch (e) {
      return dataOriginal; // Retorna o valor original em caso de erro
    }
  }

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
      MaterialPageRoute(builder: (context) => AboutUsScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Função para exibir a confirmação de logout
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
    String userName = UserSession.userName;
    String userEmail = UserSession.userEmail;
    String userId = UserSession.userId;
    String userPhone = UserSession.userPhone;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 125, 177, 171),
        title: Text("Perfil de $userName",
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16)),
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
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/vetores-gratis/circulo-azul-com-usuario-branco_78370-4707.jpg"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            userName: userName,
                            userEmail: userEmail,
                            userId: userId,
                            userPhone: userPhone,
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

            // Exibição dos agendamentos
            isLoading
                ? Center(child: CircularProgressIndicator())
                : agendamentos.isEmpty
                    ? Center(child: Text("Você não tem agendamentos"))
                    : Column(
                        children: agendamentos.map((agendamento) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            leading:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            title: Text(agendamento['name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( "${agendamento['subcategory']}"),
                                Text("R\$${agendamento['price']} | Status: ${agendamento['status']}"),
                              ],
                            ),
                            trailing: Text(
                                "${agendamento['data']} - ${agendamento['hora']}"),
                          );
                        }).toList(),
                      ),

            // Botão de Logout
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutConfirmation(
                      context); // Chama o diálogo de confirmação
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
}