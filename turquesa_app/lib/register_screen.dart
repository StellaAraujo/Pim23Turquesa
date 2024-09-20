import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para usar input formatters
import 'package:intl/intl.dart'; // Para formatar a data

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  final _cpfController = TextEditingController();
  final _dateController = TextEditingController();
  final _phoneController = TextEditingController();

  // Formatação de data (dd/MM/yyyy)
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo acima do formulário
            Image.network(
              'https://alugueon.com.br/wp-content/uploads/2023/02/logo-turquesa-esmalteria-franquia-alugueon.png', // Substitua pela URL da logo
              height: 120,
            ),
            SizedBox(height: 20),

            // Campo de Nome
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de CPF com máscara
            TextField(
              controller: _cpfController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                _CpfInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'CPF',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Data de Nascimento
            TextField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Data de Nascimento',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.teal),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
              readOnly: true, // Impede a digitação manual
            ),
            SizedBox(height: 20),

            // Campo de Telefone com máscara
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                _PhoneInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'Telefone',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Email
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Senha com ícone de "olhinho"
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.teal[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
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

            // Botão de Registro
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              ),
              onPressed: () {
                // Ação de registro
              },
              child: const Text('Registrar', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// Máscara para CPF
class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length <= 11) {
      final newText = StringBuffer();
      int selectionIndex = newValue.selection.end;

      if (text.length >= 3) {
        newText.write(text.substring(0, 3) + '.');
        if (selectionIndex >= 3) selectionIndex++;
      }
      if (text.length >= 6) {
        newText.write(text.substring(3, 6) + '.');
        if (selectionIndex >= 6) selectionIndex++;
      }
      if (text.length >= 9) {
        newText.write(text.substring(6, 9) + '-');
        if (selectionIndex >= 9) selectionIndex++;
      }
      if (text.length >= 11) {
        newText.write(text.substring(9, 11));
      }
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    return oldValue;
  }
}

// Máscara para Telefone
class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length <= 11) {
      final newText = StringBuffer();
      int selectionIndex = newValue.selection.end;

      if (text.length >= 2) {
        newText.write('(' + text.substring(0, 2) + ') ');
        if (selectionIndex >= 2) selectionIndex += 3;
      }
      if (text.length >= 7) {
        newText.write(text.substring(2, 7) + '-');
        if (selectionIndex >= 7) selectionIndex++;
      }
      if (text.length >= 11) {
        newText.write(text.substring(7, 11));
      }
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    return oldValue;
  }
}
