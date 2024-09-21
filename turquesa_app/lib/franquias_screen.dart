import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para converter a resposta JSON
import 'login_screen.dart'; // Importa a tela de Login

class FranquiasScreen extends StatefulWidget {
  @override
  _FranquiasScreenState createState() => _FranquiasScreenState();
}

class _FranquiasScreenState extends State<FranquiasScreen> {
  List<Franquia> franquias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFranquias();
  }

  Future<void> fetchFranquias() async {
    final response = await http.get(Uri.parse('http://192.168.15.14:3000/franquias'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        franquias = data.map((franquia) => Franquia(
          imageUrl: franquia['imagemUrl'],  // Verifique se este nome está correto
          address: franquia['endereco'],      // Verifique se este nome está correto
          hours: franquia['horario'],         // Verifique se este nome está correto
        )).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load franquias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Unidade'),
        backgroundColor: const Color.fromARGB(255, 114, 178, 171),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
