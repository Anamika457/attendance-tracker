import 'package:flutter/material.dart';
import 'package:attendance_tracker/main.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {

    String name = "John Doe";
    String gender = "Male";
    String session = "1";
    String checkIn = "9:00 AM";
    String checkOut = "5:00 PM";

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
                        'Gender: $gender',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Session: $session',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Check-in: $checkIn',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Check-out: $checkOut',
                        style: const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40), 
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
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
