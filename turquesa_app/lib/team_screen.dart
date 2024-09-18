import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipe'),
        backgroundColor: Colors.teal[600],
      ),
      body: Center(
        child: Text(
          'Equipe',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
