import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IletisimPage extends StatelessWidget {
  const IletisimPage({Key? key}) : super(key: key);

  final String email = 'yazilimmersin@gmail.com';
  final String phoneNumber = '+905535728749';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("İletişim"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("R10.net: Bycida, Facebook: Serkan Karamsar"),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _sendEmail(email);
              },
              child: Text(
                "E-posta: yazilimmersin@gmail.com\nTelefon: 0000000000000000",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail(String email) async {
    final String emailUrl = 'mailto:$email';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}
