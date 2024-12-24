import 'package:flutter/material.dart';
import 'package:student/screens/sw.dart';
import 'package:student/screens/custom_app_bar.dart';

// ignore: use_key_in_widget_constructors
class It extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Asmamaw";
    return Scaffold(
      appBar: CustomAppBar(context, 'Information Technology Screen'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name this is IT page",
              textDirection: TextDirection.ltr,
              // decoration on widget
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Sw()),
            //     );
            //   },
            //   child: const Text('Go to Software Engineering'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Back to Computer Science'),
            // ),
          ],
        ),
      ),
    );
  }
}
