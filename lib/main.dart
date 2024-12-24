import 'package:flutter/material.dart';
import 'package:student/screens/home.dart';
import 'package:student/screens/cs.dart';
import 'package:student/screens/it.dart';
import 'package:student/screens/profile.dart';
import 'package:student/screens/sw.dart';
import 'package:student/side_menu/floating_action_button.dart';

void main() async {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Student()));
}

class Student extends StatefulWidget {
  const Student({super.key});
  @override
  State<Student> createState() => _BottomNavState();
}

class _BottomNavState extends State<Student> {
  int index = 0;
  final pages = [const Home(), Cs(), It(), Sw(), Profile()];
  @override
  Widget build(BuildContext context) {
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home");
    return Scaffold(
        body: pages[index],
        floatingActionButton: CustomFloatingActionButton(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: const Color.fromARGB(355, 150, 140, 0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.tealAccent,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 15,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            print('${pages[value]} bottom navigation pressed');
            setState(() {
              index = value;
              // Accessing the selected BottomNavigationBarItem
              //BottomNavigationBarItem selectedItem = items[value];
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.computer), label: "CS"),
            BottomNavigationBarItem(icon: Icon(Icons.memory), label: "IT"),
            BottomNavigationBarItem(icon: Icon(Icons.code), label: "SW")
          ],
        ));
  }
}
