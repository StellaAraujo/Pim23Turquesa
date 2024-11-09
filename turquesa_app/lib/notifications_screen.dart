import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Lista para armazenar as avaliações
  List<Map<String, dynamic>> evaluations = [
    {
      'franquia': 0,
      'profissional': 0,
      'serviço': 0,
    }
  ];

  // Função para enviar a avaliação (localmente ou para o backend)
  void sendEvaluation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Avaliação enviada com sucesso!')),
    );

    // Navega para a tela home após enviar a avaliação
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Notificações"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationCard(
            "Promoção",
            "Você tem direito a 5% de desconto na próxima vez que fizer um agendamento e concluir a avaliação. Consulte o profissional para mais informações.",
            Icons.local_offer,
          ),
          const SizedBox(height: 16.0), // Espaço antes da seção de avaliação
          _buildEvaluationSection(context), // Adiciona a seção de avaliação
          const SizedBox(height: 16.0), // Espaço antes dos agendamentos
          _buildAgendamentosCard(context), // Adiciona o card de agendamentos
        ],
      ),
    );
  }

  Widget _buildNotificationCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildEvaluationSection(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Avalie sua experiência:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildRatingRow('Franquia', 'franquia'),
            _buildRatingRow('Profissional', 'profissional'),
            _buildRatingRow('Serviço', 'serviço'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: sendEvaluation, // Chama a função para enviar a avaliação
              child: const Text('Enviar Avaliação'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String label, String key) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                Icons.star,
                color: (evaluations.last[key] ?? 0) > index ? Colors.teal : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  evaluations.last[key] = index + 1; // Atualiza a avaliação
                });
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAgendamentosCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: const Text(
          "Meus Agendamentos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Veja seus agendamentos"),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
