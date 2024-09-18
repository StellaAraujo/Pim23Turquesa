// booking_page.dart
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento'),
        backgroundColor: Colors.teal[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tela de Agendamento',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Aqui você pode agendar seus serviços.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              // Adicione widgets adicionais para o formulário de agendamento aqui
            ],
          ),
        ),
      ),
    );
  }
}
