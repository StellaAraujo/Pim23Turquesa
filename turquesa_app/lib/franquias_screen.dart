import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a tela de Login

class FranquiasScreen extends StatelessWidget {
  final List<Franquia> franquias = [
    Franquia(
      imageUrl: 'https://franquiaturquesa.com.br/wp-content/uploads/2024/06/camarim.png', // Coloque a URL da imagem da unidade
      address: 'Shopping ABC - Av Pereira Barreto, 42 (Loja 203A)',
      hours: 'Seg - Sab: 10h às 22h',
    ),
    Franquia(
      imageUrl: 'https://franquiaturquesa.com.br/wp-content/uploads/2024/06/esmalteria-beleza.png', // Coloque a URL da imagem da unidade
      address: 'Rua Continental, 390 - Jardim do Mar, SBC',
      hours: 'Ter - Sab: 9h às 19h',
    ),
    Franquia(
      imageUrl: 'https://franquiaturquesa.com.br/wp-content/uploads/2024/06/esmalteria-beleza.png', // Coloque a URL da imagem da unidade
      address: 'Rua das Palmeiras, 29 - Jardim, Santo André',
      hours: 'Ter - Sab: 9h às 19h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Unidade'),
        backgroundColor: const Color.fromARGB(255, 114, 178, 171),
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
