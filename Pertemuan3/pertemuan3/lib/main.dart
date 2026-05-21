import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {'/': (context) => const HomePage()},
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            final catatanToEdit = settings.arguments as Catatan?;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(catatan: catatanToEdit),
            );
          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

class Catatan {
  final String id;
  final String judul;
  final String isi;
  final String kategori;
  final String email;
  final DateTime dibuatPada;

  Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // === STATE ===
  String _filterKategori = 'Semua';
  final List<Catatan> _catatan = [
    Catatan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'flutter@mhs.unpas.ac.id',
      dibuatPada: DateTime.now(),
    ),
  ];

  // void _tambahDummy() {
  //   setState(() {
  //     _catatan.add(Catatan(
  //       judul: 'Catatan ${_catatan.length + 1}',
  //       isi: 'Isi dummy',
  //       kategori: 'Lainnya',
  //       dibuatPada: DateTime.now(),
  //     ));
  //   });
  // }

  String _formatTanggal(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedCatatan = _filterKategori == 'Semua'
        ? _catatan
        : _catatan.where((c) => c.kategori == _filterKategori).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (val) => setState(() => _filterKategori = val),
            itemBuilder: (context) => [
              'Semua',
              'Kuliah',
              'Tugas',
              'Pribadi',
              'Lainnya',
            ].map((k) => PopupMenuItem(value: k, child: Text(k))).toList(),
          ),
        ],
      ),
      body: displayedCatatan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada catatan.\nTap tombol + untuk menambah.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: displayedCatatan.length,
              itemBuilder: (context, i) {
                final c = displayedCatatan[i];
                return ListTile(
                  title: Text(c.judul),
                  subtitle: Text(
                    '${c.kategori} • ${_formatTanggal(c.dibuatPada)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      final deletedTitle = c.judul;
                      setState(() {
                        _catatan.remove(c);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Catatan "$deletedTitle" dihapus'),
                        ),
                      );
                    },
                  ),
                  onTap: () async {
                    final updated = await Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: c,
                    );
                    if (updated is Catatan) {
                      setState(() {
                        final index = _catatan.indexWhere(
                          (item) => item.id == updated.id,
                        );
                        if (index != -1) _catatan[index] = updated;
                      });
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatan;
  const TambahCatatanPage({super.key, this.catatan});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulCtrl = TextEditingController();
  final _isiCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  String _kategori = 'Kuliah';
  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    if (widget.catatan != null) {
      _judulCtrl.text = widget.catatan!.judul;
      _isiCtrl.text = widget.catatan!.isi;
      _emailCtrl.text = widget.catatan!.email;
      _kategori = widget.catatan!.kategori;
    }
  }

  @override
  void dispose() {
    // PENTING: bebaskan resource controller agar tidak memory leak.
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  // void _simpan() {
  //   if (!_formKey.currentState!.validate()) return;

  //   // Untuk sekarang, hanya tampilkan SnackBar.
  //   // Nanti di Langkah 5 kita kirim data balik ke HomePage.
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text('Tersimpan: ${_judulCtrl.text}')));
  // }
  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final isEdit = widget.catatan != null;
    final catatanBaru = Catatan(
      id: isEdit
          ? widget.catatan!.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(),
      dibuatPada: isEdit ? widget.catatan!.dibuatPada : DateTime.now(),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Tersimpan: ${_judulCtrl.text}')));
    Navigator.pop(context, catatanBaru); // <-- kirim balik!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catatan == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.pushNamed(
                context,
                '/tambah',
                arguments: catatan,
              );
              if (updated != null) {
                Navigator.pop(context, updated); // kirim hasil edit ke HomePage
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catatan.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(catatan.kategori)),
                const SizedBox(width: 8),
                Text(catatan.email, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 32),
            Text(
              catatan.isi,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
