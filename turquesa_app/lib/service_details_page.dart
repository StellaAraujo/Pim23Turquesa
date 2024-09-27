// lib/service_details_page.dart
import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String categoryName;
  final List<dynamic> subcategories;

  ServiceDetailsPage({required this.categoryName, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços de $categoryName'),
      ),
      body: ListView.builder(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(subcategories[index]['name']),
              subtitle: Text('Preço: R\$${subcategories[index]['price']}'),
            ),
          );
        },
      ),
    );
  }
}
