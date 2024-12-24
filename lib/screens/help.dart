import 'package:flutter/material.dart';
//import 'package:student/screens/It.dart';
import 'package:student/screens/custom_app_bar.dart';

// ignore: use_key_in_widget_constructors
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Asmamaw";
    return Scaffold(
      appBar: CustomAppBar(context, 'help screen'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name this is Help page",
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
            //       MaterialPageRoute(builder: (context) => It()),
            //     );
            //   },
            //   child: const Text('Go to Information Technology'),
            // ),
            // const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Back to Home'),
            // ),
          ],
        ),
      ),
    );
  }
}
