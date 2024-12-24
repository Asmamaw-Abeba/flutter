import 'package:flutter/material.dart';
import 'package:student/screens/Cs.dart';
import 'package:student/screens/custom_app_bar.dart';
import 'package:student/side_menu/nav_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "Asmamaw";
    return Scaffold(
      drawer: const NavBar(),
      appBar: CustomAppBar(context, "Home page"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name this is home page",
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
            //       MaterialPageRoute(builder: (context) => Cs()),
            //     );
            //   },
            //   //style: customButtonStyle(),
            //   child: const Text('Go to Computer Science'),
            // ),
          ],
        ),
      ),
    );
  }
}
