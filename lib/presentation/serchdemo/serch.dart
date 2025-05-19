import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Serch extends StatelessWidget {
  const Serch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [

              ],
            )
          ],
        ),
        body: Column(
          children: [
            Text("data")
          ],
        ),
      ),
    );
  }
}
