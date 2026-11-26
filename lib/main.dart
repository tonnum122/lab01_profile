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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _likes = 0;

  void _like() {
    setState(() {
      _likes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab L1 · 67116046')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, size: 96),
              const SizedBox(height: 12),
              const Text(
                'นายกฤตชานนท์ ณ ปานแก้ว - 67116046',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text('Likes: $_likes'),
              const SizedBox(height: 8),
              FilledButton(onPressed: _like, child: const Text('Like')),
            ],
          ),
        ),
      ),
    );
  }
}
