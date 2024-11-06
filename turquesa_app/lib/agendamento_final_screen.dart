import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Para formatação de datas
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
    final response = await http.get(
        Uri.parse('http://localhost:3000/profissionais/${widget.franquia.id}'));
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
        'http://localhost:3000/agendamentos/disponiveis/$profissionalId?data=${DateFormat('yyyy-MM-dd').format(data)}'));
    if (response.statusCode == 200) {
      setState(() {
        horariosDisponiveis = List<String>.from(json.decode(response.body));
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Agendamento realizado com sucesso!')),
      );
      Navigator.pop(context); // Voltar para a tela anterior
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Serviço: ${widget.servico['name']}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
      ),
      body: Padding(
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
            Expanded(
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
                      )),
            SizedBox(height: 16),
            // Data Picker
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  setState(() {
                    dataSelecionada = selectedDate;
                  });
                  // Carregar os horários para a data selecionada
                  if (profissionalSelecionado != null) {
                    _carregarHorariosDisponiveis(
                        profissionalSelecionado['_id'], selectedDate);
                  }
                }
              },
              child: Text(dataSelecionada == null
                  ? 'Selecione uma data'
                  : DateFormat('dd/MM/yyyy').format(dataSelecionada!)),
            ),
            // Horário Picker
            SizedBox(height: 16),
            DropdownButton<String>(
              hint: Text('Selecione um horário'),
              value: horarioSelecionado,
              onChanged: (newValue) {
                setState(() {
                  horarioSelecionado = newValue;
                });
              },
              items: horariosDisponiveis.map((horario) {
                return DropdownMenuItem<String>(
                  value: horario,
                  child: Text(horario),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Botão de confirmação de agendamento
            ElevatedButton(
              onPressed: _confirmarAgendamento,
              child: Text('Confirmar Agendamento'),
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

  Widget _buildSpecialistCard(String? imageUrl, String? name, String? especialidade, bool isSelected) {
  return Card(
    elevation: 4,
    color: isSelected ? const Color.fromARGB(255, 175, 211, 211): const Color.fromARGB(255, 244, 244, 244), // Efeito de seleção
    shape: isSelected 
      ? RoundedRectangleBorder(
          side: BorderSide(color: const Color.fromARGB(144, 83, 124, 119), width: 2.0), // Borda colorida
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
                ? Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover)
                : Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: 30, color: const Color.fromARGB(255, 246, 241, 241)),
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
                  style: TextStyle(color: const Color.fromARGB(255, 14, 12, 12)),
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