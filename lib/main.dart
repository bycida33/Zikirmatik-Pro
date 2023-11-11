import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uygulama_yapisi/pusula.dart';
import 'package:uygulama_yapisi/yanmenu.dart';
import 'canliYayin.dart';
import 'tanitim.dart';
import 'notlar.dart';
import 'radyo.dart';
import 'package:flutter/services.dart';
import 'package:uygulama_yapisi/notifications.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: TanitimPage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationService _notificationService = NotificationService();
  int sayac = 0;
  List<String> resimListesi = [
    "assets/dua.jpg",
    "assets/dua2.jpg",
    "assets/dua3.jpg",
    "assets/dua4.jpg",
    "assets/dua5.jpg",
    "assets/dua6.jpg",
    "assets/dua7.jpg",
    "assets/dua8.jpg",
    "assets/dua9.jpg",
    "assets/dua10.jpg",
  ];
  late String rastgeleResim;
  List<int> kaydedilenSayilar = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    rastgeleResim = rastgeleResimSec();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _notificationService.initialize();
    _notificationService.scheduleDailyNotification();
  }

  String rastgeleResimSec() {
    final rastgele = Random();
    return resimListesi[rastgele.nextInt(resimListesi.length)];
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Çıkış Yap",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Çıkış yapmak istediğinizden emin misiniz?",
            style: TextStyle(color: Colors.purple),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                _initializeNotifications();
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  void _openEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'yazilimmersin@gmail.com',
      queryParameters: {'subject': 'Reklam İşbirliği'},
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      print('E-posta uygulaması başlatılamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Zikir Matik"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YanMenu(title: 'Başla')),
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.navigation),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KiblahFinderApp(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.note),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotlarPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showExitDialog();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(rastgeleResim, height: 310, width: 310),
            SizedBox(
              height: 2,
              width: 2,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(200, 60)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                )),
              ),
              onPressed: () {
                setState(() {
                  sayac = sayac + 1;
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Zikir Et",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Çekilen Zikir: $sayac",
              style: const TextStyle(
                fontSize: 23,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                )),
              ),
              child: const Text(
                "Sıfırla ve Kaydet",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () {
                if (sayac > 0) {
                  setState(() {
                    kaydedilenSayilar.add(sayac);
                    sayac = 0;
                  });
                }
              },
            ),
            Spacer(),
            Text("Kaydedilen Zikirler: ${kaydedilenSayilar.join(', ')}",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13))),
              ),
              child: const Text(
                "Kayıtları Sil",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  kaydedilenSayilar.clear();
                });
              },
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const SizedBox(height: 1, width: 0),
            GestureDetector(
              onTap: _openEmail,
              child: Image.asset("assets/reklamgorsel.png",
                  height: 35, width: 900),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Zikir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: 'Radyo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Mekke',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebScreen()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebScreenMekke()),
              );
            }
          });
        },
      ),
    );
  }
}
