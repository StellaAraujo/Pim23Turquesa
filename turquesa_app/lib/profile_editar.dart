import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para usar input formatters
import 'package:http/http.dart' as http; // Para fazer requisições HTTP
import 'dart:convert'; // Para converter dados JSON

class EditProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userId;
  final String userPhone;

  const EditProfileScreen({
    required this.userName,
    required this.userEmail,
    required this.userId,
    required this.userPhone,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String unformattedPhone = widget.userPhone.replaceAll(RegExp(r'[^\d]'), '');
    _emailController.text = widget.userEmail;
    _phoneController.text = unformattedPhone;
  }

  // Função para atualizar o perfil no servidor
  Future<void> _updateProfile() async {
    final String email = _emailController.text;
    final String phone = _phoneController.text;

    const String url = 'http://192.168.15.12:3000/user/updateProfile';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'userId': widget.userId,
          'email': email,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        // Sucesso ao atualizar o perfil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil atualizado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar perfil')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 176, 171),
        title: Text("Editar perfil", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage("https://img.freepik.com/vetores-gratis/circulo-azul-com-usuario-branco_78370-4707.jpg"),
                  ),
                  SizedBox(height: 20),
            // Campo de Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Telefone com máscara
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11), // Limita para 11 dígitos
                _PhoneInputFormatter(), // Formata o número de telefone
              ],
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _updateProfile, // Chama a função de atualização
              child: Text("Atualizar"),
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 199, 205, 205),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
            ),   
          ],
        ),
      ),
    );
  }
}

// Classe para formatação de telefone
class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length <= 2) {
      return newValue;
    } else if (text.length <= 7) {
      final formattedText = text.replaceFirstMapped(
          RegExp(r'^(\d{2})(\d+)'), (m) => '(${m[1]}) ${m[2]}');
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      final formattedText = text.replaceFirstMapped(
          RegExp(r'^(\d{2})(\d{5})(\d+)'), (m) => '(${m[1]}) ${m[2]}-${m[3]}');
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}
