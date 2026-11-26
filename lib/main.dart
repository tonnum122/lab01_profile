import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'About me',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab L1 · 67116046')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 96),
            SizedBox(height: 12),
            Text(
              'นายกฤตชานนท์ ณ ปานแก้ว - 67116046',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
