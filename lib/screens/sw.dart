import 'package:flutter/material.dart';
import 'package:student/screens/custom_app_bar.dart';

// ignore: use_key_in_widget_constructors
class Sw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Asmamaw";
    return Scaffold(
      appBar: CustomAppBar(context, 'Software Engineering Screen'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name this is SW page",
              textDirection: TextDirection.ltr,
              // decoration on widget
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Back to Information Technology'),
            // ),
          ],
        ),
      ),
    );
  }
}
