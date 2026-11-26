import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'About me', home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Hello!')));
  }
}
