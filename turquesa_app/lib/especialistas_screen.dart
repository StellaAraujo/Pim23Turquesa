import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para converter a resposta JSON

class EspecialistasScreen extends StatefulWidget {
  @override
  _EspecialistasScreenState createState() => _EspecialistasScreenState();
}

class _EspecialistasScreenState extends State<EspecialistasScreen> {
  List<Especialista> especialistas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEspecialistas();
  }

  Future<void> fetchEspecialistas() async {
    final response = await http.get(Uri.parse('http://192.168.15.14:3000/especialistas'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        especialistas = data.map((especialista) => Especialista(
          nome: especialista['nome'],
          especialidade: especialista['especialidade'],
          imagemUrl: especialista['imagemUrl'],
        )).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load especialistas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialistas'),
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: especialistas.length,
              itemBuilder: (context, index) {
                return EspecialistaCard(especialista: especialistas[index]);
              },
            ),
    );
  }
}

class Especialista {
  final String nome;
  final String especialidade;
  final String imagemUrl;

  Especialista({required this.nome, required this.especialidade, required this.imagemUrl});
}

class EspecialistaCard extends StatelessWidget {
  final Especialista especialista;

  EspecialistaCard({required this.especialista});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                especialista.imagemUrl,
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
                    especialista.nome,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    especialista.especialidade,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
