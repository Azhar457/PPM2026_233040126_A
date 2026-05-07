import 'package:flutter/material.dart';
import 'latihan_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Flutter Pertemuan 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('\u{1F44B}', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text(
              'Halo, Azhar Muttaqien !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NIM: 233040126', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(
                    'Prodi: Teknik Informatika',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text('Semester: 6', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Text(
              'Selamat datang di dunia Flutter.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Latihan1Page()),
                    );
                  },
                  child: const Text('Latihan 1'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Latihan2Page()),
                    );
                  },
                  child: const Text('Latihan 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

