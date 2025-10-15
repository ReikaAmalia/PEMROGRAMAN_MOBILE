import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Reusable method untuk membuat tombol
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bagian judul
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Wisata Gunung Rinjani',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Lombok, Nusa Tenggara Barat',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.red),
          const Text('41'),
        ],
      ),
    );

    // Bagian tombol
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    // Bagian teks
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Gunung Rinjani adalah gunung berapi tertinggi kedua di Indonesia, '
        'yang terletak di Pulau Lombok, Nusa Tenggara Barat. '
        'Gunung ini memiliki ketinggian sekitar 3.726 meter di atas permukaan laut '
        'dan terkenal dengan pemandangan indah Danau Segara Anak yang berada di kalderanya. '
        'Selain menjadi destinasi favorit para pendaki, Gunung Rinjani juga memiliki nilai spiritual '
        'dan budaya bagi masyarakat setempat.\n\n'
        'Berikut beberapa tempat menarik di sekitar kawasan Rinjani:',
        softWrap: true,
      ),
    );

    // 🔹 Tambahan konsep dari Flutter Docs: "Use Lists" (ListView dengan ListTile)
    Widget listWisata = Column(
      children: const [
        ListTile(
          leading: Icon(Icons.terrain, color: Colors.green),
          title: Text('Puncak Rinjani'),
          subtitle: Text('Puncak tertinggi dengan panorama sunrise yang menakjubkan.'),
        ),
        ListTile(
          leading: Icon(Icons.water, color: Colors.blue),
          title: Text('Danau Segara Anak'),
          subtitle: Text('Danau kaldera berwarna biru muda di tengah pegunungan.'),
        ),
        ListTile(
          leading: Icon(Icons.spa, color: Colors.orange),
          title: Text('Air Panas Aik Kalak'),
          subtitle: Text('Sumber air panas alami yang dipercaya menyembuhkan penyakit.'),
        ),
        ListTile(
          leading: Icon(Icons.forest, color: Colors.brown),
          title: Text('Hutan Senaru'),
          subtitle: Text('Hutan tropis lebat dengan jalur pendakian populer.'),
        ),
      ],
    );

    // 🔹 Tampilan utama aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter layout: Reika Amalia S - 2341720173',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Layout Demo'),
          backgroundColor: Colors.green,
        ),
        body: ListView(
          children: [
            Image.asset(
              'image/Rinjani2.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            listWisata, // 👉 list tambahan yang diambil dari konsep "Use lists"
          ],
        ),
      ),
    );
  }
}
