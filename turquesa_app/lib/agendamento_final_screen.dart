import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Para formatação de datas
import 'package:turquesa_app/home_screen.dart';
import 'package:turquesa_app/profile_screen.dart';
import 'franquias_screen.dart';

class AgendamentoFinalScreen extends StatefulWidget {
  final dynamic servico;
  final Franquia franquia;
  final String categoryName;
  final String userId;
  final String userEmail;
  final String userPhone;
  final String userName;

  AgendamentoFinalScreen({
    required this.servico,
    required this.franquia,
    required this.categoryName,
    required this.userEmail,
    required this.userId,
    required this.userName,
    required this.userPhone,
  });

  @override
  _AgendamentoFinalScreenState createState() => _AgendamentoFinalScreenState();
}

class _AgendamentoFinalScreenState extends State<AgendamentoFinalScreen> {
  List<dynamic> profissionais = [];
  dynamic profissionalSelecionado;
  List<String> horariosDisponiveis = [];
  DateTime? dataSelecionada;
  String? horarioSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarProfissionais();
  }

  Future<void> _carregarProfissionais() async {
    final response = await http.get(Uri.parse(
        'http://192.168.15.10:3000/profissionais/${widget.franquia.id}'));
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

  Future<void> _carregarHorariosDisponiveis(
      String profissionalId, DateTime data) async {
    final response = await http.get(Uri.parse(
        'http://192.168.15.10:3000/agendamentos/disponiveis/$profissionalId?data=${DateFormat('yyyy-MM-dd').format(data)}'));
    if (response.statusCode == 200) {
      List<String> horarios = List<String>.from(json.decode(response.body));

      setState(() {
        // Atualiza a lista de horários disponíveis com a resposta da API
        horariosDisponiveis = horarios;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar horários disponíveis.')),
      );
    }
  }

  Future<void> _confirmarAgendamento() async {
    if (profissionalSelecionado == null ||
        dataSelecionada == null ||
        horarioSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione todos os campos.')),
      );
      return;
    }

    final agendamento = {
      "profissionalId": profissionalSelecionado['_id'],
      "userId": widget.userId,
      "franquiaId": widget.franquia.id,
      "category": widget.categoryName,
      "subcategory": widget.servico['name'],
      "name": widget.userName,
      "data": dataSelecionada!.toIso8601String(),
      "hora": horarioSelecionado!,
      "price": widget.servico['price'],
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/agendamentos'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(agendamento),
    );

     if (response.statusCode == 201) {
    // Mostra o popup de confirmação
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agendamento confirmado!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Serviço: ${widget.servico['name']}'),
              Text('Profissional: ${profissionalSelecionado['nome']}'),
              Text('Data: ${DateFormat('dd/MM/yyyy').format(dataSelecionada!)}'),
              Text('Horário: $horarioSelecionado'),
              Text('Preço: R\$${widget.servico['price']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                ); // Navega para a tela de perfil
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else if (response.statusCode == 400) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Horário indisponível. Tente outro horário.')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao realizar agendamento.')),
    );
  }
}
  @override
  // Código atualizado

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Serviço: ${widget.servico['name']}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServiceCard(),
              SizedBox(height: 16),
              Text(
                'Profissionais disponíveis:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 200, 
                child: profissionais.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: profissionais.length,
                        itemBuilder: (context, index) {
                          final profissional = profissionais[index];
                          bool isSelected =
                              profissionalSelecionado == profissional;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                profissionalSelecionado = profissional;
                                dataSelecionada = null;
                                horarioSelecionado = null;
                              });
                              _carregarHorariosDisponiveis(
                                  profissional['_id'], DateTime.now());
                            },
                            child: _buildSpecialistCard(
                              profissional['imagemUrl'],
                              profissional['nome'],
                              profissional['especialidade'],
                              isSelected,
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 16),
              if (profissionalSelecionado != null) ...[
                Text(
                  'Selecione uma data:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  onDateChanged: (selectedDate) {
                    setState(() {
                      dataSelecionada = selectedDate;
                    });
                    _carregarHorariosDisponiveis(
                        profissionalSelecionado['_id'], selectedDate);
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Horários disponíveis:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                if (horariosDisponiveis.isNotEmpty)
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: horariosDisponiveis.length,
                      itemBuilder: (context, index) {
                        String horario = horariosDisponiveis[index];
                        bool isSelected = horarioSelecionado == horario;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              horarioSelecionado = horario;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromARGB(255, 133, 171, 171)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: isSelected
                                    ? const Color.fromARGB(144, 162, 196, 192)
                                    : Colors.grey,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              horario,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Text('Nenhum horário disponível para a data selecionada.'),
              ],
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _confirmarAgendamento,
                  child: Text('Confirmar Agendamento'),
                ),
              ),
            ],
          ),
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
            if (widget.servico['image'] != null &&
                widget.servico['image'].isNotEmpty)
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
                    widget.categoryName,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.servico['name'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.franquia.nome,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 80, 79, 79)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Preço: \$${widget.servico['price']}',
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 69, 65, 65)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialistCard(
      String? imageUrl, String? name, String? especialidade, bool isSelected) {
    return Card(
      elevation: 4,
      color: isSelected
          ? const Color.fromARGB(255, 205, 221, 221)
          : const Color.fromARGB(255, 244, 244, 244), // Efeito de seleção
      shape: isSelected
          ? RoundedRectangleBorder(
              side: BorderSide(
                  color: const Color.fromARGB(144, 162, 196, 192),
                  width: 2.0), // Borda colorida
              borderRadius: BorderRadius.circular(8.0),
            )
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(imageUrl,
                      height: 60, width: 60, fit: BoxFit.cover)
                  : Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[300],
                      child: Icon(Icons.person,
                          size: 30,
                          color: const Color.fromARGB(255, 246, 241, 241)),
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
                    style:
                        TextStyle(color: const Color.fromARGB(255, 14, 12, 12)),
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
