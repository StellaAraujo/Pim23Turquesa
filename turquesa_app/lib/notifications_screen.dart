import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Notifications"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationCard(
              "Reminder", "Your appointment is tomorrow at 10:00 AM", Icons.calendar_today),
          _buildNotificationCard(
              "Promotion", "50% off on all hair treatments!", Icons.local_offer),
          _buildNotificationCard(
              "Update", "Your profile has been successfully updated", Icons.update),
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
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          // Adicionar funcionalidade de navegação ou ação
        },
      ),
    );
  }
}
