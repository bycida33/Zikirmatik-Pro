import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class TanitimPage extends StatefulWidget {
  @override
  _TanitimPageState createState() => _TanitimPageState();
}

class _TanitimPageState extends State<TanitimPage> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Hoş Geldiniz',
      'description': 'Burada Zikir Çekebilirsiniz, Radyo Dinleyebilirsiniz,.',
      'image': 'assets/page1.gif', // Tanıtım sayfasının resmi
    },
    {
      'title': 'Diğer Özelliklerimiz',
      'description': 'Canlı Yayın Mekke-İ Mükerremi İzleyebilirsiniz, Notlar Oluşturun Kıble Bulucuyu Kullanın.',
      'image': 'assets/page2.png',
    },
    // Daha fazla sayfa eklemek için aynı formatta bir map ekleyebilirsiniz.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _buildPage(_pages[index]);
        },
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
        floatingActionButton: _currentPage < _pages.length - 1
            ? FloatingActionButton(
          onPressed: () {
            _controller.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: Icon(Icons.arrow_forward),
        )
            : (_currentPage == _pages.length - 1)
            ? ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Başla')),
            );
          },
          child: Text('Başla'),
        )
            : null,
    );
  }

  Widget _buildPage(Map<String, String> page) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page['image']!, height: 300, width: 300),
          SizedBox(height: 20),
          Text(
            page['title']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            page['description']!,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 23,width: 23,),
          if (_currentPage == 0)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Tanıtımı Geç')),
                );
              },
              child: Text('Tanıtımı Geç'),
            ),
        ],
      ),
    );
  }
}
