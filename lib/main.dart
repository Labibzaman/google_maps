import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'locationScreen.dart';
import 'los.dart';

void main(){
  runApp(const GoogleMap());
}

class GoogleMap extends StatelessWidget {
  const GoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
