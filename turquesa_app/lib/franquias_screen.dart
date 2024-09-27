import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:turquesa_app/home_screen.dart';
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
          nome: franquia['nome'],
          imageUrl: franquia['imagemUrl'],  
          address: franquia['endereco'],      
          hours: franquia['horario'],         
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
        title: Text('Escolha a Unidade: ', style: TextStyle(fontSize: 18),),
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Container para a logo
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Image.network(
                    'https://turquesaesmalteria.com.br/wp-content/uploads/2020/07/Logo-Turquesa-Horizontal.png', // Substitua pelo URL da sua logo ou use Image.asset
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: franquias.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: FranquiaCard(franquia: franquias[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class Franquia {
  final String nome;
  final String imageUrl;
  final String address;
  final String hours;

  Franquia({required this.nome, required this.imageUrl, required this.address, required this.hours});
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
                    franquia.nome,  // Exibe o nome da franquia
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    franquia.address,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    franquia.hours,
                    style: TextStyle(
                      fontSize: 14,
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
