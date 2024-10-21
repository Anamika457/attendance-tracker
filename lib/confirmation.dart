import 'package:flutter/material.dart';
import 'package:attendance_tracker/main.dart';

class ConfirmationPage extends StatelessWidget {
  final String message;
  final String name;
  final String rollNo;
  final String gender;
  final String email;
  final String sessionName;

  const ConfirmationPage({super.key, 
    required this.message,
    required this.name,
    required this.rollNo,
    required this.gender,
    required this.email,
    required this.sessionName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.amber,
        ),
        title: const Text(
          'Confirmation',
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: $name',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Roll No: $rollNo',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Gender: $gender',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email: $email',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Session: $sessionName',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      Text(
                        'Status: $message',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
