import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePageNoScroll(),
    );
  }
}

class ProfilePageNoScroll extends StatelessWidget {
  const ProfilePageNoScroll({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil (Tanpa Scroll)')),
      // Di sini SingleChildScrollView dihapus
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // === HEADER PROFIL ===
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text('👨‍💻', style: TextStyle(fontSize: 50)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Azhar Muttaqien',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // === BARIS STATISTIK ===
            Row(
              children: const [
                Expanded(
                  child: _StatBox(label: 'Post', value: '12'),
                ),
                Expanded(
                  child: _StatBox(label: 'Teman', value: '128'),
                ),
                Expanded(
                  child: _StatBox(label: 'Like', value: '1.2K'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // === SECTION CARDS ===
            const _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: 'Mahasiswa semester 6 Teknik Informatika UNPAS.',
            ),
            const _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Universitas Pasundan - Teknik Informatika',
            ),
            const _SectionCard(
              icon: Icons.star,
              title: 'Skills',
              content:
                  'Flutter • Dart • Homelab • Cybersecurity • Web Development',
            ),
            // Jika konten ini melebihi tinggi layar, akan muncul Overflow Error
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
