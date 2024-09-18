import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a tela de Login

class FranquiasScreen extends StatelessWidget {
  final List<Franquia> franquias = [
    Franquia(
      imageUrl: 'https://via.placeholder.com/150', // Coloque a URL da imagem da unidade
      address: 'Rua das Flores, 123 - Centro',
      hours: 'Seg - Sex: 9h às 18h',
    ),
    Franquia(
      imageUrl: 'https://via.placeholder.com/150', // Coloque a URL da imagem da unidade
      address: 'Av. Brasil, 456 - Zona Sul',
      hours: 'Seg - Sex: 10h às 19h',
    ),
    Franquia(
      imageUrl: 'https://via.placeholder.com/150', // Coloque a URL da imagem da unidade
      address: 'Rua Azul, 789 - Jardim América',
      hours: 'Seg - Sab: 9h às 18h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Unidade'),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: franquias.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: FranquiaCard(franquia: franquias[index]),
            );
          },
        ),
      ),
    );
  }
}

class Franquia {
  final String imageUrl;
  final String address;
  final String hours;

  Franquia({required this.imageUrl, required this.address, required this.hours});
}

class FranquiaCard extends StatelessWidget {
  final Franquia franquia;

  FranquiaCard({required this.franquia});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                franquia.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    franquia.address,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    franquia.hours,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
