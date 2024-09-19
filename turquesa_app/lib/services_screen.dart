// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'name': 'Corte de Cabelo',
      'description': 'Corte moderno e estilizado para qualquer ocasião.',
      'price': 'R\$50'
    },
    {
      'name': 'Manicure',
      'description': 'Cuide das suas unhas com nossos especialistas.',
      'price': 'R\$30'  
    },
    {
      'name': 'Pedicure',
      'description': 'Tratamento completo para seus pés.',
      'price': 'R\$30'
    },
    {
      'name': 'Hidratação Capilar',
      'description': 'Hidratação profunda para cabelos saudáveis.',
      'price': 'R\$40'
    },
    // Adicione mais serviços conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços Detalhados'),
        backgroundColor: Colors.teal[600],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    service['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    service['description']!,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Preço: ${service['price']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/booking');
                    },
                    child: Text('Agendar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
