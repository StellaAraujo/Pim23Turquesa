import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
        backgroundColor: Colors.teal[600],
      ),
      body: Center(
        child: Text(
          'Informações',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
