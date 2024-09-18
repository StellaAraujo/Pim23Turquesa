import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.teal[600],
      ),
      body: Center(
        child: Text(
          'Perfil',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
