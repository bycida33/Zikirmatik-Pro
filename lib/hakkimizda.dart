import 'package:flutter/material.dart';

class HakkimizdaPage extends StatelessWidget {
  const HakkimizdaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Geri butonuna basıldığında geri gitmek için Navigator'ı kullanabilirsiniz.
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Hakkımızda"),
      ),
      body: const Center(
        child: Text("Zikir Matik 2023 ByCida"),
      ),
    );
  }
}
