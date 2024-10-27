import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turquesa_app/franquias_screen.dart';

class AgendamentoFinalScreen extends StatefulWidget {
  final dynamic servico;
  final Franquia franquia;
  final String categoryName;
  final String userId;
  final String userEmail;
  final String userName;

  AgendamentoFinalScreen({
    required this.servico,
    required this.franquia,
    required this.categoryName,
    required this.userEmail,
    required this.userId,
    required this.userName,
  });

  @override
  _AgendamentoFinalScreenState createState() => _AgendamentoFinalScreenState();
}

class _AgendamentoFinalScreenState extends State<AgendamentoFinalScreen> {
  List<dynamic> profissionais = [];
  dynamic profissionalSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarProfissionais();
  }

  Future<void> _carregarProfissionais() async {
    final response = await http.get(Uri.parse('http://192.168.15.12:3000/profissionais/${widget.franquia.id}'));
    if (response.statusCode == 200) {
      List<dynamic> allProfissionais = json.decode(response.body);
      setState(() {
        profissionais = allProfissionais.where((profissional) {
          return profissional['especialidade'] == widget.categoryName;
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar profissionais.')),
      );
    }
  }

  // Método para abrir o BottomSheet com os dias e horários disponíveis
  void _mostrarDiasHorariosDisponiveis(dynamic profissional) {
    List<DateTime> diasDisponiveis = [
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 3)),
    ];

    List<String> horariosDisponiveis = ["09:00", "11:00", "14:00", "16:00"];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildHorarioSheet(context, profissional, diasDisponiveis, horariosDisponiveis);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agendar ${widget.servico['name']}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibir informações do serviço, categoria e franquia selecionados
            _buildServiceCard(),
            SizedBox(height: 16),
            // Exibir lista de profissionais
            Text(
              'Selecione um profissional:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: profissionais.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: profissionais.length,
                      itemBuilder: (context, index) {
                        final profissional = profissionais[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              profissionalSelecionado = profissional;
                            });
                            _mostrarDiasHorariosDisponiveis(profissional);
                          },
                          child: _buildSpecialistCard(
                            profissional['imagemUrl'], // URL da imagem do profissional
                            profissional['nome'],      // Nome do profissional
                            profissional['especialidade'], // Especialidade
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.servico['image'] != null && widget.servico['image'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.servico['image'],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.categoryName, // Nome da categoria
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.servico['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.franquia.nome,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 80, 79, 79)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Preço: \$${widget.servico['price']}',
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 69, 65, 65)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialistCard(String? imageUrl, String? name, String? especialidade) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover)
                  : Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[300],
                      child: Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? 'Nome não disponível',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Especialidade: ${especialidade ?? 'Não especificada'}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorarioSheet(BuildContext context, dynamic profissional, List<DateTime> dias, List<String> horarios) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView( // Adicionado para permitir rolagem
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Horários disponíveis para o profissional ${profissional['nome']}:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (DateTime dia in dias)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(dia),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: horarios.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(horarios[index]),
                      onTap: () {
                        // Confirmar agendamento
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirmar Agendamento'),
                            content: Text(
                              'Você está agendando o serviço ${widget.servico['name']} com o(a) profissional ${profissional['nome']} para o dia ${DateFormat('dd/MM/yyyy').format(dia)} às ${horarios[index]}.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Lógica para confirmar agendamento
                                  Navigator.pop(context);
                                },
                                child: Text('Confirmar'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

}
