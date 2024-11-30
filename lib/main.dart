import 'package:flutter/material.dart';
import 'login_view.dart'; 
import 'user.dart';
import 'dart:convert';  // Para convertir a JSON


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App Viajes',
      debugShowCheckedModeBanner: false, 
      home: LoginView(), 
    );
  }
}


