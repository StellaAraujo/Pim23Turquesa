import 'package:flutter/material.dart';

class Specialist {
  final String name;
  final String expertise;
  final String imageUrl;
  final double rating;
  final String bio;

  Specialist({
    required this.name,
    required this.expertise,
    required this.imageUrl,
    required this.rating,
    required this.bio,
  });
}

class TeamPage extends StatelessWidget {
  final List<Specialist> specialists = [
    Specialist(
      name: 'Ana Costa',
      expertise: 'Cabelo',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.5,
      bio: 'Especialista em cortes e penteados femininos.',
    ),
    Specialist(
      name: 'Bruna Souza',
      expertise: 'Manicure',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.7,
      bio: 'Especialista em manicure e pedicure.',
    ),
    Specialist(
      name: 'Carlos Lima',
      expertise: 'Barbeiro',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
      bio: 'Especialista em barba e cortes masculinos.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialistas'),
        backgroundColor: Colors.teal[600],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: specialists.length,
        itemBuilder: (context, index) {
          final specialist = specialists[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(specialist.imageUrl),
              ),
              title: Text(specialist.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(specialist.expertise),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${specialist.rating}'),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecialistDetailPage(specialist: specialist),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SpecialistDetailPage extends StatelessWidget {
  final Specialist specialist;

  // ignore: prefer_const_constructors_in_immutables
  SpecialistDetailPage({required this.specialist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(specialist.name),
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(specialist.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              specialist.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              specialist.expertise,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${specialist.rating}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Sobre:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(specialist.bio, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Lógica de exibir agenda disponível para o especialista
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text(
                'Ver Agenda',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
