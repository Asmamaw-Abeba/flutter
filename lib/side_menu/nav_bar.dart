import 'package:flutter/material.dart';
//import 'package:student/screens/profile.dart';
import 'package:student/screens/cs.dart';
import 'package:student/screens/home.dart';

import 'package:student/screens/profile.dart';
import 'package:student/screens/setting.dart';
import 'package:student/screens/help.dart';
import 'package:student/screens/about.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Asmamaw Abeba"),
            accountEmail: const Text("asmeabeba12@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/profile.png"),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("profile"),
            //onTap: () => print("setting clicked"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("setting"),
            //onTap: () => print("setting clicked"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help"),
            //onTap: () => print("Help clicked"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Help()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("About Developer"),
            //onTap: () => print("About developer clicked"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          )
        ],
      ),
    );
  }
}
