import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Not {
  final String tarih;
  String icerik;

  Not(this.tarih, this.icerik);
}

class NotlarPage extends StatefulWidget {
  @override
  _NotlarPageState createState() => _NotlarPageState();
}

class _NotlarPageState extends State<NotlarPage> {
  List<Not> notlar = []; // Notları saklayacak liste
  TextEditingController notDuzenlemeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Uygulama başladığında, telefon hafızasından kaydedilmiş notları yükleyin
    _loadNotlar();
  }

  _loadNotlar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notlar = (prefs.getStringList('notlar') ?? []).map((data) {
        final notData = data.split('|');
        return Not(notData[0], notData[1]);
      }).toList();
    });
  }

  _saveNotlar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notlarData = notlar.map((not) => '${not.tarih}|${not.icerik}').toList();
    await prefs.setStringList('notlar', notlarData);
  }

  _silNotlar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notları Sil'),
          content: Text('Tüm notları silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notlar.clear();
                });
                _saveNotlar(); // Notları sildikten sonra kaydet
                Navigator.pop(context);
              },
              child: Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Defteri'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _silNotlar,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notlar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notlar[index].tarih),
                  subtitle: Text(notlar[index].icerik),
                  onTap: () {
                    // Not düzenlemek için bir diyalog penceresi açın
                    notDuzenlemeController.text = notlar[index].icerik;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Notu Düzenle'),
                          content: Container( // Genişletilmiş not düzenleme ekranı
                            width: 400, // Genişlik ayarını dilediğiniz gibi değiştirebilirsiniz
                            child: TextField(
                              controller: notDuzenlemeController,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('İptal'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  notlar[index].icerik = notDuzenlemeController.text;
                                });
                                _saveNotlar(); // Notları güncelledikten sonra kaydet
                                Navigator.pop(context);
                              },
                              child: Text('Kaydet'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni not eklemek için bir diyalog penceresi açın
          showDialog(
            context: context,
            builder: (context) {
              String yeniNot = ''; // Yeni notunuz
              return AlertDialog(
                title: Text('Yeni Not Ekle'),
                content: Container(
                  height: 345,// Genişletilmiş yeni not ekleme ekranı
                  width: 800, // Genişlik ayarını dilediğiniz gibi değiştirebilirsiniz
                  child: TextField(
                    onChanged: (value) {
                      yeniNot = value;
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (yeniNot.isNotEmpty) {
                        String tarih = DateTime.now().toString();
                        Not yeniNotObje = Not(tarih, yeniNot);
                        setState(() {
                          notlar.add(yeniNotObje);
                        });
                        _saveNotlar(); // Yeni not ekledikten sonra kaydet
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Ekle'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
