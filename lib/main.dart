import 'package:flutter/material.dart';
import 'package:attendance_tracker/scanner.dart'; 
import 'package:flutter/services.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance!.imageCache!.maximumSize = 100;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        primaryColor: Colors.amber,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.amber,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedValue;

  final Map<String, String> sessionMap = {
    'Session 1': '1',
    'Session 2': '2',
    'Session 3': '3',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Attendance Tracker',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedValue,
              hint: const Text(
                'Select Session',
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
              dropdownColor: Colors.black,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.amber),
              items: sessionMap.keys.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.amber),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
            ),
            const SizedBox(height: 120),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: selectedValue != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScanPage(
                              sessionId: sessionMap[selectedValue!]!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Go to QR Scanner',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
