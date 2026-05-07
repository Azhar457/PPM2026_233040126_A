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
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final List<String> dataList = const [
    'Pesan Baru dari Budi',
    'Undangan Meeting di Ruang 1',
    'Notifikasi Update Sistem',
    'Jadwal Praktikum Mobile',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
    'Tugas Pemrograman Flutter',
  ];
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            ListTile(leading: Icon(Icons.settings), title: Text('Pengaturan')),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(width: 80, height: 80, color: Colors.red), // fixed 80px
              Expanded(
                child: Container(height: 80, color: Colors.green),
              ), // sisa ruang
              const SizedBox(width: 16), // jarak tetap
              Container(
                width: 80,
                height: 80,
                color: Colors.blue,
              ), // fixed 80px
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Aktivitas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(dataList[index]),
                subtitle: const Text('Klik untuk detail'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: (i) {},
      ),
    );
  }
}
