import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    // Bagian judul (title section)
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
          Icon(Icons.star, color: Colors.red),
          const Text('41'),
        ],
      ),
    );

    // Bagian tombol (button section)
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    // Bagian teks (text section)
    Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: const Text(
    'Gunung Rinjani adalah gunung berapi tertinggi kedua di Indonesia, '
    'yang terletak di Pulau Lombok, Nusa Tenggara Barat. '
    'Gunung ini memiliki ketinggian sekitar 3.726 meter di atas permukaan laut '
    'dan terkenal dengan pemandangan indah Danau Segara Anak yang berada di kalderanya. '
    'Selain menjadi destinasi favorit para pendaki, Gunung Rinjani juga memiliki nilai spiritual '
    'dan budaya bagi masyarakat setempat. '
    'Keindahan alam, udara sejuk, serta tantangan pendakiannya menjadikan Rinjani '
    'salah satu gunung paling menakjubkan di Indonesia.\n\n'
    'Oleh: Reika Amalia S\n'
    '2341720173',
    softWrap: true,
  ),
);


    // Tampilan utama
    return MaterialApp(
      title: 'Flutter layout: Reika Amalia S - 2341720173',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
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
          ],
        ),
      ),
      );
  }
}
