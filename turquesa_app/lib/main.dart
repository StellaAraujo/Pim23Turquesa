// lib/main.dart

import 'package:flutter/material.dart';
import 'franquias_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'service_details_page.dart';
import 'register_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'apresentacao_screen.dart';

void main() {
  runApp(TurquesaApp());
}

class TurquesaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        fontFamily: 'Sansita', 
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AboutUsScreen (),           // Tela "Sobre Nós"
        '/login': (context) => LoginPage(),          // Tela de Login
        '/home': (context) => HomePage(),            // Tela Home
        '/register': (context) => RegisterPage(),    // Tela de Registro
        '/profile': (context) => ProfileScreen(),    // Tela de Perfil
        '/notifications': (context) => NotificationsPage(),  // Tela de Notificações
        '/services': (context) => ServiceDetailsPage(   // Tela de Serviços Detalhados
          categoryName: 'Cabelo',  
          subcategories: []),
      },
    );
  }
}
