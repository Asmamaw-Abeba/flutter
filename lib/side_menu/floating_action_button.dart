import 'package:flutter/material.dart';
import 'package:student/forms/add_student.dart';

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showAddStudentForm(context);
      },
      icon: const Icon(Icons.add),
      label: const Text("Add Student"),
      backgroundColor: const Color.fromARGB(255, 116, 94, 241),
    );
  }
}
