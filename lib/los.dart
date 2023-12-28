import 'package:flutter/material.dart';

class Myak extends StatefulWidget {
  const Myak({super.key});

  @override
  State<Myak> createState() => _MyakState();
}

class _MyakState extends State<Myak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
    );
  }
}
