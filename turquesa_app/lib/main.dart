import 'package:flutter/material.dart';
import 'package:turquesa_app/offers_screen.dart';
import 'franquias_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'booking_screen.dart';
import 'register_screen.dart';
import 'team_screen.dart';
import 'profile_screen.dart';
import 'services_screen.dart';
import 'notifications_screen.dart';

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
        '/': (context) => FranquiasScreen(),
        '/login':(context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/specialists': (context) => TeamPage(),
        '/services': (context) => ServicesPage(),
        '/booking': (context) => BookingScreen(),
        '/profile': (context) => ProfileScreen(),
        '/notifications': (context) => NotificationsPage(),
        '/offers':(context) => OffersPage(),
      },
    );
  }
}
