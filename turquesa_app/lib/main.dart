import 'package:flutter/material.dart';
import 'franquias_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'team_screen.dart';
import 'info_screen.dart';
import 'profile_screen.dart';

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
        '/team': (context) => TeamPage(),
        '/info': (context) => InfoPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
