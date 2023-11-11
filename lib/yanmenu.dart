import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hakkimizda.dart';
import 'iletisim.dart';

class YanMenu extends StatelessWidget {
  const YanMenu({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menü'), // App bar başlığını burada değiştirebilirsiniz
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Hakkımızda'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HakkimizdaPage()),
              );
            },
          ),
          ListTile(
            title: const Text('İletişim'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IletisimPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Bize Puan Ver'),
            onTap: () {
              launch('https://www.google.com/'); // URL'yi gerçek bir URL ile değiştirin
            },
          ),
        ],
      ),
    );
  }
}
