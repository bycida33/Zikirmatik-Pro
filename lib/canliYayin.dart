import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreenMekke extends StatelessWidget {
  static const routeName = '/web';

  final webViewUrlcanli = "https://www.youtube.com/watch?v=K73Qome3hkk"; // Örneğin, bir URL belirtin.

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopUp(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('Canlı Yayın'), // İstediğiniz başlık adını burada ayarlayabilirsiniz.
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: WebView(
          initialUrl: webViewUrlcanli, // webViewUrlcanli'yi kullanın
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  Future<bool> showExitPopUp(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Çıkmak İster Misin?"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hayır'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Evet'),
          ),
        ],
      ),
    ) ??
        false;
  }
}
