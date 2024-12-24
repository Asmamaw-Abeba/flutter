import 'package:flutter/material.dart';

void showAddStudentForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedDepartment;
  String _resultText = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add New Student'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Select Department'),
                      items: [
                        const DropdownMenuItem(
                            value: 'Computer Science',
                            child: const Text('Computer Science')),
                        const DropdownMenuItem(
                            value: 'Information Technology',
                            child: const Text('Information Technology')),
                        const DropdownMenuItem(
                            value: 'Software Engineering',
                            child: const Text('Software Engineering')),
                      ],
                      onChanged: (value) {
                        _selectedDepartment = value;
                      },
                      validator: (value) =>
                          value == null ? 'Please select a department' : null,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter first name' : null,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter last name' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter email' : null,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter phone number' : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _resultText,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Clear'),
                onPressed: () {
                  _firstNameController.clear();
                  _lastNameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  setState(() {
                    _resultText = '';
                  });
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Access the controller values here
                    String department = _selectedDepartment ?? '';
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String email = _emailController.text;
                    String phone = _phoneController.text;
                    setState(() {
                      _resultText =
                          'This data will store to database for next tasks.\nDepartment: $department\nFirst Name: $firstName\nLast Name: $lastName\nEmail: $email\nPhone: $phone';
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}
